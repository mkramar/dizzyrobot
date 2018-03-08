#include <main.h>

const int calibPower = 80;

ConfigData* config = (ConfigData*)flashPageAddress;

extern const int maxPoles;

int currentPole = 0;

int getElectricDegrees() {
	int x = (spiCurrentAngle - config->calibZero) % config->calibRate;
	return x * sin_size / config->calibRate;
}

void calibrate() {
	int a = 0;
	int i = 0;
	int sensor;
	int zerosUp[maxPoles] = { 0 };
	int zerosDn[maxPoles] = { 0 };
	
	int calibZeros[maxPoles] = { 0 };
	int calibRates[maxPoles] = { 0 };
	int calibPoles = 0;

	// gently set 0 angle
	
	for (int p = 0; p < calibPower * 10; p++)
	{
		delay(1);
		setPwm(0, p/10);
	}

	for (a = 0; a < sin_size; a++)
	{
		delay(1);
		setPwm(a, calibPower);
	}
	
	// full turn up
		
	while (true)
	{
		a = a % sin_size;
		if (a == 0)
		{
			int sensor = spiReadAngle();
			
			if (i > 2)
			{
				int d1 = zerosUp[1] - zerosUp[0];
				int d2 = zerosUp[2] - zerosUp[1];
				int d3 = zerosUp[0] - sensor;
				
				if (d1 < 0) d1 = -d1;
				if (d2 < 0) d2 = -d2;
				if (d3 < 0) d3 = -d3;
				
				if (d1 > d2) d1 = d2;
				
				if (d3 < d1 / 4) {
					break;
				}
			}
			
			zerosUp[i] = sensor;
			i++;			
		}
		
		a+=2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	calibPoles = i;
	
	// a bit more up then back down
	
	for (; a < sin_size; a++)
	{
		delay(1);
		setPwm(a, calibPower);
	}
	
	for (; a > 0; a--)
	{
		delay(1);
		setPwm(a, calibPower);
	}

	// full turn down
	
	while (i >= 0)
	{
		if (a == 0)
		{
			int sensor = spiReadAngle();			
			zerosDn[i] = sensor;
			i--;
		}
		
		a-=2;
		if (a < 0) a += sin_size;
		delay(1);
		setPwm(a, calibPower);
	}	
	
	// gently release
	
	for (int p = calibPower * 10; p > 0; p--)
	{
		delay(1);
		setPwm(0, p / 10);
	}

	setPwm(0, 0);
	
	// calc average zeros
	
	for (i = 0; i < calibPoles; i++)
		calibZeros[i] = (zerosUp[i] + zerosDn[i]) / 2;
	
	// sort zeros
	
	bool swap;
	do
	{
		swap = false;
		
		for (int i = 0; i < calibPoles - 1; i++)
		{
			if (calibZeros[i] > calibZeros[i + 1])
			{
				int tmp = calibZeros[i];
				calibZeros[i] = calibZeros[i + 1];
				calibZeros[i + 1] = tmp;
				swap = true;
			}
		}
	}
	while (swap);
	
	// calc average zero
	
	int sum = 0;
	for (int i = 0; i < calibPoles; i++)
	{
		int delta = calibZeros[i] - SENSOR_MAX * i / calibPoles;
		sum += delta;
	}
	
	ConfigData lc;
	lc.calibZero = sum / calibPoles;
	lc.calibRate = SENSOR_MAX / calibPoles;

	// store in flash
	
	lc.controllerId = config->controllerId;	
	writeFlash((uint16_t*)&lc, sizeof(ConfigData)/sizeof(uint16_t));
}

#if OLD

void calibrate() {
	const int turns = 5;
	const int power = 20;
	int a = 0;
	
	// set 0 angle
	
	for (a = 0; a < power * 10; a++)
	{
		delay(1);
		setPwm(0, a / 10);
	}

	delay(500);
	int adcStart1 = SpiReadAngle();

	// 3 forward
	
	a = 0;
	for (a = 0; a <= sin_size * turns; a += 2)
	{
		delay(1);
		setPwm(a, power);
	}
		
	delay(500);	
	int adcEnd1 = SpiReadAngle();
	int ratio1 = (adcEnd1 - adcStart1) / turns;
	
	// 3 backwards

	for (; a >= 0; a -= 2)
	{
		delay(1);
		setPwm(a, power);
	}
	
	delay(500);	
	int adcStart2 = SpiReadAngle();
	int ratio2 = (adcEnd1 - adcStart2) / turns;
	
	setPwm(a, 0);	

	//
	
	calibZeroAngle = (adcStart1 + adcStart2) / 2;
	calibAglePerElecTurn = (ratio1 + ratio2) / 2;
}

#endif