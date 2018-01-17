#include <main.h>

int ensureConfigured() {
	bool calibConfigured = config->calibPoles > 0;
	bool idConfigured = config->controllerId != 0 && config->controllerId != -1;
	
	if (!calibConfigured) blinkCalib(true);
	if (!idConfigured) blinkId(true);
	
	while (!calibConfigured || !idConfigured)
	{
		if (buttonCalibPressed)
		{
			calibrate();
			blinkCalib(false);
			
			calibConfigured = true;
			buttonCalibPressed = false;
		}
		
		if (buttonIdPressed)
		{
			incrementIdAndSave();
			blinkId(false);
			
			idConfigured = true;
			buttonIdPressed = false;
		}		
	}
}

//

int main(void) {
	initClockExternal();
	initButtons();
	initPwm();
	initUsart();
	initSpi();
	initSysTick();
	
	//calibrate();
	//delay(2000);
	
	ensureConfigured();
	
	//usartTorqueCommandValue = 30;	
	
	usartDmaSendRequested = false;
	buttonIdPressed = false;
	buttonCalibPressed = false;

	while (true){
		//spiUpdateTorque();
		spiCurrentAngle = spiReadAngle();
		setPwmTorque();
		
		if (usartDmaSendRequested && !usartDmaSendBusy)
		{
			usartSendAngle();
			usartDmaSendRequested = false;
		}
		
		if (buttonIdPressed)
		{
			incrementIdAndSave();
			buttonIdPressed = false;
		}
		
		if (buttonCalibPressed)
		{
			calibrate(); 
			buttonCalibPressed = false;
			usartTorqueCommandValue = 0;
			usartDmaSendRequested = false;
		}
	}
}
