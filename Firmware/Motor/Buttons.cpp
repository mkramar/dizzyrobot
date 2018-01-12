#include <main.h>

volatile bool button1Pressed;
volatile bool button2Pressed;

const int BLINK_PERIOD = 0x100000;
const int BLINK_DUTY_CYCLE = 0x40000;

extern "C"
void EXTI2_3_IRQHandler(void) {
	if ((EXTI->IMR & EXTI_IMR_MR2) && (EXTI->PR & EXTI_PR_PR2))
	//if (GPIOA->IDR & GPIO_IDR_2)
	{
		button1Pressed = true;
		EXTI->PR |= EXTI_PR_PR2;
	}	
	
	if ((EXTI->IMR & EXTI_IMR_MR3) && (EXTI->PR & EXTI_PR_PR3))
	//if (GPIOA->IDR & GPIO_IDR_3)
	{
		button2Pressed = true;
		EXTI->PR |= EXTI_PR_PR3;
	}		
}

void initButtons() {
	button1Pressed = false;
	button2Pressed = false;
	
	// pin 11 - PA-0 configure as led blinker ---------------------------------
		
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN;					// enable clock for GPIOA
	RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;					// enable timer 2
	
	TIM2->ARR = BLINK_PERIOD;							// tim2 period

	// tim2 config channel

	TIM2->CCMR1 |= TIM_CCMR1_OC1PE |					// Output compare 1 preload enable
 			       (0x06 << TIM_CCMR1_OC1M_Pos);		// Output compare 1 mode = 110

	// GPIOA
	
	GPIOA->MODER |= (0x02 << GPIO_MODER_MODER0_Pos);	// alternative function for pin A-0
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR0;			// high speed for pin A-0
	GPIOA->AFR[0] |= (0x02 << GPIO_AFRL_AFSEL0_Pos);	// alternative funciton 2 for pin A-0

	TIM2->CCR1 = BLINK_DUTY_CYCLE;						// duty cycle of tim2 channel 1
	TIM2->CCER |= TIM_CCER_CC1E;						// enable tim2 channel 1, positive
	TIM2->CR1 |= TIM_CR1_CEN;							// enable timer 2

	// pin 19 - PB-1 configure as led blinker ---------------------------------
		
	RCC->AHBENR |= RCC_AHBENR_GPIOBEN;					// enable clock for GPIOB
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;					// enable timer 3
	
	TIM3->ARR = BLINK_PERIOD;							// tim3 period

	// tim3 config channel

	TIM3->CCMR2 |= TIM_CCMR2_OC4PE |					// Output compare 4 preload enable
 			       (0x06 << TIM_CCMR2_OC4M_Pos);		// Output compare 4 mode = 110

	// GPIOB
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER1_Pos);	// alternative function for pin B-1
	GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR1;			// high speed for pin B-1
	GPIOB->AFR[0] |= (0x02 << GPIO_AFRL_AFSEL1_Pos);	// alternative funciton 2 for pin B-1

	TIM3->CCR4 = BLINK_DUTY_CYCLE;						// duty cycle of tim3 channel 4
	TIM3->CCER |= TIM_CCER_CC4E;						// enable tim3 channel 4, positive
	TIM3->CR1 |= TIM_CR1_CEN;							// enable timer 3
	
	// buttons -------------------------------------------------------------------
	
	GPIOA->PUPDR |= (0x02 << GPIO_PUPDR_PUPDR2_Pos) |	// pull-down A-2
		            (0x02 << GPIO_PUPDR_PUPDR3_Pos);	// pull-down A-3
	
	EXTI->IMR |= EXTI_IMR_MR2 |		// enable line 2
				 EXTI_IMR_MR3;		// enable line 3
	
	EXTI->RTSR |= EXTI_RTSR_RT2 |	// raizing edge for line 2
		          EXTI_RTSR_RT3;	// raizing edge for line 3
	
	HAL_NVIC_SetPriority(EXTI2_3_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(EXTI2_3_IRQn);	
}