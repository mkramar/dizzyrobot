#include <main.h>

const int maxPoles = 5;

const int calibPower = sin_range/2;
const int quadrantDiv = SENSOR_MAX / numInternalQuadrants;
	
ConfigData* config = (ConfigData*)flashPageAddress;

int currentPole = 0;

int getElectricDegrees() {
	int angle = spiCurrentAngleInternal % sin_period;
	if (angle < 0) angle += sin_period;
	
	int a;
	int q = angle / quadrantDiv;
	int range = config->internalQuadrants[q].range;
	int qstart;
	
	if (config->up)
	{
		int min = config->internalQuadrants[q].minAngle;
		qstart = q * quadrantDiv;
		a = min + (angle - qstart) * range / quadrantDiv;
	}
	else
	{
		int max = config->internalQuadrants[q].maxAngle;
		qstart = q * quadrantDiv;
		a = max - (angle - qstart) * range / quadrantDiv;
	}
	
	return a;
}

void calibrate() {
	const int step = 5;
	int a = 0;
	int i = 0;
	int internal = spiReadAngleInternal();
	int external = spiReadAngleExternal();
	int prevInternal;
	
	bool up;
	int q = 0;
	int q1;
	int pole = 0;
	int prevQ = -1;
	int firstQ = -1;
	int quadrantsLeft = numInternalQuadrants;
	
	// init arrays
	
	QuadrantData qUp[numInternalQuadrants] = { 0 };
	QuadrantData qDn[numInternalQuadrants] = { 0 };
	
	int qExt[numExternalQuadrants][maxPoles * 2] = { 0 };
	
	for (i = 0; i < numInternalQuadrants; i++)
	{
		qUp[i].minAngle = 0xFFFFFF;
		qDn[i].maxAngle = 0xFFFFFF;
	}

	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	// find the edge of the quadrant, detect direction
	
	int internalFirst = spiReadAngleInternal();
	int prevExternal = -1;
	while (pole < maxPoles)
	{
		external = spiReadAngleExternal();
		
		if (a / externalQuadrantSize != (a + step) / externalQuadrantSize)
		{
			int aq = a % sin_period;
			int n = aq / externalQuadrantSize;
			
//			if (n == 13)
//			{
//				int test = 0;
//				test += 34 - a;
//			}
			
			qExt[n][pole] = external;
		}
		if (a / sin_period != (a + step) / sin_period) pole++;
		
		a += step;
		delay(1);
		setPwm(a, calibPower);		
	}
	
	pole--;
	while (a >= 0)
	{
		external = spiReadAngleExternal();
		
		if (a / sin_period != (a - step) / sin_period) pole++;
		if (a / externalQuadrantSize != (a - step) / externalQuadrantSize)
		{
			int aq = a % sin_period;
			int n = aq / externalQuadrantSize;
			
//			if (n == 13)
//			{
//				int test = 0;
//				test += 34 - a;
//			}
			
			qExt[n][pole] = external;
		}
		
		a -= step;
		delay(1);
		setPwm(a, calibPower);		
	}	
/*	
	if (internal > internalFirst)
	{
		if (internal - internalFirst < internalFirst + (SENSOR_MAX - internal))
			up = true;
		else
			up = false;
	}
	else
	{
		if (internalFirst - internal < internal + (SENSOR_MAX - internalFirst))
			up = false;
		else
			up = true;
	}
*/
/*	
	// full turn forward

	bool awayFromFirst = false;
	bool backToFirst = false;
	prevQ = q;
	while (true)
	{
		// linearization calibration - internal
		
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		if (q != prevQ)
		{
			q1 = q;
		}

		// noice on the quadrant edges
		if (up)
		{
			if ((q != 0 || prevQ != numInternalQuadrants - 1) && q < prevQ) q = prevQ;
			else if (q == numInternalQuadrants - 1 && prevQ == 0) q = prevQ;
		}
		else
		{
			if ((q != numInternalQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
			else if (q == 0 && prevQ == numInternalQuadrants - 1) q = prevQ;
		}

		if (q != prevQ)
		{
			prevQ = q;			
		}
		if (firstQ == -1) firstQ = q;
		prevQ = q;		
		
		awayFromFirst |= (q - firstQ  == numInternalQuadrants / 2) || (firstQ - q == numInternalQuadrants / 2);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qUp[q].minAngle > a) qUp[q].minAngle = a;
		if (qUp[q].maxAngle < a) qUp[q].maxAngle = a;
		
		// electric calibration - external
		
		external = spiReadAngleExternal();
		
		a += step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
		
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		qUp[i].range = qUp[i].maxAngle - qUp[i].minAngle;
	}
*/
	//  up and down
/*	
	int qForth, qBack;
	if (up)
	{
		qForth = q + 1;
		if (qForth == numInternalQuadrants) qForth = 0;
		
		qBack = q - 1;
		if (qBack == -1) qBack = numInternalQuadrants - 1;
	}
	else
	{
		qForth = q - 1;
		if (qForth == -1) qForth = numInternalQuadrants - 1;
		
		qBack = q + 1;
		if (qBack == numInternalQuadrants) qBack = 0;
	}
	
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		
		if (q == qForth) break;
		
		a += step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		
		if (q == qBack) break;
		
		a -= step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
*/
	// full turn back
/*	
	awayFromFirst = false;
	backToFirst = false;
	firstQ = -1;
	prevQ = q;
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		if (q != prevQ)
		{
			q1 = q;
		}

		// noice on the quadrant edges
		if (up)
		{
			if ((q != numInternalQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
			else if (q == 0 && prevQ == numInternalQuadrants - 1) q = prevQ;
		}
		else
		{
			if ((q != 0 || prevQ != numInternalQuadrants - 1) && q < prevQ) q = prevQ;
			else if (q == numInternalQuadrants - 1 && prevQ == 0) q = prevQ;
		}

		if (q != prevQ)
		{
			prevQ = q;
		}
		if (firstQ == -1) firstQ = q;
		prevQ = q;
		
		awayFromFirst |= (q - firstQ  == numInternalQuadrants / 2) || (firstQ - q == numInternalQuadrants / 2);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qDn[q].minAngle > a) qDn[q].minAngle = a;
		if (qDn[q].maxAngle < a) qDn[q].maxAngle = a;
		
		a -= step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
*/
	// gently release
	
	for (int p = calibPower / 10; p > 0; p--)
	{
		delay(1);
		setPwm(a, p * 10);
	}

	setPwm(0, 0);
	
	// prepare external data
	
	for (q = 0; q < numExternalQuadrants; q++)
	{
		// see if this quadrant is split
		
		for (int p = 1; p < pole; p++)
		{
			int interPoleDiff = qExt[q][0] - qExt[q][p];
			if (interPoleDiff > SENSOR_MAX / 2)
			{
				qExt[q][p] += SENSOR_MAX;
			}
			if (interPoleDiff < - SENSOR_MAX / 2)
			{
				qExt[q][p] -= SENSOR_MAX;
			}
		}
	}
	
//	for (int p = 0; i < actualPoles; p++)
//	{
//		// see if this pole is split
//		
//		for (i = 0; i < numExternalQuadrants; i++)
//			qExt[i].minAngle /= nExt[i];
//
//	}
//	
//	for (i = 0; i < numExternalQuadrants; i++)
//		qExt[i].minAngle /= nExt[i];
//		
//	for (i = 0; i < numExternalQuadrants - 1; i++)
//		qExt[i].maxAngle = qExt[i + 1].minAngle;
//	
//	qExt[i].maxAngle = qExt[0].minAngle + sin_period;
//	
//	for (i = 0; i < numExternalQuadrants; i++)
//		qExt[i].range = qExt[i].maxAngle - qExt[i].minAngle;
	
	// prepare internal data
	
	ConfigData lc;
	lc.controllerId = config->controllerId;	
	
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		qDn[i].range = qDn[i].maxAngle - qDn[i].minAngle;
	}	
	
	// calc average quadrants for sensor tuning
/*
	int minRange;
	int maxRange;
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		lc.internalQuadrants[i].minAngle = (qUp[i].minAngle + qDn[i].minAngle) / 2;
		lc.internalQuadrants[i].maxAngle = (qUp[i].maxAngle + qDn[i].maxAngle) / 2;
		int range = lc.internalQuadrants[i].maxAngle - lc.internalQuadrants[i].minAngle;
		lc.internalQuadrants[i].range = range;
		
		if (i == 0 || minRange > range) minRange = range;
		if (i == 0 || maxRange < range) maxRange = range;
	}
*/
	// store in flash
	lc.calibrated = 1;
	lc.up = up;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));
}
void calibrate_proper() {
	const int step = 5;
	int a = 0;
	int i = 0;
	int internal = spiReadAngleInternal();
	int external = spiReadAngleExternal();
	int prevInternal;
	
	bool up;
	int q = 0;
	int prevQ = -1;
	int firstQ = -1;
	int quadrantsLeft = numInternalQuadrants;
	
	QuadrantData qUp[numInternalQuadrants] = { 0 };
	QuadrantData qDn[numInternalQuadrants] = { 0 };
	
	for (i = 0; i < numInternalQuadrants; i++)
	{
		qUp[i].minAngle = 0xFFFFFF;
		qDn[i].minAngle = 0xFFFFFF;
	}

	// gently set 0 angle
	
	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}
	
	// find the edge of the quadrant, detect direction
	
	int internalFirst = spiReadAngleInternal();
	int q1 = -1;
	int q2 = -1;
	int q3 = -1;
	while (true)
	{
		internal = spiReadAngleInternal();
		prevInternal = internal;
		q = internal / quadrantDiv;
			
		if (q1 == -1) q1 = q;
		else if (q2 == -1 && q1 != q) q2 = q;
		else if (q3 == -1 && q1 != q && q2 != q) q3 = q;
		else if (q1 != q && q2 != q && q3 != q) break;
		
		a += step;
		delay(1);
		setPwm(a, calibPower);		
	}
	
	if (internal > internalFirst)
	{
		if (internal - internalFirst < internalFirst + (SENSOR_MAX - internal))
			up = true;
		else
			up = false;
	}
	else
	{
		if (internalFirst - internal < internal + (SENSOR_MAX - internalFirst))
			up = false;
		else
			up = true;
	}

	// full turn forward

	bool awayFromFirst = false;
	bool backToFirst = false;
	prevQ = q;
	while (true)
	{
		// linearization calibration - internal
		
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		if (q != prevQ)
		{
			q1 = q;
		}

		// noice on the quadrant edges
		if (up)
		{
			if ((q != 0 || prevQ != numInternalQuadrants - 1) && q < prevQ) q = prevQ;
			else if (q == numInternalQuadrants - 1 && prevQ == 0) q = prevQ;
		}
		else
		{
			if ((q != numInternalQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
			else if (q == 0 && prevQ == numInternalQuadrants - 1) q = prevQ;
		}

		if (q != prevQ)
		{
			prevQ = q;			
		}
		if (firstQ == -1) firstQ = q;
		prevQ = q;		
		
		awayFromFirst |= (q - firstQ  == numInternalQuadrants / 2) || (firstQ - q == numInternalQuadrants / 2);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qUp[q].minAngle > a) qUp[q].minAngle = a;
		if (qUp[q].maxAngle < a) qUp[q].maxAngle = a;
		
		// electric calibration - external
		
		external = spiReadAngleExternal();
		
		a += step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
		
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		qUp[i].range = qUp[i].maxAngle - qUp[i].minAngle;
	}
	
	//  up and down
	
	int qForth, qBack;
	if (up)
	{
		qForth = q + 1;
		if (qForth == numInternalQuadrants) qForth = 0;
		
		qBack = q - 1;
		if (qBack == -1) qBack = numInternalQuadrants - 1;
	}
	else
	{
		qForth = q - 1;
		if (qForth == -1) qForth = numInternalQuadrants - 1;
		
		qBack = q + 1;
		if (qBack == numInternalQuadrants) qBack = 0;
	}
	
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		
		if (q == qForth) break;
		
		a += step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		
		if (q == qBack) break;
		
		a -= step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	// full turn back
	
	awayFromFirst = false;
	backToFirst = false;
	firstQ = -1;
	prevQ = q;
	while (true)
	{
		internal = spiReadAngleInternal();
		q = internal / quadrantDiv;
		if (q != prevQ)
		{
			q1 = q;
		}

		// noice on the quadrant edges
		if (up)
		{
			if ((q != numInternalQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
			else if (q == 0 && prevQ == numInternalQuadrants - 1) q = prevQ;
		}
		else
		{
			if ((q != 0 || prevQ != numInternalQuadrants - 1) && q < prevQ) q = prevQ;
			else if (q == numInternalQuadrants - 1 && prevQ == 0) q = prevQ;
		}

		if (q != prevQ)
		{
			prevQ = q;
		}
		if (firstQ == -1) firstQ = q;
		prevQ = q;
		
		awayFromFirst |= (q - firstQ  == numInternalQuadrants / 2) || (firstQ - q == numInternalQuadrants / 2);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qDn[q].minAngle > a) qDn[q].minAngle = a;
		if (qDn[q].maxAngle < a) qDn[q].maxAngle = a;
		
		a -= step * 2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	// gently release
	
	for (int p = calibPower / 10; p > 0; p--)
	{
		delay(1);
		setPwm(a, p * 10);
	}

	setPwm(0, 0);
	
	ConfigData lc;
	lc.controllerId = config->controllerId;	
	
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		qDn[i].range = qDn[i].maxAngle - qDn[i].minAngle;
	}	
	
	// calc average quadrants
	
	int minRange;
	int maxRange;
	for (int i = 0; i < numInternalQuadrants; i++)
	{
		lc.internalQuadrants[i].minAngle = (qUp[i].minAngle + qDn[i].minAngle) / 2;
		lc.internalQuadrants[i].maxAngle = (qUp[i].maxAngle + qDn[i].maxAngle) / 2;
		int range = lc.internalQuadrants[i].maxAngle - lc.internalQuadrants[i].minAngle;
		lc.internalQuadrants[i].range = range;
		
		if (i == 0 || minRange > range) minRange = range;
		if (i == 0 || maxRange < range) maxRange = range;
	}
	
	// store in flash
	lc.calibrated = 1;
	lc.up = up;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));
}