#include <main.h>

void initLed() {
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
int ensureConfigured() {
	while (config->calibPoles == -1)
	{
		if (button2Pressed)
		{
			calibrate();
			button2Pressed = false;
		}
	}
}

//

int main(void) {
	initClockExternal();
	initButtons();
	initPwm();
	initUsart();
	initSpi();
	initSysTick();
	
	//calibrate();
	
	ensureConfigured();
	
	//usartTorqueCommandValue = 20;	
	
	usartPendingTorqueCommand = false;
	button1Pressed = false;
	button2Pressed = false;

	while (true){
		//spiUpdateTorque();
		spiCurrentAngle = spiReadAngle();
		setPwmTorque();
		
		if (usartPendingTorqueCommand)
		{
			usartSendAngle();
			usartPendingTorqueCommand = false;
		}
		
		if (button1Pressed)
		{
			button1Pressed = false;
		}
		
		if (button2Pressed)
		{
			calibrate(); 
			button2Pressed = false;
		}
	}
}
