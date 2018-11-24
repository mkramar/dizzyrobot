#include <main.h>

int spiPrevSensor = 0;
int spiCorrection = 0;
int spiCurrentAngleInternal = 0;
int spiCurrentAngleExternal = 0;
long firValue = 0;

//#define DO_FILTERING

extern "C"
void SPI1_IRQHandler() {
	// should be empty
}

#define CMD_WRITE	(0b0010 << 12)
#define CMD_READ	(0b0001 << 12)
#define REG_BCT		(3 << 8)
#define REG_ZERO	(4 << 8)
#define REG_AXIS	(5 << 8)
#define AXIS_X		(1 << 4)
#define AXIS_Y		(1 << 5)

uint16_t SpiWriteReadInternal(uint16_t data){
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = data;				// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer

	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	return *((__IO uint16_t *)&SPI1->DR);	
}
uint16_t SpiWriteReadExternal(uint16_t data) {
	GPIOB->BRR |= 1 << 1;								// B-1 down - enable CS 
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = data;				// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer

	GPIOB->BSRR |= 1 << 1;								// B-1 up - disable CS 
	
	return *((__IO uint16_t *)&SPI1->DR);	
}

void initSpi() {
	GPIOA->MODER |= (0b01 << GPIO_MODER_MODER4_Pos) |	// output for pin A-4 (CS internal)
		            (0x02 << GPIO_MODER_MODER5_Pos) |	// alt func mode for pin A-5 (SCK)
					(0x02 << GPIO_MODER_MODER6_Pos) |	// alt func mode for pin A-6 (MISO)
		            (0x02 << GPIO_MODER_MODER7_Pos);	// alt func mode for pin A-7 (MOSI)
		
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR4 |			// high speed for pin A-4 (SC)
					  GPIO_OSPEEDR_OSPEEDR5 |			// high speed for pin A-5 (SCK)
					  GPIO_OSPEEDR_OSPEEDR6 |			// high speed for pin A-6 (MISO)
				      GPIO_OSPEEDR_OSPEEDR7;			// high speed for pin A-7 (MOSI)
	
	GPIOA->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL5_Pos) |	// alternative funciton 0 for pin A-5
					 (0x00 << GPIO_AFRL_AFSEL6_Pos) |	// alternative funciton 0 for pin A-6
		             (0x00 << GPIO_AFRL_AFSEL7_Pos);	// alternative funciton 0 for pin A-7
	
	GPIOB->MODER |= (0x01 << GPIO_MODER_MODER1_Pos);	// output for pin B-1 (CS external)		
	GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR1;			// high speed for pin B-1 (CS external)

	GPIOA->BSRR |= 1 << 4;								// CS high (disable internal)
	
	//
	
	SPI1->CR1 |= SPI_CR1_SSM |					// software slave management
		         SPI_CR1_SSI |					// internal slave select
		//
				 SPI_CR1_CPOL |					// CK to 1 when idle
		         SPI_CR1_CPHA |					// The second clock transition is the first data capture edge
		//
		         (0b011 << SPI_CR1_BR_Pos) |	// baud rate = PCLK/16
		         SPI_CR1_MSTR;					// master mode
		
	SPI1->CR2 |= (0b1111 << SPI_CR2_DS_Pos);	// data size = 16 bit
//		
	SPI1->CR1 |= SPI_CR1_SPE;					// SPI enable
	
	// send calibration value
	
	SpiWriteReadInternal(CMD_WRITE | REG_BCT | 160);	// correction value=160
	SpiWriteReadInternal(CMD_WRITE | REG_AXIS | AXIS_Y);// correction axis=Y
	
	int readBct = SpiWriteReadInternal(CMD_READ | REG_BCT) & 0xFF;
	int readAxis = SpiWriteReadInternal(CMD_READ | REG_AXIS) & 0xFF;
}

int spiReadAngleInternal() {
	uint16_t data = SpiWriteReadInternal(0xffff);
	return data >> 1;									// leave 15 bit as required by sin
}
int spiReadAngleExternal() {
	uint16_t data = SpiWriteReadExternal(0xffff);
	return data >> 1;									// leave 15 bit as required by sin
}
