#include <main.h>

const int maxPoles = 21;
const int calibPower = sin_range / 2;
int q1 = -1;
int q2 = -1;

ConfigData* config = (ConfigData*)flashPageAddress;

bool above(int a, int b) {
	if (a > b) return true;
	if (a == 0 && b == numExternalQuadrants - 1) return true;
	return false;
}
bool below(int a, int b) {
	return above(b, a);
}

int detectQuadrant(int sensor) {
	int q = sensor / quadrantDivExternal;
	bool ready = q1 != -1 && q2 != -1;
	bool good = false;
	
	if (q == numExternalQuadrants) return -1;
	
	if (q != q1)
	{
		if (q != q2)
		{
			if (q2 == -1 || (above(q, q1) && above(q1, q2)) || (below(q, q1) && below(q1, q2)))
			{
				q2 = q1;
				q1 = q;
				good = true;
			}
		}
	}
	
	if (good && ready) return q1;
	else return -1;
}

void prepareToReverse() {
	int nq2 = -1;
	
	if (above(q1, q2))
	{
		nq2 = (q1 + 1) % numExternalQuadrants;
	}
	else
	{
		nq2 = q1 - 1;
		if (nq2 < 0) nq2 += numExternalQuadrants;
	}
	
	q2 = nq2;
}

int average(int a, int b) {
	int diff = a - b;
			
	if (diff > SENSOR_MAX / 2) b += SENSOR_MAX;
	if (diff < -SENSOR_MAX / 2) b -= SENSOR_MAX;
	
	return (a + b) / 2;
}
void average(int data[maxPoles]) {
	int p;

	// make sure no negatives
		
	for (p = 0; p < maxPoles; p++)
		if (data[p] < 0) data[p] += SENSOR_MAX;
		
	// save first element because others are compared against it
		
	if (data[0] == 0 && data[1] != 0) data[0] = data[1];
		
	// fix overflows
		
	for (p = 1; p < maxPoles; p++)
	{
		if (data[p] != 0)
		{
			int interPoleDiff = data[0] - data[p];
			
			if (interPoleDiff > SENSOR_MAX / 2) data[p] += SENSOR_MAX;
			if (interPoleDiff < -SENSOR_MAX / 2) data[p] -= SENSOR_MAX;
		}
	}
	
	// average non-zeros

	int n = 1;
		
	for (int p = 1; p < maxPoles; p++)
	{
		if (data[p] > 0)
		{
			data[0] += data[p];
			n++;
		}
	}

	data[0] /= n;
	if (data[0] < 0) data[0] += SENSOR_MAX;
}

void calibrateExternal() {
	const int step = 5;
	int a = 0;
	int i = 0;
	int external = spiReadAngleExternal();
	
	bool up;
	int q = 0;
	int q1;
	int p = 0;
	int prevQ = -1;
	int firstQ = -1;
	int targetA;
	
	int qExtUp[numExternalQuadrants][maxPoles] = { 0 };
	int qExtDn[numExternalQuadrants][maxPoles] = { 0 };

	// gently set 0 angle

	for (int p = 0; p < calibPower / 10; p++)
	{
		delay(1);
		setPwm(0, p * 10);
	}

	delay(500);

	// find the edge of the quadrant

	while (a < sin_period)
	{		
		a += step;
		delay(1);
		setPwm(a, calibPower);				
	}
	a = 0;

	external = spiReadAngleExternal();
	while (detectQuadrant(external) == -1)
	{
		external = spiReadAngleExternal();
		a += step;
		//delay(1);
		setPwm(a, calibPower);		
	}
	
	// full turn up
	
	for (p = 0; ; p++)
	{
		for (i = 0; i < numExternalQuadrants;)
		{
			external = spiReadAngleExternal();
			q = detectQuadrant(external);
			if (q != -1)
			{
				if (p == maxPoles) goto reverse;
				qExtUp[q][p] = a % sin_period;
				i++;
			}
			
			a += step;
			//delay(1);
			setPwm(a, calibPower);				
		}
	}
	
reverse:	
	prepareToReverse();
	
	// full turn down

	for (p = 0; ; p++)
	{
		for (i = numExternalQuadrants - 1; i >= 0;)
		{
			external = spiReadAngleExternal();
			q = detectQuadrant(external);
			if (q != -1)
			{
				if (p == maxPoles) goto release;
				qExtDn[q][p] = a % sin_period;
				i--;
			}
			
			a -= step;
			//delay(1);
			setPwm(a, calibPower);
		}
	}	

release:
	// gently release

	for (int p = calibPower / 10; p > 0; p--)
	{
		delay(1);
		setPwm(a, p * 10);
	}

	setPwm(0, 0);
	
	ConfigData lc;
	lc.controllerId = config->controllerId;	
	
	// up or down?
	int nUp = 0;
	int nDn = 0;
	
	for (q = 0; q < numExternalQuadrants - 1; q++)
	{
		int d = qExtUp[q + 1][0] - qExtUp[q][0];
		if (d > 0 && d < SENSOR_MAX / 2) nUp++;
		else nDn++;
	}
	
	up = nUp > nDn;
	
	// correct overflows and average
	
	for (q = 0; q < numExternalQuadrants; q++) average(qExtUp[q]);
	for (q = 0; q < numExternalQuadrants; q++) average(qExtDn[q]);
	
	for (q = 0; q < numExternalQuadrants; q++)
	{
		int a1 = q;
		int a2 = (q - 1);
		if (a2 < 0) a2 = numExternalQuadrants - 1;
		
		int b1 = (q + 1) % numExternalQuadrants;
		int b2 = q;
		
		int qThis = average(qExtUp[a1][0], qExtDn[a2][0]);
		int qNext = average(qExtUp[b1][0], qExtDn[b2][0]);
		
		if (!up)
		{
			int tmp = qThis;
			qThis = qNext;
			qNext = tmp;
		}
		
		lc.externalQuadrants[q].minAngle = qThis;
		
		if (qNext < qThis)
			lc.externalQuadrants[q].maxAngle = qNext + SENSOR_MAX;
		else
			lc.externalQuadrants[q].maxAngle = qNext;
		
		lc.externalQuadrants[q].range = lc.externalQuadrants[q].maxAngle - lc.externalQuadrants[q].minAngle;
	}
	
	// store in flash
	lc.up = up;
	writeFlash((uint16_t*)&lc, sizeof(ConfigData) / sizeof(uint16_t));
}