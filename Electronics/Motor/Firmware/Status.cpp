#include <main.h>

volatile bool buttonIdPressed;
volatile bool buttonCalibPressed;
volatile int buttonPressId = 0;

const int BLINK_PERIOD = 0x100;
const int BLINK_DUTY_CYCLE = 0x40;
const int BLINK_PRESCALER = 0x6000;

void stopIdTimer()
{
	TIM2->CR1 &= ~TIM_CR1_CEN;							// disable timer 2
	GPIOA->MODER &= ~GPIO_MODER_MODER0_Msk;
	GPIOA->MODER |= (0x01 << GPIO_MODER_MODER0_Pos);	// output mode for A-0
	GPIOA->BSRR |= 0x01;								// set pin A-0	
}


void setStatus(bool blink) {
	if (blink)
	{
		// PA-0 configure as led timer 2 blinker
		
		RCC->AHBENR |= RCC_AHBENR_GPIOAEN;					// enable clock for GPIOA
		RCC->APB1ENR |= RCC_APB1ENR_TIM2EN;					// enable timer 2
	
		TIM2->ARR = BLINK_PERIOD;							// tim2 period
		TIM2->PSC = BLINK_PRESCALER;						// prescaler

		// tim2 config channel

		TIM2->CCMR1 |= TIM_CCMR1_OC1PE |					// Output compare 1 preload enable
					   (0x06 << TIM_CCMR1_OC1M_Pos);		// Output compare 1 mode = 110

		// GPIOA
	
		GPIOA->MODER &= ~GPIO_MODER_MODER0_Msk;
		GPIOA->MODER |= (0x02 << GPIO_MODER_MODER0_Pos);	// alternative function for pin A-0
		GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR0;			// high speed for pin A-0
		GPIOA->AFR[0] |= (0x02 << GPIO_AFRL_AFSEL0_Pos);	// alternative funciton 2 for pin A-0

		TIM2->CCR1 = BLINK_DUTY_CYCLE;						// duty cycle of tim2 channel 1
		TIM2->CCER |= TIM_CCER_CC1E;						// enable tim2 channel 1, positive
		TIM2->CR1 |= TIM_CR1_CEN;							// enable timer 2
	}
	else
	{
		stopIdTimer();
	}
}
