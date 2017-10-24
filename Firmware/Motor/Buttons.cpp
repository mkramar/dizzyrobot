#include <main.h>

volatile bool button1Pressed;
volatile bool button2Pressed;

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

	//
	
	GPIOA->PUPDR |= (0x02 << GPIO_PUPDR_PUPDR2_Pos) |	// pull-down A-2
		            (0x02 << GPIO_PUPDR_PUPDR3_Pos);	// pull-down A-3
	
	EXTI->IMR |= EXTI_IMR_MR2 |		// enable line 2
				 EXTI_IMR_MR3;		// enable line 3
	
	EXTI->RTSR |= EXTI_RTSR_RT2 |	// raizing edge for line 2
		          EXTI_RTSR_RT3;	// raizing edge for line 3
	
	HAL_NVIC_SetPriority(EXTI2_3_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(EXTI2_3_IRQn);	
}