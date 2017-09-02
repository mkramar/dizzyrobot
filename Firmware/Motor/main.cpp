#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifdef __cplusplus
extern "C"
#endif
void SysTick_Handler(void)
{
	HAL_IncTick();
	HAL_SYSTICK_IRQHandler();
}

void initPwm()
{
	// clock
	
	RCC->CR |= RCC_CR_HSION;							// enable internal clock
	while (!(RCC->CR & RCC_CR_HSIRDY)) {}
	
	RCC->CR |= RCC_CR_PLLON;							// enable PLL
	while (!(RCC->CR & RCC_CR_PLLRDY)) {}
	
	RCC->CFGR |= (0x02 << RCC_CFGR_SW_Pos);				// select PLL as system clock
	while ((RCC->CFGR & RCC_CFGR_SWS) != (0x02 << RCC_CFGR_SWS_Pos)) {}
	
	RCC->CFGR |= RCC_CFGR_PLLMUL12;						// PLL input clock x12
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN |					// enable clock for GPIOA
				   RCC_AHBENR_GPIOBEN |					// enable clock for GPIOB
				   RCC_AHBENR_GPIOFEN;					// enable clock for GPIOF

	RCC->APB2ENR |= RCC_APB2ENR_TIM1EN;					// enable timer 1
	
	// timer periods
	
	TIM1->ARR = 0x100;									// tim1 period
	TIM1->CCR3 = 0x80;									// duty cycle of tim1 channel 3
	TIM1->CCR2 = 0x40;									// duty cycle of tim1 channel 2
	TIM1->CCR1 = 0x60;									// duty cycle of tim1 channel 1

	// tim1 config channel

	TIM1->CCMR1 |= TIM_CCMR1_OC1PE |					// Output compare on channel 1 preload enable (for pin B-13, low-side 1)
		           (0x06 << TIM_CCMR1_OC1M_Pos) |		// Output compare on channel 1 mode = 110 (PWM mode 1)
				   TIM_CCMR1_OC2PE |					// Output compare on channel 2 preload enable (for pin B-14, low-side 2)
		           (0x06 << TIM_CCMR1_OC2M_Pos);		// Output compare on channel 2 mode = 110 (PWM mode 1)
	
	TIM1->CCMR2 |= TIM_CCMR2_OC3PE |					// Output compare channel 3 preload enable (for pin A-10, high-side and pin B-15, low-side)
 			       (0x06 << TIM_CCMR2_OC3M_Pos);		// Output compare 3 mode = 110 (PWM mode 1)
	
	// GPIOA
	
	GPIOA->MODER |= (0x02 << GPIO_MODER_MODER8_Pos) |	// alternative function for pin A-8 (pwm channel 1, positive)
					(0x02 << GPIO_MODER_MODER9_Pos) |	// alternative function for pin A-9 (pwm channel 2, positive)
				    (0x02 << GPIO_MODER_MODER10_Pos) |	// alternative function for pin A-10 (pwm channel 3, positive)
		
					(0x01 << GPIO_MODER_MODER11_Pos);	// output for pin A-11 (overcurrent control)
	
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR8 |			// high speed for pin A-8 (pwm channel 1, positive)
				      GPIO_OSPEEDR_OSPEEDR9 |			// high speed for pin A-9 (pwm channel 2, positive)
		              GPIO_OSPEEDR_OSPEEDR10 |			// high speed for pin A-10 (pwm channel 3, positive)
		
					  (0x01 << GPIO_OSPEEDR_OSPEEDR11_Pos);	// medium speed for pin A-11 (overcurrent control)
	
	GPIOA->AFR[1] |= (0x02 << GPIO_AFRH_AFSEL8_Pos) |	// for pin A-8 alternative funciton 2
					 (0x02 << GPIO_AFRH_AFSEL9_Pos) |	// for pin A-9 alternative funciton 2
					 (0x02 << GPIO_AFRH_AFSEL10_Pos);	// for pin A-10 alternative funciton 2
	
	GPIOA->PUPDR |= (0x01 << GPIO_PUPDR_PUPDR11_Pos);	// pull-up for pin A-11 (overcurrent control)
	
	// GPIOB
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER13_Pos) |	// alternate function for pin B-13 (PWM channel 1, negative)
		            (0x02 << GPIO_MODER_MODER14_Pos) |	// alternate function for pin B-14 (PWM channel 2, negative)
		            (0x02 << GPIO_MODER_MODER15_Pos);	// alternate function for pin B-15 (PWM channel 3, negative)
	
	GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR13 |			// high speed for pin B-13 (pwm channel 1, negative)
		              GPIO_OSPEEDR_OSPEEDR14 |			// high speed for pin B-14 (pwm channel 2, negative)
		              GPIO_OSPEEDR_OSPEEDR15;			// high speed for pin B-15 (pwm channel 3, negative)
	
	GPIOB->AFR[1] |= (0x02 << GPIO_AFRH_AFSEL13_Pos) |	// for pin B-13 alternative funciton 2
		             (0x02 << GPIO_AFRH_AFSEL14_Pos) |	// for pin B-14 alternative funciton 2
	                 (0x02 << GPIO_AFRH_AFSEL15_Pos);	// for pin B-15 alternative funciton 2

	// GPIOF
	
	GPIOF->MODER |= (0x01 << GPIO_MODER_MODER6_Pos) |	// output mode for pin F-6 (standby mode)
		            (0x01 << GPIO_MODER_MODER7_Pos);	// output mode for pin F-7 (standby mode)
	
	GPIOF->PUPDR |= (0x01 << GPIO_PUPDR_PUPDR6_Pos) |	// pull-up for pin F-6
			        (0x01 << GPIO_PUPDR_PUPDR7_Pos);	// pull-up for pin F-7
	
	// over-current config (pin A-11)

	GPIOA->BRR = (1 << 11);								// reset pin 11 (overcurrent does not effect gate driver directly)
	GPIOF->BSRR = (1 << 7);								// disable stand-by mode
	
	TIM1->CR1 |= (0x01 << TIM_CR1_CMS_Pos);				// center-aligned mode 1 - up&down
	
	TIM1->RCR = 0x3;									//repetition counter
	
	TIM1->BDTR |= TIM_BDTR_MOE |						// main output enable
		          TIM_BDTR_OSSR |						// Off-state selection for Run mode
				  TIM_BDTR_OSSI |						// Off-state selection for Idle mode
		          0x08;									// 1uS dead-time //0b10000
	
	TIM1->CR1 |= TIM_AUTORELOAD_PRELOAD_ENABLE;			// enable timer 1
	
	TIM1->CCER |= TIM_CCER_CC1E |						// enable channel1, positive
			      TIM_CCER_CC2E |						// enable channel2, positive
		          TIM_CCER_CC3E |						// enable channel3, positive
		
		          TIM_CCER_CC1NE |						// enable channel 1, negative
		          TIM_CCER_CC2NE |						// enable channel 2, negative
		          TIM_CCER_CC3NE;						// enable channel 3, negative

	TIM1->CR1 |= TIM_CR1_CEN;							// enable timer 1	
}

void initLed()
{
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;					// enable clock for GPIOF

	RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;					// enable timer 2
	
	TIM2->ARR = 0xA0;									// tim2 period

	// tim2 config channel

	TIM2->CCMR2 |= TIM_CCMR2_OC3PE |					// Output compare 3 preload enable
 			       (0x06 << TIM_CCMR2_OC3M_Pos);		// Output compare 3 mode = 110

	// GPIOA
	
	GPIOA->MODER |= (0x02 << GPIO_MODER_MODER2_Pos);	// alternative function for pin A-2 (led)
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR2;			// high speed for pin A-2 (led)
	GPIOA->AFR[0] |= (0x02 << GPIO_AFRL_AFSEL2_Pos);	// alternative funciton 2 for pin A-2 (LED)

	TIM2->CCR3 = 0xA0;									// duty cycle of tim2 channel 3 (LED)
	TIM2->CCER |= TIM_CCER_CC3E;						// enable tim2 channel 3, positive
	TIM2->CR1 |= TIM_CR1_CEN;							// enable timer 2
}

int main(void)
{
	initPwm();
	initLed();
	
	while (1) {}
}
