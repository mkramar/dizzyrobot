#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

extern int controllerId;

// clock ----------------------------------------------------------------------

extern uint32_t gTickCount;

void initClockInternal();
void initClockExternal();
void initSysTick();
void delay(int ms);

// pwm ------------------------------------------------------------------------

void initPwm();
void setPwm(int angle, int power);
void setPwmTorque();
	
// buttons --------------------------------------------------------------------

extern volatile bool button1Pressed;
extern volatile bool button2Pressed;

void initButtons();

// spi ------------------------------------------------------------------------

extern uint16_t spiCurrentAngle;
extern uint32_t spiTickAngleRead;

void initSpi();
uint16_t SpiReadAngle();

// usart ----------------------------------------------------------------------

extern volatile bool usartPendingTorqueCommand;
extern volatile int usartTorqueCommandValue;

void initUsart();
void usartSendAngle();

#endif