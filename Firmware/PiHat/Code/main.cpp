
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

#define usartReadTimeout	10										// this many ms before give up listening
#define maxLineLength		10
#define spiBufferSize		512
static char spiInBuffer[spiBufferSize] = { 0 };
static char spiOutBuffer[spiBufferSize] = { 0 };
char* inp;
char* outp;

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
	MX_I2C1_Init();
	MX_SPI1_Init();
	MX_USART1_UART_Init();
	MX_ADC_Init();

	GPIOB->BRR |= PIN_READY_TO_RESPOND;					// clear respond flag
	GPIOB->BSRR |= PIN_READY_TO_RECEIVE;				// raize receive flag
	
	StartSpiDmaRead(spiInBuffer, spiBufferSize);
	state = STATE_RECEIVING;
	
	while (1)
	{
		if (flagSpiFrameReceived)
		{
			if (state == STATE_RECEIVING)
			{
				// master has finished sending command
				
				SPI1->CR1 &= ~SPI_CR1_SPE;				// disable SPI
				DMA1_Channel2->CCR &= ~DMA_CCR_EN;		// disable receive DMI
			
				GPIOB->BRR |= PIN_READY_TO_RESPOND;		// off both flags
				GPIOB->BRR |= PIN_READY_TO_RECEIVE;
			
				ProcessIncoming();
			
				//RCC->APB2ENR &= ~RCC_APB2ENR_SPI1EN;	// disable SPI clock
				//RCC->APB2ENR |= RCC_APB2RSTR_SPI1RST;
				//RCC->APB2ENR &= ~RCC_APB2RSTR_SPI1RST;				
				//MX_SPI1_Init();
					
				StartSpiDmaWrite(spiOutBuffer, outp - spiOutBuffer);
				
				GPIOB->BSRR |= PIN_READY_TO_RESPOND;	// signal ready to respond
				
				state = STATE_RESPONDING;
			}
			else
			{
				// master has finished reading SPI buffer
								
				SPI1->CR1 &= ~SPI_CR1_SPE;				// disable SPI
				DMA1_Channel3->CCR &= ~DMA_CCR_EN;		// disable respond DMI
				
				//RCC->APB2ENR &= ~RCC_APB2ENR_SPI1EN;	// disable SPI clock
				//RCC->APB2ENR |= RCC_APB2RSTR_SPI1RST;
				//RCC->APB2ENR &= ~RCC_APB2RSTR_SPI1RST;
				//MX_SPI1_Init();
				
				StartSpiDmaRead(spiInBuffer, spiBufferSize);
				
				GPIOB->BRR |= PIN_READY_TO_RESPOND;		// clear respond flag
				GPIOB->BSRR |= PIN_READY_TO_RECEIVE;	// raize receive flag
	
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
////			StartSpiDmaRead(spiInBuffer, spiBufferSize);
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
void WriteByte(uint8_t byte){
	*outp++ = '0' + (byte >> 4) & 0x0F;
}
bool ReadByte(uint8_t* output) {
	uint8_t b1;
	uint8_t b2;
	
	*output = 0;
	
	if (*inp >= '0' && *inp <= '9') b1 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b1 = *inp - 'A';
	else if (*inp >= 'a' && *inp <= 'f') b1 = *inp - 'a';
	else return false;
	
	inp++;
		
	if (*inp >= '0' && *inp <= '9') b2 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b2 = *inp - 'A';
	else if (*inp >= 'a' && *inp <= 'f') b2 = *inp - 'a';
	else return false;
	
	inp++;

	*output = (b1 << 4) | b2;
	return true;
}
void ToEndOfLine(){
	while (*inp && *inp != '\r' && *inp != '\n' && (inp - spiInBuffer < spiBufferSize)) inp++;
}

void UsartTransaction(int n, uint8_t* buffer, uint32_t len) {
	buffer[0] = n;													// first byte is the ID of the recipient
	
	// send
	
//	for (int i = 0; i < len; i++)
//	{
//		while ((USART1->ISR & USART_ISR_TC) != USART_ISR_TC) {}		// wait till end of transmission
//		USART1->TDR = buffer[i];
//	}
	
	StartUsartDmaWrite(buffer, len);
	
	// receive
	
	uint32_t firstTick = uwTick;
	uint8_t inBuffer[4];
	
	for (int i = 0; i < 4; i++)
	{
		if (uwTick - firstTick > usartReadTimeout)
		{
			Output("timeout\r\n");
			return;
		}
		
		if ((USART1->ISR & USART_ISR_RXNE) == USART_ISR_RXNE)
		{
			inBuffer[i] = (uint8_t)(USART1->RDR);
		}
	}
	
	if (inBuffer[0] == 0 &&											// to main controller (this)
		inBuffer[1] == n)											// from ID=n
	{
		WriteByte(inBuffer[2]);
		WriteByte(inBuffer[3]);
		Output("\r\n");
	}
	else
	{
		Output("communication error\r\n");
	}
}

void ProcessIncoming() {
	inp = spiInBuffer;
	outp = spiOutBuffer;

	uint8_t buffer[maxLineLength];
	int line = 0;
	int col = 1;
	uint8_t b = 0;
	
	while (*inp && (inp - spiInBuffer < spiBufferSize))
	{
		if (*inp == '\n') 
		{
			line++;
			inp++;
			
			UsartTransaction(line, buffer, col);
			col = 1;
		}
		
		if (*inp == '\r') 
		{
			inp++;
			continue;
		}
		
		if (ReadByte(&b)) 
		{
			if (col < maxLineLength - 1)
				buffer[col++] = b;
		}
		else
		{
			Output("parse error\r\n");
			ToEndOfLine();
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
