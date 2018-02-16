#include <stm32f0xx_hal.h>
#include <stm32_hal_legacy.h>

#ifndef MAIN_H
#define MAIN_H

const unsigned int flashPageAddress = 0x08007800;
const int maxPoles = 25;

struct ConfigData
{
	int controllerId = 0;
	
	int calibZero = 0;
	int calibRate = 0;
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

extern int spiCurrentAngle;

void initSpi();
int spiReadAngle();
void spiUpdateTorque();

// usart ----------------------------------------------------------------------

extern volatile int usartTorqueCommandValue;
extern volatile bool usartDmaSendRequested;
extern volatile bool usartDmaSendBusy;

void initUsart();
void usartSendAngle();

// flash ----------------------------------------------------------------------

void writeFlash(uint16_t* data, int count);
void memcpy(void *dst, const void *src, int count);

#endif