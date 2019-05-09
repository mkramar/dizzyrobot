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
int getLinearisedAngle() {
	int angle = spiCurrentAngleInternal;
	
	int a;
	int q = angle / quadrantDivInternal;
	int range = config->internalQuadrants[q].range;
	int qstart = q * quadrantDivInternal;
	
	if (config->up)
	{
		int min = config->internalQuadrants[q].minAngle;
		a = min + (angle - qstart) * range / quadrantDivInternal;
	}
	else
	{
		int max = config->internalQuadrants[q].maxAngle;
		a = max - (angle - qstart) * range / quadrantDivInternal;
		a = SENSOR_MAX - a;
		if (a < 0) a += SENSOR_MAX;
	}
	
	return a % SENSOR_MAX;
}

void calibrate() {
	calibrateExternal();
	calibrateInternal();
}
