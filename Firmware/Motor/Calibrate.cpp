#include <main.h>

const int calibPower = 20;
int calibZeros[50] = { 0 };
int calibRates[50] = { 0 };
int calibPoles = 0;
int calibCurrentPole = 0;
int calibHighestPole = 0;
int calibLowestPole = 0;
bool calibGoUp;

int getElectricDegrees() {
	while (spiCurrentAngle > calibZeros[calibCurrentPole + 1] && calibCurrentPole != calibHighestPole)
	{
		calibCurrentPole++;
		if (calibCurrentPole == calibPoles) calibCurrentPole = 0;
	}
	while (spiCurrentAngle < calibZeros[calibCurrentPole] && calibCurrentPole != calibLowestPole) 
	{
		calibCurrentPole--;
		if (calibCurrentPole < 0) calibCurrentPole = calibPoles - 1;
	}
	
	int retval = ((spiCurrentAngle - calibZeros[calibCurrentPole]) * sin_size / calibRates[calibCurrentPole]) % sin_size;
//	//if (retval < 0) retval += sin_size;
	return retval;	
}

void calibrate() {
	int a = 0;
	int sensor;
	
	// set 0 angle
	
	for (int p = 0; p < calibPower * 10; p++)
	{
		delay(1);
		setPwm(0, p/10);
	}

	delay(500);
	
	// go
		
	while (true)
	{
		a = a % sin_size;
		if (a == 0)
		{
			int sensor = SpiReadAngle();
			
			if (calibPoles > 1)
			{
				int d1 = calibZeros[1] - calibZeros[0];
				int d2 = calibZeros[0] - sensor;
				if (d1 < 0) d1 = -d1;
				if (d2 < 0) d2 = -d2;
				
				if (d2 < d1 / 4) break;
			}
			
			calibZeros[calibPoles] = sensor;
			calibPoles++;			
		}
		
		a++;
		delay(1);
		setPwm(a, calibPower);
	}
	
	setPwm(a, 0);
	
	// up or down?

	int up = 0;
	int down = 0;
	
	for (int i = 1; i < calibPoles; i++)
	{
		if (calibZeros[i - 1] < calibZeros[i]) up++;
		else down++;
	}
	
	calibGoUp = up > down;
	
	// rates
	
	calibRates[0] = calibZeros[0] - calibZeros[calibPoles - 1];
	
	for (int i = 1; i < calibPoles; i++)
	{
		calibRates[i] = calibZeros[i] - calibZeros[i - 1];
		
		if (calibGoUp && calibZeros[i] < calibZeros[i - 1]) 
			calibRates[i] += 0x4000;
	}
	
	// find highest & lowest
	
	for (int i = 1; i < calibPoles; i++)
	{
		if (calibZeros[calibHighestPole] < calibZeros[i]) calibHighestPole = i;
		if (calibZeros[calibLowestPole] > calibZeros[i]) calibLowestPole = i;
	}
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