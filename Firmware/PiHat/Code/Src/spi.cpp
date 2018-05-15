

/* Includes ------------------------------------------------------------------*/
#include "spi.h"

#include "gpio.h"
#include "dma.h"

//SPI_HandleTypeDef hspi1;
//DMA_HandleTypeDef hdma_spi1_rx;
//DMA_HandleTypeDef hdma_spi1_tx;



void ScheduleSpiDmaRead() {
	//RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;				// enable SPI clock
	
	while (SPI1->SR & SPI_SR_RXNE) {READ_REG(SPI1->DR);}// clear any pending input
	//while (SPI1->SR & SPI_SR_BSY) {}
	
	DMA1_Channel2->CCR &= ~DMA_CCR_EN;					// disable DMA to set registers
	DMA1_Channel2->CCR &= ~DMA_CCR_DIR;					// peripheral to memory
	DMA1->IFCR = DMA_FLAG_GL2;							// clear flags
	DMA1_Channel2->CNDTR = spiBufferSize;				// set buffer size
	DMA1_Channel2->CPAR = (uint32_t)(&(SPI1->DR));		// SPI register address
	DMA1_Channel2->CMAR = (uint32_t)(spiInBuffer);		// memory address
	DMA1_Channel2->CCR |= DMA_CCR_EN;  					// start DMA
	SPI1->CR1 |= SPI_CR1_SPE;							// enable SPI
}

void ScheduleSpiDmaWrite(uint32_t bufferSize) {
	//RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;				// enable SPI clock
	
	
	while (!(SPI1->SR & SPI_SR_TXE)) {}					// send any pending output
	//while (SPI1->SR & SPI_SR_BSY) {}
	
	DMA1_Channel3->CCR &= ~DMA_CCR_EN;					// disable DMA to set registers	
	DMA1_Channel3->CCR |= DMA_CCR_DIR;					// memory to peripheral
	DMA1->IFCR = DMA_FLAG_GL3;							// clear flags
	DMA1_Channel3->CNDTR = bufferSize;					// set buffer size
	DMA1_Channel3->CPAR = (uint32_t)(&(SPI1->DR));		// SPI register address
	DMA1_Channel3->CMAR = (uint32_t)(spiOutBuffer);		// memory address
	DMA1_Channel3->CCR |= DMA_CCR_EN;  					// start DMA
	SPI1->CR1 |= SPI_CR1_SPE;							// enable SPI
}

/* SPI1 init function */
void MX_SPI1_Init(void) {
  
	/**SPI1 GPIO Configuration    
	PA4     ------> SPI1_NSS
	PA5     ------> SPI1_SCK
	PA6     ------> SPI1_MISO
	PA7     ------> SPI1_MOSI 
	*/
	
	RCC->APB2ENR |= RCC_APB2ENR_SPI1EN;						// enable SPI clock
	SPI1->CR2 |= SPI_CR2_FRXTH |							// FIFO threshold = 8 bit
	             SPI_CR2_RXDMAEN |							// enable RX DMA
	             SPI_CR2_TXDMAEN;							// enable TX DMA
	
	// configure pins
	
	GPIO_InitTypeDef GPIO_InitStruct;
	GPIO_InitStruct.Pin = GPIO_PIN_4 | GPIO_PIN_5 | GPIO_PIN_6 | GPIO_PIN_7;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF0_SPI1;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	// receive channel 2
	
	DMA1_Channel2->CCR |= DMA_CCR_MINC |					// increment memory
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  //DMA_CCR_TCIE |					// interrupt on full transfer
		                  //DMA_CCR_EN |					// enable DMA
						  (0b10 << DMA_CCR_PL_Pos);			// priority = high
	
//		/* SPI1 DMA Init */
//		/* SPI1_RX Init */
//	hdma_spi1_rx.Instance = DMA1_Channel2;
//	hdma_spi1_rx.Init.Direction = DMA_PERIPH_TO_MEMORY;
//	hdma_spi1_rx.Init.PeriphInc = DMA_PINC_DISABLE;
//	hdma_spi1_rx.Init.MemInc = DMA_MINC_ENABLE;
//	hdma_spi1_rx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
//	hdma_spi1_rx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
//	hdma_spi1_rx.Init.Mode = DMA_NORMAL;
//	hdma_spi1_rx.Init.Priority = DMA_PRIORITY_HIGH;
//	if (HAL_DMA_Init(&hdma_spi1_rx) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
	
	// send channel 3

	DMA1_Channel3->CCR |= DMA_CCR_MINC |					// increment memory
		                  DMA_CCR_DIR |						// memory to peripheral
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  //DMA_CCR_TCIE |					// interrupt on full transfer
		                  //DMA_CCR_EN |					// enable DMA
						  (0b10 << DMA_CCR_PL_Pos);			// priority = high
	
//    /* SPI1_TX Init */
//	hdma_spi1_tx.Instance = DMA1_Channel3;
//	hdma_spi1_tx.Init.Direction = DMA_MEMORY_TO_PERIPH;
//	hdma_spi1_tx.Init.PeriphInc = DMA_PINC_DISABLE;
//	hdma_spi1_tx.Init.MemInc = DMA_MINC_ENABLE;
//	hdma_spi1_tx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
//	hdma_spi1_tx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
//	hdma_spi1_tx.Init.Mode = DMA_NORMAL;
//	hdma_spi1_tx.Init.Priority = DMA_PRIORITY_HIGH;
//	if (HAL_DMA_Init(&hdma_spi1_tx) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}

	// SPI1 interrupt Init
	HAL_NVIC_SetPriority(SPI1_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(SPI1_IRQn);
}

void HAL_SPI_MspDeInit(SPI_HandleTypeDef* spiHandle) {

} 
