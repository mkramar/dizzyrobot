#include <main.h>

const int sin[] = {128, 131, 134, 137, 140, 143, 146, 149, 152, 156
, 159, 162, 165, 168, 171, 174, 176, 179, 182, 185
, 188, 191, 193, 196, 199, 201, 204, 206, 209, 211
, 213, 216, 218, 220, 222, 224, 226, 228, 230, 232
, 234, 236, 237, 239, 240, 242, 243, 245, 246, 247
, 248, 249, 250, 251, 252, 252, 253, 254, 254, 255
, 255, 255, 255, 255, 256, 255, 255, 255, 255, 255
, 254, 254, 253, 252, 252, 251, 250, 249, 248, 247
, 246, 245, 243, 242, 240, 239, 237, 236, 234, 232
, 230, 228, 226, 224, 222, 220, 218, 216, 213, 211
, 209, 206, 204, 201, 199, 196, 193, 191, 188, 185
, 182, 179, 176, 174, 171, 168, 165, 162, 159, 156
, 152, 149, 146, 143, 140, 137, 134, 131, 128, 124
, 121, 118, 115, 112, 109, 106, 103, 99, 96, 93
, 90, 87, 84, 81, 79, 76, 73, 70, 67, 64
, 62, 59, 56, 54, 51, 49, 46, 44, 42, 39
, 37, 35, 33, 31, 29, 27, 25, 23, 21, 19
, 18, 16, 15, 13, 12, 10, 9, 8, 7, 6
, 5, 4, 3, 3, 2, 1, 1, 0, 0, 0
, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1
, 2, 3, 3, 4, 5, 6, 7, 8, 9, 10
, 12, 13, 15, 16, 18, 19, 21, 23, 25, 27
, 29, 31, 33, 35, 37, 39, 42, 44, 46, 49
, 51, 54, 56, 59, 62, 64, 67, 70, 73, 76
, 79, 81, 84, 87, 90, 93, 96, 99, 103, 106
, 109, 112, 115, 118, 121, 124};
const int sin_size = sizeof(sin)/sizeof(int);
const int phase2 = sin_size / 3;
const int phase3 = sin_size * 2 / 3;
const int ninetyDeg = sin_size / 4;

void initPwm() {
	TIM1->ARR = 0x100;									// tim1 period

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
	
	//
	
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
void setPwm(int angle, int power) {
	int a1 = angle % sin_size;
	int a2 = (angle + phase2) % sin_size;
	int a3 = (angle + phase3) % sin_size;
	
	if (a1 < 0) a1 += sin_size;
	if (a2 < 0) a2 += sin_size;
	if (a3 < 0) a3 += sin_size;
	
	TIM1->CCR1 = sin[a1] * power / 256;
	TIM1->CCR2 = sin[a2] * power / 256;
	TIM1->CCR3 = sin[a3] * power / 256;
}
void setPwmTorque() {
	int a;
	
	if (usartTorqueCommandValue > 0)
	{
		a = getElectricDegrees() + ninetyDeg;
	}
	else
	{
		a = getElectricDegrees() - ninetyDeg;
	}
	
	setPwm(a, usartTorqueCommandValue);
}