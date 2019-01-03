#include "gyro.h"
#include "gpio.h"
#include "dma.h"

uint8_t gyroBuffer[12];

I2C_HandleTypeDef hi2c1;
DMA_HandleTypeDef hdma_i2c1_rx;

// timer frequency for giro reading

//const uint32_t GIRO_PERIOD = 1000;
//const uint32_t GIRO_PRESCALER = 48000;

//extern "C"
//void TIM3_IRQHandler(void) {
//	TIM3->SR &= ~TIM_SR_UIF;
//	
//	readGyro();
//}

void initDevice(){
	uint8_t reg;
	
	// Linear acceleration sensor control register 1
	
	reg = 0b01000000 |	// 104hz output data rate
	      0b00000010;	// 100hz Anti-aliasing filter bandwidth
	
	if (HAL_OK != HAL_I2C_Mem_Write(&hi2c1, I2C_ADDRESS, CTRL1_XL, I2C_MEMADD_SIZE_8BIT, &reg, 1, 500))
	{
		_Error_Handler(__FILE__, __LINE__);		
	}
	
	// Angular rate sensor control register 2
	
	reg = 0b01000000;	// 104hz output data rate
	
	if (HAL_OK != HAL_I2C_Mem_Write(&hi2c1, I2C_ADDRESS, CTRL2_G, I2C_MEMADD_SIZE_8BIT, &reg, 1, 500))
	{
		_Error_Handler(__FILE__, __LINE__);		
	}	
}

void initGiro(void) {
	// I2C
	
	hi2c1.Instance = I2C1;
	hi2c1.Init.Timing = 0x2000090E;	// normal
	//hi2c1.Init.Timing = 0x0000020B;	// fast
	hi2c1.Init.OwnAddress1 = 0;
	hi2c1.Init.AddressingMode = I2C_ADDRESSINGMODE_7BIT;
	hi2c1.Init.DualAddressMode = I2C_DUALADDRESS_DISABLE;
	hi2c1.Init.OwnAddress2 = 0;
	hi2c1.Init.OwnAddress2Masks = I2C_OA2_NOMASK;
	hi2c1.Init.GeneralCallMode = I2C_GENERALCALL_DISABLE;
	hi2c1.Init.NoStretchMode = I2C_NOSTRETCH_DISABLE;
	if (HAL_I2C_Init(&hi2c1) != HAL_OK)
	{
		_Error_Handler(__FILE__, __LINE__);
	}

//	if (HAL_I2CEx_ConfigAnalogFilter(&hi2c1, I2C_ANALOGFILTER_ENABLE) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
//
//	if (HAL_I2CEx_ConfigDigitalFilter(&hi2c1, 0) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
	
	initDevice();

//	// timer
//	
//	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;					// enable timer 3
//	
//	TIM3->ARR = GIRO_PERIOD;							// tim3 period
//	TIM3->PSC = GIRO_PRESCALER;							// prescaler
//
//	TIM3->DIER |= TIM_DIER_UIE;							// enable update interrupt
//	TIM3->CR1 |= TIM_CR1_CEN;							// enable timer 3	
//	
//	HAL_NVIC_SetPriority(TIM3_IRQn, 1, 1);
//	HAL_NVIC_EnableIRQ(TIM3_IRQn);
}
void HAL_I2C_MspInit(I2C_HandleTypeDef* i2cHandle) {

  GPIO_InitTypeDef GPIO_InitStruct;
  if(i2cHandle->Instance==I2C1)
  {
  /* USER CODE BEGIN I2C1_MspInit 0 */

  /* USER CODE END I2C1_MspInit 0 */
  
    /**I2C1 GPIO Configuration    
    PA9     ------> I2C1_SCL
    PA10     ------> I2C1_SDA 
    */
	GPIO_InitStruct.Pin = GPIO_PIN_9 | GPIO_PIN_10;
	GPIO_InitStruct.Mode = GPIO_MODE_AF_OD;
	GPIO_InitStruct.Pull = GPIO_PULLUP;
	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
	GPIO_InitStruct.Alternate = GPIO_AF4_I2C1;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
 
    /* I2C1 clock enable */
    __HAL_RCC_I2C1_CLK_ENABLE();
  
    /* I2C1 DMA Init */
    /* I2C1_RX Init */
//    hdma_i2c1_rx.Instance = DMA1_Channel3;
//    hdma_i2c1_rx.Init.Direction = DMA_PERIPH_TO_MEMORY;
//    hdma_i2c1_rx.Init.PeriphInc = DMA_PINC_DISABLE;
//    hdma_i2c1_rx.Init.MemInc = DMA_MINC_ENABLE;
//    hdma_i2c1_rx.Init.PeriphDataAlignment = DMA_PDATAALIGN_BYTE;
//    hdma_i2c1_rx.Init.MemDataAlignment = DMA_MDATAALIGN_BYTE;
//    hdma_i2c1_rx.Init.Mode = DMA_NORMAL;
//    hdma_i2c1_rx.Init.Priority = DMA_PRIORITY_LOW;
//    if (HAL_DMA_Init(&hdma_i2c1_rx) != HAL_OK)
//    {
//      _Error_Handler(__FILE__, __LINE__);
//    }
//
//    __HAL_LINKDMA(i2cHandle,hdmarx,hdma_i2c1_rx);
//
//    /* I2C1 interrupt Init */
//    HAL_NVIC_SetPriority(I2C1_IRQn, 0, 0);
//    HAL_NVIC_EnableIRQ(I2C1_IRQn);
  /* USER CODE BEGIN I2C1_MspInit 1 */

  /* USER CODE END I2C1_MspInit 1 */
  }
}
void HAL_I2C_MspDeInit(I2C_HandleTypeDef* i2cHandle) {

  if(i2cHandle->Instance==I2C1)
  {
  /* USER CODE BEGIN I2C1_MspDeInit 0 */

  /* USER CODE END I2C1_MspDeInit 0 */
    /* Peripheral clock disable */
    __HAL_RCC_I2C1_CLK_DISABLE();
  
    /**I2C1 GPIO Configuration    
    PA9     ------> I2C1_SCL
    PA10     ------> I2C1_SDA 
    */
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_9|GPIO_PIN_10);

    /* I2C1 DMA DeInit */
    HAL_DMA_DeInit(i2cHandle->hdmarx);

    /* I2C1 interrupt Deinit */
    HAL_NVIC_DisableIRQ(I2C1_IRQn);
  /* USER CODE BEGIN I2C1_MspDeInit 1 */

  /* USER CODE END I2C1_MspDeInit 1 */
  }
}

void readGyro() {
	if (HAL_OK != HAL_I2C_Mem_Read(&hi2c1, I2C_ADDRESS, OUTX_L_G, I2C_MEMADD_SIZE_8BIT, gyroBuffer, 12, 100))
	{
		_Error_Handler(__FILE__, __LINE__);		
	}
}
