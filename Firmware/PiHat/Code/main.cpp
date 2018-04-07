
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

#define spiBufferSize  512
static uint8_t spiBuffer[spiBufferSize];

#define STATE_INITIAL	0
#define STATE_READING	1

int state = STATE_INITIAL;
bool flagSpiDataReceived = false;
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

	while (1)
	{
		if (flagSpiDataReceived)
		{
			SPI1->CR1 &= ~SPI_CR1_SPE;			// disable SPI
			DMA1_Channel2->CCR &= ~DMA_CCR_EN;	// disable DMI
			
			GPIOB->BRR |= PIN_READY_TO_WRITE;
			GPIOB->BRR |= PIN_READY_TO_READ;
			
			ProcessIncoming();
			
			flagSpiDataReceived = false;
		}
		
		switch (state)
		{
		case STATE_INITIAL:
			GPIOB->BRR |= PIN_READY_TO_WRITE;
			GPIOB->BSRR |= PIN_READY_TO_READ;
	
			StartSpiDmaRead(spiBuffer, spiBufferSize);
			state = STATE_READING;
			break;
			
		case STATE_READING:
			// nothing. DMA is doing its job.
			break;
		}
	}
}

void ProcessIncoming() {
	
}

void _Error_Handler(const char * file, int line)
{
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
