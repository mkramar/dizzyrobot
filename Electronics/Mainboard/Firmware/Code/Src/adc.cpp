#include "adc.h"
#include "gpio.h"

uint16_t adcCurrent;
uint16_t adcVoltage;
uint8_t  adcSequence = 0;

void initAdc(void) {
	// calibration
	
	ADC1->CR |= ADC_CR_ADCAL;
	while (ADC1->CR & ADC_CR_ADCAL) {}
	
	// enable discontinous mode so ADC stops after converting single channel
	ADC1->CFGR1 |= ADC_CFGR1_DISCEN;
	
	// 7.5 cycles sampling time
	ADC1->SMPR = 1;
	
	// enable channels 0 (current) and 8 (voltage)
	ADC1->CHSELR = ADC_CHSELR_CHSEL0 | ADC_CHSELR_CHSEL18;
	
	// enable ADC
	ADC1->CR |= ADC_CR_ADEN;
	while (!(ADC1->ISR & ADC_ISR_ADRDY)) {}
	
	// start first conversion
	ADC1->CR |= ADC_CR_ADSTART;
}

void readAdc() {
	if (ADC1->ISR & ADC_ISR_EOC)
	{
		if (adcSequence == 0)
		{
			adcCurrent = ADC1->DR;
			adcSequence = 1;
		}
		else
		{
			adcVoltage = ADC1->DR;
			adcSequence = 0; 
		}
		
		// start new conversion
		ADC1->CR |= ADC_CR_ADSTART;
	}
}
