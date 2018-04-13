

/* Includes ------------------------------------------------------------------*/
#include "spi.h"

#include "gpio.h"
#include "dma.h"

SPI_HandleTypeDef hspi1;
DMA_HandleTypeDef hdma_spi1_rx;
DMA_HandleTypeDef hdma_spi1_tx;

void HandleSpiRx() {
}

void EnableSpi()
{
	
}

void StartSpiDmaRead(char* dataRx, uint32_t bufferSize) {
	//RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;					// enable SPI clock
	SPI1->CR1 |= SPI_CR1_SPE;							// enable SPI
	
	DMA1->IFCR = DMA_FLAG_GL2;							// clear flags
	DMA1_Channel2->CNDTR = bufferSize;					// set buffer size
	DMA1_Channel2->CPAR = (uint32_t)(&(SPI1->DR));		// SPI register address
	DMA1_Channel2->CMAR = (uint32_t)(dataRx);			// memory address
	DMA1_Channel2->CCR |= DMA_CCR_EN;  					// start
}

void StartSpiDmaWrite(char* dataTx, uint32_t bufferSize) {
	//RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;					// enable SPI clock
	SPI1->CR1 |= SPI_CR1_SPE;							// enable SPI
	
	DMA1->IFCR = DMA_FLAG_GL3;							// clear flags
	DMA1_Channel3->CNDTR = bufferSize;					// set buffer size
	DMA1_Channel3->CPAR = (uint32_t)(&(SPI1->DR));		// SPI register address
	DMA1_Channel3->CMAR = (uint32_t)(dataTx);			// memory address
	DMA1_Channel3->CCR |= DMA_CCR_EN;  					// start
}

/* SPI1 init function */
void MX_SPI1_Init(void) {
  
	/**SPI1 GPIO Configuration    
	PA4     ------> SPI1_NSS
	PA5     ------> SPI1_SCK
	PA6     ------> SPI1_MISO
	PA7     ------> SPI1_MOSI 
	*/
	
	RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;		// enable SPI clock
	SPI1->CR2 |= SPI_CR2_FRXTH;				// FIFO threshold = 8 bit
	SPI1->CR2 |= SPI_CR2_RXDMAEN;			// enable RX DMA
	SPI1->CR2 |= SPI_CR2_TXDMAEN;			// enable TX DMA
	
	// configure pins
	
	GPIO_InitTypeDef GPIO_InitStruct;
	GPIO_InitStruct.Pin = GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF0_SPI1;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

		/* SPI1 DMA Init */
		/* SPI1_RX Init */
	hdma_spi1_rx.Instance = DMA1_Channel2;
	hdma_spi1_rx.Init.Direction = DMA_PERIPH_TO_MEMORY;
	hdma_spi1_rx.Init.PeriphInc = DMA_PINC_DISABLE;
	hdma_spi1_rx.Init.MemInc = DMA_MINC_ENABLE;
	hdma_spi1_rx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
	hdma_spi1_rx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
	hdma_spi1_rx.Init.Mode = DMA_NORMAL;
	hdma_spi1_rx.Init.Priority = DMA_PRIORITY_HIGH;
	if (HAL_DMA_Init(&hdma_spi1_rx) != HAL_OK)
	{
		_Error_Handler(__FILE__, __LINE__);
	}

    /* SPI1_TX Init */
	hdma_spi1_tx.Instance = DMA1_Channel3;
	hdma_spi1_tx.Init.Direction = DMA_MEMORY_TO_PERIPH;
	hdma_spi1_tx.Init.PeriphInc = DMA_PINC_DISABLE;
	hdma_spi1_tx.Init.MemInc = DMA_MINC_ENABLE;
	hdma_spi1_tx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
	hdma_spi1_tx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
	hdma_spi1_tx.Init.Mode = DMA_NORMAL;
	hdma_spi1_tx.Init.Priority = DMA_PRIORITY_HIGH;
	if (HAL_DMA_Init(&hdma_spi1_tx) != HAL_OK)
	{
		_Error_Handler(__FILE__, __LINE__);
	}

	// SPI1 interrupt Init
	HAL_NVIC_SetPriority(SPI1_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(SPI1_IRQn);
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef* spiHandle) {

  if(spiHandle->Instance==SPI1)
  {
  /* USER CODE BEGIN SPI1_MspDeInit 0 */

  /* USER CODE END SPI1_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_SPI1_CLK_DISABLE();
  
    /**SPI1 GPIO Configuration    
    PA4     ------> SPI1_NSS
    PA5     ------> SPI1_SCK
    PA6     ------> SPI1_MISO
    PA7     ------> SPI1_MOSI 
    */
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7);

    /* SPI1 DMA DeInit */
    HAL_DMA_DeInit(spiHandle->hdmarx);

    /* SPI1 interrupt Deinit */
    HAL_NVIC_DisableIRQ(SPI1_IRQn);
  /* USER CODE BEGIN SPI1_MspDeInit 1 */

  /* USER CODE END SPI1_MspDeInit 1 */
  }
} 
