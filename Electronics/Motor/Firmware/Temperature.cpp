#include <main.h>
#include <stm32f0xx_ll_adc.h>

const uint32_t TEMP_PERIOD = 1000;
const uint32_t TEMP_PRESCALER = 48000;
const uint8_t	TEMP_CUTOFF = 60;
const uint8_t	TEMP_RELEASE = 55;
const uint8_t	TEMP_READINGS = 5;

#define TEMP110_CAL_ADDR TEMPSENSOR_CAL2_ADDR
#define TEMP30_CAL_ADDR TEMPSENSOR_CAL1_ADDR

int temperature; // temperature in degrees Celsius
bool tempShutdown = false;
int readingsAbove = 0;
int readingsBelow = 0;

extern "C"
void TIM3_IRQHandler(void) {
	TIM3->SR &= ~TIM_SR_UIF;
	
	// temp
	
	int sensor = ADC1->DR;
	int calib30 = (int) *TEMP30_CAL_ADDR;
	int calib110 = (int) *TEMP110_CAL_ADDR;
	
	temperature = (sensor - calib30) * (110 - 30) / (calib110 - calib30) + 30;
	
	if (temperature > TEMP_CUTOFF)
	{
		readingsAbove++;
		if (readingsAbove > TEMP_READINGS) 
		{
			tempShutdown = true;
			usartTorqueCommandValue = 0;
		}
	}
	else readingsAbove = 0;
	
	if (temperature < TEMP_RELEASE)
	{
		readingsBelow++;
		if (readingsBelow > TEMP_READINGS) tempShutdown = false;
	}
	else readingsBelow = 0;
}

void initTemperature(){
	// timer
	
	RCC->APB1ENR |= RCC_APB1ENR_TIM3EN;					// enable timer 3
	
	TIM3->ARR = TEMP_PERIOD;							// tim3 period
	TIM3->PSC = TEMP_PRESCALER;							// prescaler

	TIM3->DIER |= TIM_DIER_UIE;							// enable update interrupt
	TIM3->CR1 |= TIM_CR1_CEN;							// enable timer 3	
	
	HAL_NVIC_SetPriority(TIM3_IRQn, 1, 1);
	HAL_NVIC_EnableIRQ(TIM3_IRQn);
	
	// ADC
	
	RCC->APB2ENR |= RCC_APB2ENR_ADCEN;
	RCC->APB2ENR |= RCC_APB2ENR_ADC1EN;					// enable ADC1
	
	ADC1->CHSELR = ADC_CHSELR_CHSEL16;					//  Select CHSEL16 for temperature sensor
	ADC1->SMPR |= ADC_SMPR_SMP_0 | ADC_SMPR_SMP_1 | ADC_SMPR_SMP_2;	// sample rate
	ADC->CCR |= ADC_CCR_TSEN;							// enable temp sensor
	ADC->CCR |= ADC_CCR_VREFEN;							// enable internal voltage reference
	
	ADC1->CFGR1 |= ADC_CFGR1_CONT;						// continous mode 
		
	ADC1->CR |= ADC_CR_ADEN;							// enable ADC
	while ((ADC1->ISR & ADC_ISR_ADRDY) == 0) {}			// wait for ADC to be ready
		
	ADC1->CR |= ADC_CR_ADSTART;
}