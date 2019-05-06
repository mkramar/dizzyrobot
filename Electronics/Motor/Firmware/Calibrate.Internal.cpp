#include <main.h>
#include <QuadrantDetector.h>

const int calibPower = sin_range / 2;
const int quadrantDivInternal = SENSOR_MAX / numInternalQuadrants;

int getNumPoles() {
	const int step = 5;
	int a = 0;
	int internal = spiReadAngleInternal();
	int firstInternal;
	int poles;
	
	// move away from zero where overflow occurs
	
	while (true)
	{
		internal = spiReadAngleInternal();
		if (internal > 4000 && internal < 28000) break;
		
		for (a = 0; a < sin_period; a += step)
			setPwm(a, calibPower);	
	}
	
	firstInternal = internal;
	
	// count poles
	
	bool away = false;
	
	for (poles = 0; ; poles ++)
	{
		internal = spiReadAngleInternal();
		
		if (away)
		{
			if (internal - firstInternal < 300 &&
				internal - firstInternal > -300) break;
		}
		else
		{
			if (internal - firstInternal > 8000 ||
				firstInternal - internal > 8000) 
			{
				away = true; 
			}
		}
		
		for (a = 0; a < sin_period; a += step)
			setPwm(a, calibPower);
	}
	
	return poles;
}

void calibrateInternal() {
	const int step = 5;
	int a = 0;
	int i = 0;
	int q;
	int internal = spiReadAngleInternal();
	
	QuadrantDetector detector(numInternalQuadrants, quadrantDivInternal);
	
	int qUp[numInternalQuadrants] = { 0 };

	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	delay(500);
	
	// calc num poles
	
	int numPoles = getNumPoles();

//	// find the edge of the quadrant
//
//	while (a < sin_period)
//	{		
//		a += step;
//		delay(1);
//		setPwm(a, calibPower);				
//	}
	a = 0;

	internal = spiReadAngleInternal();
	while (detector.detectQuadrant(internal) == -1)
	{
		internal = spiReadAngleInternal();
		a += step;
		setPwm(a, calibPower);		
	}
	
	// full turn up
	
	for (i = 0; i < numInternalQuadrants;)
	{
		internal = spiReadAngleInternal();
		q = detector.detectQuadrant(internal);
		if (q != -1)
		{
			int trueAngle = a / numPoles;
			qUp[q] = trueAngle;
			i++;
		}
			
		a += step;
		setPwm(a, calibPower);				
	}	
	
	// gently release
	
	for (int p = calibPower / 10; p > 0; p--)
	{
		delay(1);
		setPwm(a, p * 10);
	}

	setPwm(0, 0);
	
	//
	
	ConfigData lc;
	memcpy(&lc, config, sizeof(ConfigData));
	
	for (q = 0; q < numInternalQuadrants; q++)
	{
		int a1 = q;
		int b1 = (q + 1) % numInternalQuadrants;
		
		int qThis = qUp[a1];
		int qNext = qUp[b1];
		
		lc.internalQuadrants[q].minAngle = qThis;
		
		if (qNext < qThis)
			lc.internalQuadrants[q].maxAngle = qNext + SENSOR_MAX;
		else
			lc.internalQuadrants[q].maxAngle = qNext;
		
		lc.internalQuadrants[q].range = lc.internalQuadrants[q].maxAngle - lc.internalQuadrants[q].minAngle;
	}	
	
	// store in flash
	lc.calibrated = 1;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));
}