#include <main.h>

const int maxPoles = 40;

const int calibPower = sin_range / 2 / 3;
	
ConfigData* config = (ConfigData*)flashPageAddress;

int currentPole = 0;

int getElectricDegrees() {
	int x = (spiCurrentAngle - config->calibZero) % config->calibRate;
	return x * SENSOR_MAX / config->calibRate;
}

void findLinCoefficients() {
	int readings[numLinCoeff] = { 0 };
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
	if (!up) step *= -1;
	
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
		
		if (a < -sin_period)
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
	
	// sort coefficients
	
	bool swap;
	do
	{
		swap = false;
		
		for (int i = 0; i < numLinCoeff - 1; i++)
		{
			if (readings[i] > readings[i + 1])
			{
				int tmp = readings[i];
				readings[i] = readings[i + 1];
				readings[i + 1] = tmp;
				swap = true;
			}
		}
	} while (swap);	
	
	// store coeficients in flash
	
	ConfigData lc;
	memcpy(&lc, config, sizeof(ConfigData));
	
	for (int i = 0; i < numLinCoeff; i++)
	{
		lc.coefficients[i] = readings[i];
	}	
	
	lc.calibrated = true;
	lc.up = up;
	lc.poles = poles;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));		
}

void findElectricZeroAndRate() {
	int a = 0;
	int i = 0;
	int step = 4;
	int sensor;
	int zerosUp[maxPoles] = { 0 };
	int zerosDn[maxPoles] = { 0 };
	
	int calibZeros[maxPoles] = { 0 };
	int calibRates[maxPoles] = { 0 };

	// gently set 0 angle
	
	for (int p = 0; p < calibPower * 10; p++)
	{
		setPwm(0, p / 10);
	}

	for (a = 0; a < sin_period; a+=step)
	{
		setPwm(a, calibPower);
	}
	
	// full turn up
		
	for (i = 0; i < config->poles; i++)
	{
		for (a = 0; a < sin_period; a += step)
		{
			sensor = spiReadAngle();
			setPwm(a, calibPower);
		}
		
		zerosUp[i] = sensor;
	}
	
	// a bit more up then back down
	
	for (a = 0; a < sin_period; a+=step)
	{
		setPwm(a, calibPower);
	}
	
	for (; a > 0; a-=step)
	{
		setPwm(a, calibPower);
	}

	// full turn down
	
	for (; i > 0; i--)
	{
		for (a = sin_period; a > 0; a -= step)
		{
			sensor = spiReadAngle();
			setPwm(a, calibPower);
		}
		
		zerosDn[i] = sensor;
	}	
	
	// gently release
	
	for (int p = calibPower * 10; p > 0; p--)
	{
		delay(1);
		setPwm(0, p / 10);
	}

	setPwm(0, 0);
	
	// calc average zeros
	
	for (i = 0; i < config->poles; i++)
		calibZeros[i] = (zerosUp[i] + zerosDn[i]) / 2;
	
	// sort zeros
	
	bool swap;
	do
	{
		swap = false;
		
		for (int i = 0; i < config->poles - 1; i++)
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
	for (int i = 0; i < config->poles; i++)
	{
		int delta = calibZeros[i] - SENSOR_MAX * i / config->poles;
		sum += delta;
	}
	
	// store in flash
	
	ConfigData lc;
	memcpy(&lc, config, sizeof(ConfigData));
	
	lc.calibZero = sum / config->poles;
	lc.calibRate = SENSOR_MAX / config->poles;	
	
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));		
}

void calibrate() {
	A1335DisableLinearization();
	findLinCoefficients();
	A1335InitFromFlash();
	findElectricZeroAndRate();
}
