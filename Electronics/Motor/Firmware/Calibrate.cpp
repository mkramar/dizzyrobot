#include <main.h>

int getElectricDegrees() {
	//int angle = spiCurrentAngleExternal % SENSOR_MAX;
	//if (angle < 0) angle += SENSOR_MAX;
	
	int angle = spiCurrentAngleExternal;
	
	int a;
	int q = angle / quadrantDivExternal;
	int range = config->externalQuadrants[q].range;
	int qstart = q * quadrantDivExternal;
	
	if (config->up)
	{
		int min = config->externalQuadrants[q].minAngle;
		a = min + (angle - qstart) * range / quadrantDivExternal;
	}
	else
	{
		int max = config->externalQuadrants[q].maxAngle;
		a = max - (angle - qstart) * range / quadrantDivExternal;
	}
	
	return a;
}

void calibrate() {
	//calibrateExternal();
	calibrateInternal();
}
