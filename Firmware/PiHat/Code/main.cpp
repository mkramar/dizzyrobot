
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

//#define PARSE_ERROR		0
//#define PARSE_OK		1
//#define PARSE_END		2

#define spiBufferSize  512
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
bool GetByte(char* output){
	char b1;
	char b2;
	
	*output = 0;
	
	if (*inp >= '0' && *inp <= '9') b1 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b1 = *inp - 'A';
	else if (*inp >= 'a' && *inp <= 'f') b1 = *inp - 'a';
	else return false;
		
	if (*inp >= '0' && *inp <= '9') b1 = *inp - '0';
	else if (*inp >= 'A' && *inp <= 'F') b1 = *inp - 'A';
	else if (*inp >= 'a' && *inp <= 'f') b1 = *inp - 'a';
	else return false;

	*output = (b1 << 4) | b2;
	return true;
}
void ToEndOfLine(){
	while (*inp && *inp != '\r' && *inp != '\n' && (inp - spiInBuffer < spiBufferSize)) inp++;
}
void ProcessIncoming() {
	inp = spiInBuffer;
	outp = spiOutBuffer;

	char buffer[10];
	int line = 0;
	char b = 0;
	
	while (*inp && (inp - spiInBuffer < spiBufferSize))
	{
		if (*inp == '\n') line++;
		if (*inp == '\r') 
		{
			inp++;
			continue;
		}
		
		if (!GetByte(&b)) 
		{
			Output("parse error\r\n");
			ToEndOfLine();
			continue;
		}
		
		inp++;
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
