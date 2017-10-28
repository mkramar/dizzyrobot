#include <main.h>

int32_t gCalib1;
int32_t gPhisicalToElec100;

volatile int gResult;

int getElectricDegrees() {
	gResult = ((spiCurrentAngle - gCalib1) * 360 / gPhisicalToElec100) % 360;
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
	int adcStart1 = SpiReadAngle();

	// 3 forward
	
	a = 0;
	for (a = 0; a <= 360 * turns; a += 2)
	{
		delay(1);
		setPwm(a, 30);
	}
		
	delay(500);	
	int adcEnd1 = SpiReadAngle();
	int ratio1 = (adcStart1 - adcEnd1) / turns;
	
	// 3 backwards

	for (; a >= 0; a -= 2)
	{
		delay(1);
		setPwm(a, 30);
	}
	
	delay(500);	
	int adcStart2 = SpiReadAngle();
	int ratio2 = (adcStart2 - adcEnd1) / turns;
	
	setPwm(a, 0);	

	//
	
	gCalib1 = (adcStart1 + adcStart2) / 2;
	gPhisicalToElec100 = (ratio1 + ratio2) / 2;
}
