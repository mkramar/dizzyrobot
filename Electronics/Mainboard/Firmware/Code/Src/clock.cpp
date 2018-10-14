#include "clock.h"

void SystemClock_Config(void)
{
	RCC->CR |= RCC_CR_HSION;							// enable internal clock (aparently required for FLASH)
	while (!(RCC->CR & RCC_CR_HSIRDY)) {}
	
	RCC->CR |= RCC_CR_HSEON;							// enable external clock	
	while (!(RCC->CR & RCC_CR_HSERDY)) {}
	
	RCC->CFGR |= RCC_CFGR_PLLMUL6;						// PLL input clock x6
	RCC->CFGR |= RCC_CFGR_PLLSRC_HSE_PREDIV;			// HSE/PREDIV clock selected as PLL entry clock source
	
	RCC->CR |= RCC_CR_PLLON;							// enable PLL
	while (!(RCC->CR & RCC_CR_PLLRDY)) {}
	
	RCC->CFGR |= (0x02 << RCC_CFGR_SW_Pos);				// select PLL as system clock
	while ((RCC->CFGR & RCC_CFGR_SWS) != (0x02 << RCC_CFGR_SWS_Pos)) {}
	
//	RCC->CR2 |= RCC_CR2_HSI14ON;						// enable internal 14-meg clock for ADC
//	while (!(RCC->CR2 & RCC_CR2_HSI14RDY)) {}
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN |					// enable clock for GPIOA
				   RCC_AHBENR_GPIOBEN |					// enable clock for GPIOB
				   RCC_AHBENR_GPIOFEN;					// enable clock for GPIOF

	RCC->APB2ENR |= //RCC_APB2ENR_TIM1EN |				// enable timer 1
				    RCC_APB2ENR_ADCEN |					// enable ADC
					RCC_APB2ENR_USART1EN |				// enable USART
				    RCC_APB2ENR_SPI1EN;					// enable SPI
	
	//
	
	SysTick->LOAD = (SysTick->CALIB & SysTick_CALIB_TENMS_Msk) - 1;	// 1 ms period
	SysTick->VAL = 0;
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |		// enable source
	                 SysTick_CTRL_TICKINT_Msk   |		// enable interrupt
	                 SysTick_CTRL_ENABLE_Msk;			// enable systick
	
//	RCC_OscInitTypeDef RCC_OscInitStruct;
//	RCC_ClkInitTypeDef RCC_ClkInitStruct;
//	RCC_PeriphCLKInitTypeDef PeriphClkInit;
//
//	    /**Initializes the CPU, AHB and APB busses clocks 
//	    */
//	RCC_OscInitStruct.OscillatorType = RCC_OSCILLATORTYPE_HSI14 | RCC_OSCILLATORTYPE_HSE;
//	RCC_OscInitStruct.HSEState = RCC_HSE_ON;
//	RCC_OscInitStruct.HSIState = RCC_HSI_ON;
//	RCC_OscInitStruct.HSI14State = RCC_HSI14_ON;
//	RCC_OscInitStruct.HSI14CalibrationValue = 16;
//	RCC_OscInitStruct.PLL.PLLState = RCC_PLL_ON;
//	RCC_OscInitStruct.PLL.PLLSource = RCC_PLLSOURCE_HSE;
//	RCC_OscInitStruct.PLL.PLLMUL = RCC_PLL_MUL6;
//	RCC_OscInitStruct.PLL.PREDIV = RCC_PREDIV_DIV1;
//	if (HAL_RCC_OscConfig(&RCC_OscInitStruct) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
//
//	    /**Initializes the CPU, AHB and APB busses clocks 
//	    */
//	RCC_ClkInitStruct.ClockType = RCC_CLOCKTYPE_HCLK | RCC_CLOCKTYPE_SYSCLK
//	                            | RCC_CLOCKTYPE_PCLK1;
//	RCC_ClkInitStruct.SYSCLKSource = RCC_SYSCLKSOURCE_PLLCLK;
//	RCC_ClkInitStruct.AHBCLKDivider = RCC_SYSCLK_DIV1;
//	RCC_ClkInitStruct.APB1CLKDivider = RCC_HCLK_DIV1;
//
//	if (HAL_RCC_ClockConfig(&RCC_ClkInitStruct, FLASH_LATENCY_1) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
//
//	PeriphClkInit.PeriphClockSelection = RCC_PERIPHCLK_USART1 | RCC_PERIPHCLK_I2C1;
//	PeriphClkInit.Usart1ClockSelection = RCC_USART1CLKSOURCE_PCLK1;
//	PeriphClkInit.I2c1ClockSelection = RCC_I2C1CLKSOURCE_SYSCLK;
//	if (HAL_RCCEx_PeriphCLKConfig(&PeriphClkInit) != HAL_OK)
//	{
//		_Error_Handler(__FILE__, __LINE__);
//	}
//
//	    /**Configure the Systick interrupt time 
//	    */
//	HAL_SYSTICK_Config(HAL_RCC_GetHCLKFreq() / 1000);
//
//	    /**Configure the Systick 
//	    */
//	HAL_SYSTICK_CLKSourceConfig(SYSTICK_CLKSOURCE_HCLK);
//
//	  /* SysTick_IRQn interrupt configuration */
//	HAL_NVIC_SetPriority(SysTick_IRQn, 0, 0);
}
