#ifndef __adc_H
#define __adc_H
#ifdef __cplusplus
 extern "C" {
#endif

#include "stm32f0xx_hal.h"
#include "main.h"

extern uint16_t			 adcCurrent;
extern uint16_t			 adcVoltage;

void initAdc(void);
void readAdc();

#ifdef __cplusplus
}
#endif
#endif