#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

const unsigned int flashPageAddress = 0x08007800;
const int maxPoles = 25;

struct ConfigData
{
	int controllerId = 0;
	
	int calibZeros[maxPoles] = { 0 };
	int calibRates[maxPoles] = { 0 };
	int calibPoles = 0;
	int calibHighestPole = 0;
	int calibLowestPole = 0;	
};

extern ConfigData* config;

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

void initSpi();
int spiReadAngle();
void spiUpdateTorque();

// usart ----------------------------------------------------------------------

extern volatile bool usartPendingTorqueCommand;
extern volatile int usartTorqueCommandValue;

void initUsart();
void usartSendAngle();

// flash ----------------------------------------------------------------------

void writeFlash(uint16_t* data, int count);

#endif