#include <main.h>

int ensureConfigured() {
	while (config->calibPoles == -1)
	{
		if (button2Pressed)
		{
			calibrate();
			button2Pressed = false;
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
	button1Pressed = false;
	button2Pressed = false;

	while (true){
		//spiUpdateTorque();
		spiCurrentAngle = spiReadAngle();
		setPwmTorque();
		
		if (usartDmaSendRequested && !usartDmaSendBusy)
		{
			usartSendAngle();
			usartDmaSendRequested = false;
		}
		
		if (button1Pressed)
		{
			button1Pressed = false;
		}
		
		if (button2Pressed)
		{
			calibrate(); 
			button2Pressed = false;
			usartTorqueCommandValue = 0;
			usartDmaSendRequested = false;
		}
	}
}
