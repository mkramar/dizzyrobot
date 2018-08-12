#include <main.h>

const int maxPoles = 40;

const int calibPower = sin_range / 2 / 3;
	
ConfigData* config = (ConfigData*)flashPageAddress;

int currentPole = 0;

int getElectricDegrees() {
	int x = (spiCurrentAngle - config->calibZero) % config->calibRate;
	return x * sin_period / config->calibRate;
}

void getLinCoefficients(int* readings) {
	int step = 4;
	int a = 0;
	int i = 0;
	int sensor;
	int prevSensor;
	int firstSensor;
	int poles = 0;
	bool up;
	
	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	// up or down?
	
	prevSensor = spiReadAngle();
	
	int nUp = 0;
	int nDn = 0;
	for (int i = 0; i < 50000; i++)
	{
		sensor = spiReadAngle();
		
		if (sensor > prevSensor) nUp++;
		else nDn++;
		
		a += step;
		setPwm(a, calibPower);
		
		prevSensor = sensor;
	}
	
	up = nUp > nDn;
	if (up) step *= -1;
	
	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	a = 0;
	
	// calc number of poles
	
	spiReadAngle();
	prevSensor = spiReadAngle();
	
	bool crossed = false;
	int crossPole = 0;
	
	while (true)
	{
		a += step;
		setPwm(a, calibPower);

		sensor = spiReadAngle();
		
		if (a > sin_period)
		{
			poles++;
			a -= sin_period;
		}
		
		if (a < sin_period)
		{
			poles++;
			a += sin_period;
		}		
		
		if (prevSensor - sensor > SENSOR_MAX / 2 ||
			sensor - prevSensor > SENSOR_MAX / 2)
		{
			if (crossed && poles != crossPole)
			{
				poles -= crossPole;
				break;
			}
			else
			{
				crossPole = poles;
				crossed = true;
			}
		}
		
		prevSensor = sensor;
	}

	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	a = 0;
	
	// move to 16 measurement points
	
	spiReadAngle();
	
	int nextPoint = 0;
	int nextAngle = 0;
	while (true)
	{
		if (up && a >= nextAngle || !up && a <= nextAngle)
		{
			readings[nextPoint] = spiReadAngle();
			
			nextPoint++;
			nextAngle = poles * sin_period * nextPoint / numLinCoeff;
			if (!up) nextAngle *= -1;
			
			if (nextPoint >= numLinCoeff) break;
		}
		
		a += step;
		setPwm(a, calibPower);
		spiReadAngle();	
	}
}

void getElectricZeroAndRate(int* calibZero, int* calibRate) {
	int a = 0;
	int i = 0;
	int step = 5;
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
		setPwm(0, p / 10);
	}

	for (a = 0; a < sin_period; a+=step)
	{
		setPwm(a, calibPower);
	}
	
	// full turn up
		
	while (true)
	{
		a = a % sin_period;
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
		
		a += step;
		setPwm(a, calibPower);
	}
	
	calibPoles = i;
	
	// a bit more up then back down
	
	for (; a < sin_period; a+=step)
	{
		setPwm(a, calibPower);
	}
	
	for (; a > 0; a-=step)
	{
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
		
		a -= step;
		if (a < 0) a += sin_period;
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
	} while (swap);
	
	// calc average zero
	
	int sum = 0;
	for (int i = 0; i < calibPoles; i++)
	{
		int delta = calibZeros[i] - sin_period * i / calibPoles;
		sum += delta;
	}
	
	*calibZero = sum / calibPoles;
	*calibRate = sin_period / calibPoles;	
}

void calibrate() {
	int readings[numLinCoeff] = { 0 };
	getLinCoefficients(readings);
	
	// store coeficients in flash
	
	ConfigData lc;
	lc.controllerId = config->controllerId;	
	
	for (int i = 0; i < numLinCoeff; i++)
	{
		lc.coefficients[i] = readings[i];
	}	
	
	lc.calibrated = true;
	//lc.up = up;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));	
	
	// write coefficients to sensor
	
	A1335InitFromFlash();
	
	// now that it is linearized, get electrical zero
	
	getElectricZeroAndRate(&lc.calibZero, &lc.calibRate);

	// store in flash
	
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));	
}
