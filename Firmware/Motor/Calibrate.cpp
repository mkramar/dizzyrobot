#include <main.h>

const int calibPower = 20;
//int calibCurrentPole = 0;

ConfigData* config = (ConfigData*)flashPageAddress;

extern const int maxPoles;

int getElectricDegrees() {
	int a = spiCurrentAngle - config->calibZeros[0];
	if (a > 0) 
	{
		int pole = a * config->calibPoles / 0x4000;
	
		int retval = ((a - config->calibZeros[pole]) * sin_size / config->calibRates[pole]) % sin_size;
		return retval;
	}
	else
	{
		int pole = config->calibPoles - 1;
		a = spiCurrentAngle + (0x4000 - config->calibZeros[pole]);
		int retval = (a * sin_size / config->calibRates[pole]) % sin_size;
		return retval;
	}
}

void calibrate() {
	int a = 0;
	int i = 0;
	int sensor;
	int zerosUp[maxPoles] = { 0 };
	int zerosDn[maxPoles] = { 0 };
	
	ConfigData lc;

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
	
	lc.calibPoles = i;
	
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
	
	for (i = 0; i < lc.calibPoles; i++)
		lc.calibZeros[i] = (zerosUp[i] + zerosDn[i]) / 2;
	
	// rates
	
	for (int i = 1; i < lc.calibPoles; i++)
	{
		lc.calibRates[i] = lc.calibZeros[i] - lc.calibZeros[i - 1];
		
		if (/*calibGoUp && */lc.calibZeros[i] < lc.calibZeros[i - 1]) 
			lc.calibRates[i] += 0x4000;
	}
	
	lc.calibRates[0] = lc.calibRates[lc.calibPoles - 1];

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