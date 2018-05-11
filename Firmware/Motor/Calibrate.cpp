#include <main.h>

const int calibPower = 80;
const int quadrantDiv = SENSOR_MAX / numQuadrants;
//const int quadrantSize = SENSOR_MAX / quadrantDiv;
	
ConfigData* config = (ConfigData*)flashPageAddress;

extern const int maxPoles;

int currentPole = 0;

int getElectricDegrees() {
	int q = spiCurrentAngle / quadrantDiv;
	int qstart = q * quadrantDiv;
	int max = config->quadrants[q].maxAngle;
	int min = config->quadrants[q].minAngle;
	int a = min + (spiCurrentAngle - qstart) * (max - min) / quadrantDiv;
	return a;
}

void calibrate() {
	int a = 0;
	int i = 0;
	int sensor;
	int prevSensor;
	
	bool up;
	int q = 0;
	int prevQ = -1;
	int firstQ = -1;
	int quadrantsLeft = numQuadrants;
	
	QuadrantData qUp[numQuadrants] = { 0 };
	QuadrantData qDn[numQuadrants] = { 0 };
	
	for (i = 0; i < numQuadrants; i++)
	{
		qUp[i].minAngle = 0xFFFF;
		qDn[i].minAngle = 0xFFFF;
	}

	// gently set 0 angle
	
	for (int p = 0; p < calibPower * 10; p++)
	{
		delay(1);
		setPwm(0, p/10);
	}
	
	// find the edge of the quadrant, detect direction
	
	int sensorFirst = spiReadAngle();
	int q1 = -1;
	int q2 = -1;
	while (true)
	{
		sensor = spiReadAngle();
		prevSensor = sensor;
		q = sensor / quadrantDiv;
			
		if (q1 == -1) q1 = q;
		else if (q2 == -1 && q1 != q) q2 = q;
		else if (q1 != q && q2 != q) break;
		
		a++;
		delay(1);
		setPwm(a, calibPower);		
	}
	
	up = (sensor > sensorFirst);

	// full turn forward

	bool awayFromFirst = false;
	bool backToFirst = false;
	prevQ = -1;
	while (true)
	{
		sensor = spiReadAngle();
		q = sensor / quadrantDiv;
		if (firstQ == -1) firstQ = q;
		if (prevQ != -1)
		{
			// noice on the quadrant edges
			if (up)
			{
				if ((q != 0 || prevQ != numQuadrants - 1) && q < prevQ) q = prevQ;
				//else if (q == numQuadrants - 1 && prevQ == 0) q = prevQ;
			}
			else
			{
				if ((q != numQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
				//else if (q == 0 && prevQ == numQuadrants - 1) q = prevQ;
			}
		}
		if (q != prevQ)
		{
			prevQ = q;			
		}
		prevQ = q;		
		
		awayFromFirst |= (q - firstQ > 4) || (firstQ - q > 4);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qUp[q].minAngle > a) qUp[q].minAngle = a;
		if (qUp[q].maxAngle < a) qUp[q].maxAngle = a;
		
		a+=2;
		delay(1);
		setPwm(a, calibPower);
	}
	
	for (int i = 0; i < numQuadrants; i++)
		qUp[i].range = qUp[i].maxAngle - qUp[i].minAngle;
	
	//  up and down
	
	int aFrom = a;
	int aTo = a + sin_size;
	
	while (a < aTo)
	{
		a++;
		delay(1);
		setPwm(a, calibPower);		
	}

	while (a > aFrom)
	{
		a--;
		delay(1);
		setPwm(a, calibPower);		
	}
	
	// full turn back
	
	awayFromFirst = false;
	backToFirst = false;
	firstQ = -1;
	prevQ = -1;
	while (true)
	{
		sensor = spiReadAngle();
		q = sensor / quadrantDiv;
		if (firstQ == -1) firstQ = q;
		if (prevQ != -1)
		{
			// noice on the quadrant edges
			if (up)
			{
				if ((q != numQuadrants - 1 || prevQ != 0) && q > prevQ) q = prevQ;
				//else if (q == 0 && prevQ == numQuadrants - 1) q = prevQ;
			}
			else
			{
				if ((q != 0 || prevQ != numQuadrants - 1) && q < prevQ) q = prevQ;
				//else if (q == numQuadrants - 1 && prevQ == 0) q = prevQ;
			}
		}
		if (q != prevQ)
		{
			prevQ = q;
		}
		prevQ = q;
		
		awayFromFirst |= (q - firstQ > 4) || (firstQ - q > 4);
		backToFirst |= awayFromFirst && (q == firstQ);
		if (backToFirst) break;
		
		if (qDn[q].minAngle > a) qDn[q].minAngle = a;
		if (qDn[q].maxAngle < a) qDn[q].maxAngle = a;
		
		a -= 2;
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
	
	ConfigData lc;
	lc.controllerId = config->controllerId;	
	
//	if (!up)
//	{
//		int tmp;
//		
//		for (int i = 0; i < numQuadrants; i++)
//		{
//			tmp = qUp[i].minAngle;
//			qUp[i].minAngle = qUp[i].maxAngle;
//			qUp[i].maxAngle = tmp;
//			
//			tmp = qDn[i].minAngle;
//			qDn[i].minAngle = qDn[i].maxAngle;
//			qDn[i].maxAngle = tmp;			
//		}
//	}
	
	// calc average quadrants
	
	for (int i = 0; i < numQuadrants; i++)
	{
		lc.quadrants[i].minAngle = (qUp[i].minAngle + qDn[i].minAngle) / 2;
		lc.quadrants[i].maxAngle = (qUp[i].maxAngle + qDn[i].maxAngle) / 2;
	}
	
//	for (int i = 0; i < numQuadrants - 1; i++)
//	{
//		if (up)
//		{
//			int avg = (lc.quadrants[i].maxAngle + lc.quadrants[i + 1].minAngle) / 2;
//		
//			lc.quadrants[i].maxAngle = avg;
//			lc.quadrants[i + 1].minAngle = avg;
//		}
//		else
//		{
//			int avg = (lc.quadrants[i].minAngle + lc.quadrants[i + 1].maxAngle) / 2;
//		
//			lc.quadrants[i].minAngle = avg;
//			lc.quadrants[i + 1].maxAngle = avg; 
//		}
//	}	

	// store in flash
	lc.calibrated = true;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData)/sizeof(uint16_t));
}