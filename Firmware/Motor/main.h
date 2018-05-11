#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

const unsigned int flashPageAddress = 0x08007800;
const int numQuadrants = 16;

struct QuadrantData
{
	unsigned int maxAngle;
	unsigned int minAngle;
	unsigned int range;
};

struct ConfigData
{
	int controllerId = 0;
	QuadrantData quadrants[numQuadrants] = { 0 };
	bool calibrated = false;
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

extern volatile bool buttonIdPressed;
extern volatile bool buttonCalibPressed;
extern volatile int buttonPressId;

void initButtons();
void blinkId(bool onOff);
void blinkCalib(bool onOff);
void incrementIdAndSave();

// spi ------------------------------------------------------------------------

//#define AS5048A
//#ifdef TLE_5012B
#define MA700

#ifdef AS5048A
	#define SENSOR_MAX 0x2000
#endif

#ifdef TLE_5012B
#define SENSOR_MAX 0x4000
#endif

#ifdef MA700
#define SENSOR_MAX 0x1000
#endif

extern int spiCurrentAngle;

void initSpi();
int spiReadAngle();
//void spiUpdateTorque();

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