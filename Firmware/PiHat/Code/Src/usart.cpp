
/* Includes ------------------------------------------------------------------*/
#include "usart.h"

#include "gpio.h"
#include "dma.h"

volatile bool idleLineReceived;

extern "C"
void USART1_IRQHandler(void) {
	// idle line
	
	if (USART1->ISR & USART_ISR_IDLE)
	{
		USART1->ICR |= USART_ICR_IDLECF;		// clear IDLE flag bit
		
		idleLineReceived = true;
	}
}

void StartUsartDmaWrite(uint32_t length) {
	USART1->CR1 &= ~USART_CR1_IDLEIE;						// disable IDLE LINE detection interrupt
	USART1->CR1 |= USART_CR1_UE;							// enable usart		
	
	DMA1->IFCR = DMA_FLAG_GL2;								// clear flags
	DMA1_Channel2->CNDTR = length;							// set buffer size
	DMA1_Channel2->CPAR = (uint32_t)(&(USART1->TDR));		// USART TDR is destination
	DMA1_Channel2->CMAR = (uint32_t)(usartOutBuffer);		// memory address
	
	DMA1_Channel2->CCR |= DMA_CCR_MINC |					// increment memory
		                  DMA_CCR_DIR |						// memory to peripheral
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  //DMA_CCR_TCIE |					// interrupt on full transfer
		                  //DMA_CCR_EN |					// enable DMA
						  (0b10 << DMA_CCR_PL_Pos);			// priority = high	
	
	DMA1_Channel2->CCR |= DMA_CCR_EN;  						// start DMA
}

void StartUsartDmaRead(){
	READ_REG(USART1->RDR);
	idleLineReceived = false;
	
	USART1->CR1 |= USART_CR1_IDLEIE;						// enanle IDLE LINE detection interrupt
	
	DMA1_Channel3->CCR &= ~DMA_CCR_DIR;						// peripheral to memory	
	
	DMA1->IFCR = DMA_FLAG_GL3;								// clear flags
	DMA1_Channel3->CNDTR = usartBufferSize;					// set buffer size
	DMA1_Channel3->CPAR = (uint32_t)(&(USART1->RDR));		// USART register address
	DMA1_Channel3->CMAR = (uint32_t)(usartInBuffer);		// memory address
	
	DMA1_Channel3->CCR |= DMA_CCR_EN;  						// start DMA
	USART1->CR1 |= USART_CR1_UE;							// enable usart		
}

void MX_USART1_UART_Init(void){
    /**USART1 GPIO Configuration    
    PA1     ------> USART1_DE
    PA2     ------> USART1_TX
    PA3     ------> USART1_RX 
    */
	
	// config pins
	
	GPIO_InitTypeDef GPIO_InitStruct;
	
	GPIO_InitStruct.Pin = GPIO_PIN_1;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_NOPULL;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF1_USART1;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

	GPIO_InitStruct.Pin = GPIO_PIN_2 | GPIO_PIN_3;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
	GPIO_InitStruct.Pull = GPIO_PULLUP;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF1_USART1;
	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);	
	
	// config USART
	
	RCC->APB2ENR |= RCC_APB2ENR_USART1EN;
	
//	UART_HandleTypeDef huart1;
//	huart1.Instance = USART1;
//	huart1.Init.BaudRate = 115200;
//	huart1.Init.WordLength = UART_WORDLENGTH_8B;
//	huart1.Init.StopBits = UART_STOPBITS_1;
//	huart1.Init.Parity = UART_PARITY_NONE;
//	huart1.Init.Mode = UART_MODE_TX_RX;
//	huart1.Init.HwFlowCtl = UART_HWCONTROL_NONE;
//	huart1.Init.OverSampling = UART_OVERSAMPLING_16;
//	huart1.Init.OneBitSampling = UART_ONE_BIT_SAMPLE_DISABLE;
//	huart1.AdvancedInit.AdvFeatureInit = UART_ADVFEATURE_NO_INIT;
//	if (HAL_RS485Ex_Init(&huart1, UART_DE_POLARITY_HIGH, 0, 0) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}	
	
	int baud = 115200;
	
	USART1->BRR = (8000000U + baud / 2U) / baud;			// baud rate (should be 0x45)
	//USART1->BRR = (48000000U + baud / 2U) / baud;			// baud rate (should be 0x1A1)
	
	CLEAR_BIT(USART1->CR2, (USART_CR2_LINEN | USART_CR2_CLKEN));
	CLEAR_BIT(USART1->CR3, (USART_CR3_SCEN | USART_CR3_HDSEL | USART_CR3_IREN));
	
	USART1->CR3 |= USART_CR3_OVRDIS |						// disable overrun error interrupt
				   USART_CR3_DMAT;							// enable DMA transmit
		           USART_CR3_DMAR;							// enable DMA receive
	
	USART1->CR1 |= USART_CR1_TE |							// enable transmitter
		           USART_CR1_RE;							// enable receiver
				   //USART_CR1_UE;							// enable usart
				   //USART_CR1_RXNEIE |						// interrupt on receive
				   //USART_CR1_IDLEIE;						// enable IDLE LINE detection interrupt	
	
	USART1->CR3 |= USART_CR3_DEM;							// enable automatic DriverEnable mode
	USART1->CR1 |= (16 << UART_CR1_DEAT_ADDRESS_LSB_POS) |	// 4/16th of a bit assertion time on DriverEnable output
				   (16 << UART_CR1_DEDT_ADDRESS_LSB_POS);	// 4/16th of a bit de-assertion time on DriverEnable output	
	
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_SetPriority(USART1_IRQn, 0);
	
	//USART1->CR1 |= USART_CR1_UE;							// enable usart		
	
	// config DMA
	
	// transmit channel 4

//	DMA1_Channel4->CPAR = (uint32_t)(&(USART1->TDR));		// USART TDR is destination
//	//DMA1_Channel4->CMAR = (uint32_t)(sendBuffer);			// source
//	
//	DMA1_Channel4->CCR |= DMA_CCR_MINC |					// increment memory
//		                  DMA_CCR_DIR |						// memory to peripheral
//		                  //DMA_CCR_TEIE |					// interrupt on error
//		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
//		                  //DMA_CCR_TCIE |					// interrupt on full transfer
//		                  //DMA_CCR_EN |					// enable DMA
//						  (0b10 << DMA_CCR_PL_Pos);			// priority = high	
//	
//	__HAL_DMA_REMAP_CHANNEL_ENABLE(DMA_REMAP_USART1_TX_DMA_CH4);

	// receive channel 5
	
//	DMA1_Channel5->CPAR = (uint32_t)(&(USART1->RDR));		// USART RDR is source
//	//DMA1_Channel3->CMAR = (uint32_t)(recvBuffer);			// destination
//	//DMA1_Channel3->CNDTR = recvBufferSize;					// buffer size	
//	
//	DMA1_Channel5->CCR |= DMA_CCR_MINC |					// increment memory
//						  DMA_CCR_CIRC |					// circular mode
//						  //								// peripheral to memory
//		                  //DMA_CCR_TEIE |					// interrupt on error
//		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
//		                  //DMA_CCR_TCIE |					// interrupt on full transfer
//					      DMA_CCR_EN |						// enable DMA
//					      (0b10 << DMA_CCR_PL_Pos);			// priority = high
//	
//	__HAL_DMA_REMAP_CHANNEL_ENABLE(DMA_REMAP_USART1_RX_DMA_CH5);
}

void HAL_UART_MspInit(UART_HandleTypeDef* uartHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct;
  if(uartHandle->Instance==USART1)
  {
  /* USER CODE BEGIN USART1_MspInit 0 */

  /* USER CODE END USART1_MspInit 0 */
    /* USART1 clock enable */
//    __HAL_RCC_USART1_CLK_ENABLE();
  
//    /**USART1 GPIO Configuration    
//    PA1     ------> USART1_DE
//    PA2     ------> USART1_TX
//    PA3     ------> USART1_RX 
//    */
//    GPIO_InitStruct.Pin = GPIO_PIN_1;
//    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
//    GPIO_InitStruct.Pull = GPIO_NOPULL;
//    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
//    GPIO_InitStruct.Alternate = GPIO_AF1_USART1;
//    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
//
//    GPIO_InitStruct.Pin = GPIO_PIN_2|GPIO_PIN_3;
//    GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
//    GPIO_InitStruct.Pull = GPIO_PULLUP;
//    GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
//    GPIO_InitStruct.Alternate = GPIO_AF1_USART1;
//    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

//    /* USART1 DMA Init */
//    /* USART1_RX Init */
//    hdma_usart1_rx.Instance = DMA1_Channel5;
//    hdma_usart1_rx.Init.Direction = DMA_PERIPH_TO_MEMORY;
//    hdma_usart1_rx.Init.PeriphInc = DMA_PINC_DISABLE;
//    hdma_usart1_rx.Init.MemInc = DMA_MINC_ENABLE;
//    hdma_usart1_rx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
//    hdma_usart1_rx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
//    hdma_usart1_rx.Init.Mode = DMA_NORMAL;
//    hdma_usart1_rx.Init.Priority = DMA_PRIORITY_LOW;
//    if (HAL_DMA_Init(&hdma_usart1_rx) != HAL_OK)
//    {
//      _Error_Handler(__FILE__, __LINE__);
//    }
//
//    __HAL_DMA_REMAP_CHANNEL_ENABLE(DMA_REMAP_USART1_RX_DMA_CH5);
//
//    __HAL_LINKDMA(uartHandle,hdmarx,hdma_usart1_rx);
//
//    /* USART1_TX Init */
//    hdma_usart1_tx.Instance = DMA1_Channel4;
//    hdma_usart1_tx.Init.Direction = DMA_MEMORY_TO_PERIPH;
//    hdma_usart1_tx.Init.PeriphInc = DMA_PINC_DISABLE;
//    hdma_usart1_tx.Init.MemInc = DMA_MINC_ENABLE;
//    hdma_usart1_tx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
//    hdma_usart1_tx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
//    hdma_usart1_tx.Init.Mode = DMA_NORMAL;
//    hdma_usart1_tx.Init.Priority = DMA_PRIORITY_LOW;
//    if (HAL_DMA_Init(&hdma_usart1_tx) != HAL_OK)
//    {
//      _Error_Handler(__FILE__, __LINE__);
//    }
//
   // __HAL_DMA_REMAP_CHANNEL_ENABLE(DMA_REMAP_USART1_TX_DMA_CH4);
//
//    __HAL_LINKDMA(uartHandle,hdmatx,hdma_usart1_tx);

  /* USER CODE BEGIN USART1_MspInit 1 */

  /* USER CODE END USART1_MspInit 1 */
  }
}

void HAL_UART_MspDeInit(UART_HandleTypeDef* uartHandle)
{

//  if(uartHandle->Instance==USART1)
//  {
//  /* USER CODE BEGIN USART1_MspDeInit 0 */
//
//  /* USER CODE END USART1_MspDeInit 0 */
//    /* Peripheral clock disable */
//    __HAL_RCC_USART1_CLK_DISABLE();
//  
//    /**USART1 GPIO Configuration    
//    PA1     ------> USART1_DE
//    PA2     ------> USART1_TX
//    PA3     ------> USART1_RX 
//    */
//    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3);
//
//    /* USART1 DMA DeInit */
//    HAL_DMA_DeInit(uartHandle->hdmarx);
//    HAL_DMA_DeInit(uartHandle->hdmatx);
//  /* USER CODE BEGIN USART1_MspDeInit 1 */
//
//  /* USER CODE END USART1_MspDeInit 1 */
//  }
} 
