#include <main.h>

int spiCurrentAngle = 0;
int spiUpdateSequence = 0;

extern "C"
void SPI1_IRQHandler() {
	// should be empty
}


