#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

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
//const int sensorAngle = 330;

const int id = 1;

// calibration ----------------------------------------------------------------

uint32_t gCalib1;
uint32_t gPhisicalToElec100;

volatile int32_t gResult;

// tick -----------------------------------------------------------------------

uint32_t gTickCount = 0;

extern "C"
void SysTick_Handler(void){
	gTickCount++;
}

// usart ----------------------------------------------------------------------

const int sendBufferSize = 6;
unsigned char sendBuffer[sendBufferSize] = { 0 };

const int recvBufferSize = 6;
unsigned char recvBuffer[recvBufferSize] = { 0 };
volatile unsigned int ringPosition = 0;

const int COMMAND_TORQUE = 1;

volatile bool pendingTorqueCommand = false;
volatile int torqueCommandValue = 0;

extern "C"
void USART1_IRQHandler(void){
	while (USART1->ISR & USART_ISR_RXNE)
	{
		unsigned char newByte = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);
		
		recvBuffer[ringPosition % recvBufferSize] = newByte;
		
		if (recvBuffer[(ringPosition + recvBufferSize - 4) % recvBufferSize] == 0xFF &&		// FF 4 bytes back
			recvBuffer[(ringPosition + recvBufferSize - 3) % recvBufferSize] == 0xFF &&		// FF 3 bytes back
			recvBuffer[(ringPosition + recvBufferSize - 2) % recvBufferSize] == id)			// ID 2 bytes back
		{
			if (recvBuffer[(ringPosition + recvBufferSize - 1) % recvBufferSize] == COMMAND_TORQUE)
			{
				if (!pendingTorqueCommand)
				{
					torqueCommandValue = (int)newByte;
					pendingTorqueCommand = true;
				}
			}
		}
		
		ringPosition++;
	}
}

// init -----------------------------------------------------------------------

void initVars() {
	sendBuffer[0] = 0xFF;
	sendBuffer[1] = 0xFF;
	sendBuffer[2] = 0;
}
void initClock() {
	RCC->CR |= RCC_CR_HSION;							// enable internal clock	
	while (!(RCC->CR & RCC_CR_HSIRDY)) {}
	
	RCC->CR |= RCC_CR_PLLON;							// enable PLL
	while (!(RCC->CR & RCC_CR_PLLRDY)) {}
	
	RCC->CFGR |= (0x02 << RCC_CFGR_SW_Pos);				// select PLL as system clock
	while ((RCC->CFGR & RCC_CFGR_SWS) != (0x02 << RCC_CFGR_SWS_Pos)) {}
	
	RCC->CR2 |= RCC_CR2_HSI14ON;						// enable internal 14-meg clock for ADC
	while (!(RCC->CR2 & RCC_CR2_HSI14RDY)) {}
	
	RCC->CFGR |= RCC_CFGR_PLLMUL12;						// PLL input clock x12
	
	RCC->AHBENR |= RCC_AHBENR_GPIOAEN |					// enable clock for GPIOA
				   RCC_AHBENR_GPIOBEN |					// enable clock for GPIOB
				   RCC_AHBENR_GPIOFEN;					// enable clock for GPIOF

	RCC->APB2ENR |= RCC_APB2ENR_TIM1EN |				// enable timer 1
				    RCC_APB2ENR_ADCEN |					// enable ADC
					RCC_APB2ENR_USART1EN;				// enable USART
}
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
void initAdc() {
	GPIOA->MODER |= (0b11 << GPIO_MODER_MODER0_Pos);	// analog mode for pin A-0 (sensor ADC in)	
	
	ADC1->CFGR1 |= (0b01 << ADC_CFGR1_RES_Pos) |		// 10 bit resolution (00=12, 01=10, 10=8,11=6)
				   ADC_CFGR1_CONT |						// continuous mode
				   ADC_CFGR1_OVRMOD;					// overrun mode: overwrite unread data
	
	ADC1->CHSELR |= ADC_CHSELR_CHSEL0;					// enable channel 1
	
	ADC1->SMPR |= (0b10 << ADC_SMPR_SMP_Pos);			// 13.5 clock sample duration
	
//	ADC1->IER |= ADC_IT_EOS |							// end of sequence interrupt
//			     ADC_IT_EOC;							// end of conversion interrupt
	
	ADC1->CR |= ADC_CR_ADEN;							// enable ADC
	while (!(ADC1->ISR & ADC_ISR_ADRDY)) { }
	
	ADC1->CR |= ADC_CR_ADSTART;							// start ADC
}
void initUsart() {
	int baud = 115200;
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER6_Pos) |		// alt function for pin B-6 (TX)
					(0x02 << GPIO_MODER_MODER7_Pos);		// alt function for pin B-7 (RX)
	
	GPIOB->OSPEEDR |= (0b11 << GPIO_OSPEEDR_OSPEEDR13_Pos) |// high speed for pin B-6 (TX)
		              (0b11 << GPIO_OSPEEDR_OSPEEDR14_Pos);	// high speed for pin B-7 (RX)
	
	GPIOB->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL6_Pos) |		// alt function 00 for pin B-6 (TX)
		             (0x00 << GPIO_AFRL_AFSEL7_Pos);		// alt function 00 for pin B-6 (TX)

	USART1->BRR = (8000000U + baud / 2U) / baud;			// baud rate (should be 69)
	
	CLEAR_BIT(USART1->CR2, (USART_CR2_LINEN | USART_CR2_CLKEN));
	CLEAR_BIT(USART1->CR3, (USART_CR3_SCEN | USART_CR3_HDSEL | USART_CR3_IREN));
	
	USART1->CR3 |= USART_CR3_OVRDIS;						// disable overrun error interrupt
	
	USART1->CR1 |= USART_CR1_TE |							// enable transmitter
		           USART_CR1_RE |							// enable receiver
				   USART_CR1_UE |							// enable usart
				   USART_CR1_RXNEIE;						// interrupt on receive
	
	while ((USART1->ISR & USART_ISR_TEACK) == 0) {}			// wait for transmitter to enable
	while ((USART1->ISR & USART_ISR_REACK) == 0) {}			// wait for receiver to enable
	
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_SetPriority(USART1_IRQn, 0);
}
void initSysTick(){
	SysTick->LOAD = (SysTick->CALIB & SysTick_CALIB_TENMS_Msk) - 1;	// 1 ms period
	SysTick->VAL = 0;
	SysTick->CTRL  = SysTick_CTRL_CLKSOURCE_Msk |		// enable source
	                 SysTick_CTRL_TICKINT_Msk   |		// enable interrupt
	                 SysTick_CTRL_ENABLE_Msk;			// enable systick
}

//

void usartSend(uint8_t *pData, uint16_t size){
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_TXE) == 0) {}			// wait for transmit data register empty
		USART1->TDR = (*pData++ & (uint8_t)0xFFU);
	}
	while ((USART1->ISR & USART_ISR_TC) == 0) {}				// wait for transmit complete
}
void usartReceive(uint8_t *pData, uint16_t size){
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_RXNE) == 0) {}			// wait for receive data register
		*pData++ = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);	// read byte
	}
}

void setPwm(int angle, int power) {
	TIM1->CCR1 = sin[angle % sin_size] * power / 256;
	TIM1->CCR2 = sin[(angle + phase2) % sin_size] * power / 256;
	TIM1->CCR3 = sin[(angle + phase3) % sin_size] * power / 256;
}
void delay(int ms) {
	int tick = gTickCount;
	while (gTickCount - tick < ms) {}
}
uint16_t getElectricDegrees(){
	uint16_t adc = ADC1->DR;
	gResult = ((adc - gCalib1) * 360 / gPhisicalToElec100) % 360;
	if (gResult < 0) gResult += 360;
	return gResult;
}

void calibrate() {
	const int turns = 3;
	int a = 0;
	
	// 1 back
	
	for (a = 360; a >= 0; a--)
	{
		delay(1);
		setPwm(a, 30);
	}
		
	setPwm(0, 30);
	delay(500);
	int adcStart1 = ADC1->DR;
	
	// 3 forward
	
	a = 0;
	for (a = 0; a <= 360 * turns; a+=2)
	{
		delay(1);
		setPwm(a, 30);
	}
	
	delay(500);	
	int adcEnd1 = ADC1->DR;
	int ratio1 = (adcStart1 - adcEnd1) / turns;
	
	// 3 backwards

	for (; a >=0; a-=2)
	{
		delay(1);
		setPwm(a, 30);
	}
	
	delay(500);	
	int adcStart2 = ADC1->DR;
	int ratio2 = (adcStart2 - adcEnd1) / turns;
	
	setPwm(a, 0);	
	
	//
	
	gCalib1 = (adcStart1 + adcStart2) / 2;
	gPhisicalToElec100 = (ratio1 + ratio2) / 2;
}

int main(void) {
	initVars();
	initClock();
	initPwm();
	initLed();
	initAdc();
	initUsart();
	initSysTick();

	while (true){
		if (pendingTorqueCommand)
		{
			sendBuffer[3] = (uint8_t)(ADC1->DR & (uint8_t)0x00FFU);
			sendBuffer[4] = (uint8_t)((ADC1->DR >> 8) & (uint8_t)0x00FFU);
			usartSend(sendBuffer, 5);
			pendingTorqueCommand = false;
		}
	}
}
