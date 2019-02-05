#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

#define POSITIVE_MODULO(A, B)	((A % B + B) %B)

const int sin_period = (1 << 15);		// 32K or 0x8000
const int sin_range = (1 << 13);		//  8K or 0x2000

const unsigned int flashPageAddress = 0x08007800;
const int numInternalQuadrants = 32;
const int numExternalQuadrants = 6;
const int externalQuadrantSize = sin_period / numExternalQuadrants;

struct QuadrantData
{
	unsigned int maxAngle;
	unsigned int minAngle;
	unsigned int range;
};

struct ConfigData
{
	int controllerId = 0;
	QuadrantData internalQuadrants[numInternalQuadrants] = { 0 };
	QuadrantData externalQuadrants[numExternalQuadrants] = { 0 };
	bool up = false;
	int calibrated = 0;
};


extern ConfigData* config;

// clock ----------------------------------------------------------------------

extern unsigned int gTickCount;

void initClockInternal();
void initClockExternal();
void initSysTick();
void delay(int ms);

// pwm ------------------------------------------------------------------------

void initPwm();
void setPwm(int angle, int power);
void setPwmTorque();

// calibrate ------------------------------------------------------------------

void calibrate();
int getElectricDegrees();
	
// temperature ----------------------------------------------------------------

void initTemperature();
extern int temperature;
extern bool tempShutdown;

// status ---------------------------------------------------------------------

void setStatus(bool blink);

// spi ------------------------------------------------------------------------

#define SENSOR_MAX sin_period	// 32K

extern int spiCurrentAngleInternal;
extern int spiCurrentAngleExternal;

void initSpi();
int spiReadAngleInternal();
int spiReadAngleExternal();

// usart ----------------------------------------------------------------------

extern volatile int usartTorqueCommandValue;
extern volatile bool usartDmaSendRequested;
extern volatile bool usartDmaSendBusy;
extern volatile bool usartCommandReceived;

void initUsart();
void usartSendAngle();
void processUsartCommand();

// flash ----------------------------------------------------------------------

void writeFlash(uint16_t* data, int count);
void memcpy(void *dst, const void *src, int count);

#endif