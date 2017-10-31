#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

extern int controllerId;

// clock ----------------------------------------------------------------------

extern unsigned int gTickCount;

void initClockInternal();
void initClockExternal();
void initSysTick();
void delay(int ms);

// pwm ------------------------------------------------------------------------

extern const int sin_size;
void initPwm();
void setPwm(int angle, int power);
void setPwmTorque();

// calibrate ------------------------------------------------------------------

void calibrate();
int getElectricDegrees();
	
// buttons --------------------------------------------------------------------

extern volatile bool button1Pressed;
extern volatile bool button2Pressed;

void initButtons();

// spi ------------------------------------------------------------------------

extern int spiCurrentAngle;
extern unsigned int spiTickAngleRead;

void initSpi();
int SpiReadAngle();

// usart ----------------------------------------------------------------------

extern volatile bool usartPendingTorqueCommand;
extern volatile int usartTorqueCommandValue;

void initUsart();
void usartSendAngle();

#endif