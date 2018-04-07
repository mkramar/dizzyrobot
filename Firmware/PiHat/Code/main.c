
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
uint8_t spiBuffer[spiBufferSize];

void StateSpiAcceptCommand();

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
		StateSpiAcceptCommand();
	}
}

void StateSpiAcceptCommand()
{
	// set "ready to read" pin
	
	GPIOB->BRR |= PIN_READY_TO_WRITE;
	GPIOB->BSRR |= PIN_READY_TO_READ;
	
	StartSpiDmaRead(spiBuffer, spiBufferSize);
}

void _Error_Handler(char * file, int line)
{
	while (1) 
	{
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
