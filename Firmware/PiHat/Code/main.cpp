
/* Includes ------------------------------------------------------------------*/
#include "main.h"
#include "stm32f0xx_hal.h"
#include "adc.h"
#include "dma.h"
#include "i2c.h"
#include "spi.h"
#include "usart.h"
#include "gpio.h"
#include "clock.h"

extern __IO uint32_t uwTick;

//#define PARSE_ERROR		0
//#define PARSE_OK		1
//#define PARSE_END		2

volatile char spiInBuffer[spiBufferSize] = { 0 };
volatile char spiOutBuffer[spiBufferSize] = { 0 };

volatile char usartInBuffer[usartBufferSize] = { 0 };
volatile char usartOutBuffer[usartBufferSize] = { 0 };

volatile char* inp;
volatile char* outp;

#define STATE_INITIAL	0
#define STATE_RECEIVING	1
#define STATE_RESPONDING	2

int state = STATE_INITIAL;
bool flagSpiFrameReceived = false;
void ProcessIncoming();

int main(void)
{
	HAL_Init();

	SystemClock_Config();

	MX_GPIO_Init();
	MX_DMA_Init();
	//MX_I2C1_Init();
	MX_SPI1_Init();
	MX_USART1_UART_Init();
	//MX_ADC_Init();

	GPIOB->BRR |= PIN_READY_TO_RESPOND;					// clear respond flag
	GPIOB->BSRR |= PIN_READY_TO_RECEIVE;				// raize receive flag
	
	ScheduleSpiDmaRead();
	state = STATE_RECEIVING;
	
	while (1)
	{
		if (flagSpiFrameReceived)
		{
			SPI1->CR1 &= ~SPI_CR1_SPE;					// disable SPI
			SPI1->CR2 &= ~SPI_CR2_RXDMAEN;
			SPI1->CR2 &= ~SPI_CR2_TXDMAEN;
			
			DMA1_Channel2->CCR &= ~DMA_CCR_EN;			// disable receive DMI
			DMA1_Channel3->CCR &= ~DMA_CCR_EN;			// disable respond DMI
			
			if (state == STATE_RECEIVING)
			{
				// master has finished sending command
				
				GPIOB->BRR |= PIN_READY_TO_RESPOND;		// off both LEDs
				GPIOB->BRR |= PIN_READY_TO_RECEIVE;
			
				ProcessIncoming();
			
				//RCC->APB2ENR &= ~RCC_APB2ENR_SPI1EN;	// disable SPI clock
				//RCC->APB2ENR |= RCC_APB2RSTR_SPI1RST;
				//RCC->APB2ENR &= ~RCC_APB2RSTR_SPI1RST;				
				//MX_SPI1_Init();
					
				ScheduleSpiDmaWrite(outp - spiOutBuffer);
				
				GPIOB->BSRR |= PIN_READY_TO_RESPOND;	// signal ready to respond
				
				state = STATE_RESPONDING;
			}
			else
			{
				// master has finished reading SPI buffer
								
				//RCC->APB2ENR &= ~RCC_APB2ENR_SPI1EN;	// disable SPI clock
				//RCC->APB2ENR |= RCC_APB2RSTR_SPI1RST;
				//RCC->APB2ENR &= ~RCC_APB2RSTR_SPI1RST;
				//MX_SPI1_Init();
				
				ScheduleSpiDmaRead();
				
				GPIOB->BRR |= PIN_READY_TO_RESPOND;		// clear respond LED
				GPIOB->BSRR |= PIN_READY_TO_RECEIVE;	// raize receive LED
	
				state = STATE_RECEIVING;
			}
			
			flagSpiFrameReceived = false;
		}
		
//		switch (state)
//		{
//		case STATE_INITIAL:
////			GPIOB->BRR |= PIN_READY_TO_RESPOND;
////			GPIOB->BSRR |= PIN_READY_TO_RECEIVE;
////	
////			ScheduleSpiDmaRead(spiInBuffer, spiBufferSize);
////			state = STATE_RECEIVING;
//			break;
//			
//		case STATE_RECEIVING:
//			// nothing. DMA is doing its job.
//			break;
//		}
	}
}

void Output(const char *src){
	const char *p = src;
	char ch;
	do {
		*outp++ = ch = *p++;
	} while (ch && (outp - spiOutBuffer) < spiBufferSize);
}
void OutputUsartLine() {
	const char *p = (const char*)usartInBuffer;
	char ch;
	do {
		*outp++ = ch = *p++;
	} while (ch && ch != '\n' && (p - usartInBuffer) < usartBufferSize && (outp - spiOutBuffer) < spiBufferSize);
}
void WriteByte(uint8_t byte){
	uint8_t b1 = (byte >> 4) & 0x0F;
	uint8_t b2 = byte & 0x0F;
	
	if (b1 <= 9) *outp++ = '0' + b1;
	else *outp++ = '7' + b1;
	
	if (b2 <= 9) *outp++ = '0' + b2;
	else *outp++ = '7' + b2;
}
bool ReadByte(uint8_t* output) {
	uint8_t b1;
	uint8_t b2;
	
	*output = 0;
	
	if (*inp >= '0' && *inp <= '9') b1 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b1 = *inp - '7';
	else if (*inp >= 'a' && *inp <= 'f') b1 = *inp - 'a';
	else return false;
	
	inp++;
		
	if (*inp >= '0' && *inp <= '9') b2 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b2 = *inp - '7';
	else if (*inp >= 'a' && *inp <= 'f') b2 = *inp - 'a';
	else return false;
	
	inp++;

	*output = (b1 << 4) | b2;
	return true;
}
void ToEndOfLine(){
	while (*inp && *inp != '\r' && *inp != '\n' && (inp - spiInBuffer < spiBufferSize)) inp++;
}

void UsartTransaction(uint32_t length) {
	USART1->CR1 |= USART_CR1_UE;			// enable USART	
	
	// send
	
	ScheduleUsartDmaWrite(length);
	while ((USART1->ISR & USART_ISR_TC) != USART_ISR_TC) {}			// wait till end of transmission
	USART1->ICR |= USART_ICR_TCCF;									// clear transmission complete flag
		
	// receive
	
	ScheduleUsartDmaRead();
	
	uint32_t firstTick = uwTick;
	
	bool success = true;
	while (!usartResponseReceived)
	{
		if (uwTick - firstTick > usartReadTimeout)
		{
			success = false;
			break;
		}
	}
	
	USART1->CR1 &= ~USART_CR1_UE;			// disable USART	
	
//	BlockingUsartWrite(length);
//	bool success = BlockingUsartRead();
	
	if (success) OutputUsartLine();
	else Output("timeout\n");
}

void ProcessIncoming() {
	inp = spiInBuffer;
	outp = spiOutBuffer;

	int col = 0;
	uint8_t b = 0;
	
	while (*inp && (inp - spiInBuffer < spiBufferSize) && (col < usartBufferSize - 1))
	{
		if (*inp == '\r') 
		{
			inp++;
			continue;
		}
		
		usartOutBuffer[col++] = *inp++;
		
		if (*inp == '\n') 
		{
			usartOutBuffer[col++] = '\n';

			UsartTransaction(col);
			col = 0;
			
			continue;
		}		
	}
}

void _Error_Handler(const char * file, int line){
	while (1) 
	{
		asm("bkpt 255");
	}
}

#ifdef USE_FULL_ASSERT

/**
   * @brief Reports the name of the source file and the source line number
   * where the assert_param error has occurred.
   * @param file: pointer to the source file name
   * @param line: assert_param error line source number
   * @retval None
   */
void assert_failed(uint8_t* file, uint32_t line)
{
  /* USER CODE BEGIN 6 */
  /* User can add his own implementation to report the file name and line number,
    ex: printf("Wrong parameters value: file %s on line %d\r\n", file, line) */
  /* USER CODE END 6 */

}

#endif
