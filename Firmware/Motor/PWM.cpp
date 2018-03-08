#include <main.h>

const int sin[] = {128, 129, 131, 132, 134, 135, 137, 138, 140, 142, 143, 145, 146, 148, 149, 151, 152, 154, 156, 157, 
159, 160, 162, 163, 165, 166, 168, 169, 171, 172, 174, 175, 176, 178, 179, 181, 182, 184, 185, 186, 
188, 189, 191, 192, 193, 195, 196, 197, 199, 200, 201, 202, 204, 205, 206, 207, 209, 210, 211, 212, 
213, 215, 216, 217, 218, 219, 220, 221, 222, 223, 224, 225, 226, 227, 228, 229, 230, 231, 232, 233, 
234, 235, 236, 236, 237, 238, 239, 240, 240, 241, 242, 243, 243, 244, 245, 245, 246, 246, 247, 247, 
248, 249, 249, 250, 250, 250, 251, 251, 252, 252, 252, 253, 253, 253, 254, 254, 254, 254, 255, 255, 
255, 255, 255, 255, 255, 255, 255, 255, 256, 255, 255, 255, 255, 255, 255, 255, 255, 255, 255, 254, 
254, 254, 254, 253, 253, 253, 252, 252, 252, 251, 251, 250, 250, 250, 249, 249, 248, 247, 247, 246, 
246, 245, 245, 244, 243, 243, 242, 241, 240, 240, 239, 238, 237, 236, 236, 235, 234, 233, 232, 231, 
230, 229, 228, 227, 226, 225, 224, 223, 222, 221, 220, 219, 218, 217, 216, 215, 213, 212, 211, 210, 
209, 207, 206, 205, 204, 202, 201, 200, 199, 197, 196, 195, 193, 192, 191, 189, 188, 186, 185, 184, 
182, 181, 179, 178, 176, 175, 174, 172, 171, 169, 168, 166, 165, 163, 162, 160, 159, 157, 156, 154, 
152, 151, 149, 148, 146, 145, 143, 142, 140, 138, 137, 135, 134, 132, 131, 129, 128, 126, 124, 123, 
121, 120, 118, 117, 115, 113, 112, 110, 109, 107, 106, 104, 103, 101, 99, 98, 96, 95, 93, 92, 
90, 89, 87, 86, 84, 83, 81, 80, 79, 77, 76, 74, 73, 71, 70, 69, 67, 66, 64, 63, 
62, 60, 59, 58, 56, 55, 54, 53, 51, 50, 49, 48, 46, 45, 44, 43, 42, 40, 39, 38, 
37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 19, 
18, 17, 16, 15, 15, 14, 13, 12, 12, 11, 10, 10, 9, 9, 8, 8, 7, 6, 6, 5, 
5, 5, 4, 4, 3, 3, 3, 2, 2, 2, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 
0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 
2, 2, 3, 3, 3, 4, 4, 5, 5, 5, 6, 6, 7, 8, 8, 9, 9, 10, 10, 11, 
12, 12, 13, 14, 15, 15, 16, 17, 18, 19, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 
29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 42, 43, 44, 45, 46, 48, 49, 50, 
51, 53, 54, 55, 56, 58, 59, 60, 62, 63, 64, 66, 67, 69, 70, 71, 73, 74, 76, 77, 
79, 80, 81, 83, 84, 86, 87, 89, 90, 92, 93, 95, 96, 98, 99, 101, 103, 104, 106, 107, 
109, 110, 112, 113, 115, 117, 118, 120, 121, 123, 124, 126};
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
	
	//
	
	TIM1->CR1 |= (0x01 << TIM_CR1_CMS_Pos);				// center-aligned mode 1 - up&down
	
	TIM1->RCR = 0x3;									//repetition counter
	
	TIM1->BDTR |= TIM_BDTR_MOE |						// main output enable
		          TIM_BDTR_OSSR |						// Off-state selection for Run mode
				  TIM_BDTR_OSSI |						// Off-state selection for Idle mode
		          0x08;									// 0b10000 = 1uS dead-time
	
	TIM1->CR1 |= TIM_AUTORELOAD_PRELOAD_ENABLE;			// enable timer 1
	
	TIM1->CCER |= TIM_CCER_CC1E |						// enable channel1, positive
			      TIM_CCER_CC2E |						// enable channel2, positive
		          TIM_CCER_CC3E |						// enable channel3, positive
		
		          TIM_CCER_CC1NE |						// enable channel 1, negative
		          TIM_CCER_CC2NE |						// enable channel 2, negative
		          TIM_CCER_CC3NE;						// enable channel 3, negative

	TIM1->CCR1 = 0;										// zero duty-cycle on all channels
	TIM1->CCR2 = 0;
	TIM1->CCR3 = 0;
	
	TIM1->CR1 |= TIM_CR1_CEN;							// enable timer 1
	
	// GPIOF
	
	GPIOF->MODER |= (0x01 << GPIO_MODER_MODER6_Pos) |	// output mode for pin F-6 (standby mode)
		            (0x01 << GPIO_MODER_MODER7_Pos);	// output mode for pin F-7 (standby mode)
	
	GPIOF->PUPDR |= (0x01 << GPIO_PUPDR_PUPDR6_Pos) |	// pull-up for pin F-6
			        (0x01 << GPIO_PUPDR_PUPDR7_Pos);	// pull-up for pin F-7
	
	// over-current config (pin A-11)

	GPIOA->BRR = (1 << 11);								// reset pin 11 (overcurrent does not effect gate driver directly)
	GPIOF->BSRR = (1 << 7);								// disable stand-by mode	
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
		setPwm(a, usartTorqueCommandValue);
	}
	else
	{
		a = getElectricDegrees() - ninetyDeg;
		setPwm(a, -usartTorqueCommandValue);
	}
}