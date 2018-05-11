#include <main.h>

#ifdef MA700

void initSpi() {
	GPIOA->MODER |= (0b01 << GPIO_MODER_MODER4_Pos) |	// output for pin A-4 (CS)
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
	
	GPIOA->BSRR |= 1 << 4;								// CS high (disable)
	
	//
	
	SPI1->CR1 |= //SPI_CR1_BIDIMODE |				// half-duplex mode
		         //SPI_CR1_BIDIOE |				// output mode
				 SPI_CR1_SSM |					// software slave management
		         SPI_CR1_SSI |					// internal slave select
		//
				 SPI_CR1_CPOL |					// CK to 1 when idle
		         SPI_CR1_CPHA |					// The second clock transition is the first data capture edge
		//
		         (0b011 << SPI_CR1_BR_Pos) |	// baud rate = PCLK/16
		         SPI_CR1_MSTR;					// master mode
		
	SPI1->CR2 |= //SPI_CR2_FRXTH |				// RXNE event is generated if the FIFO level is greater than or equal to 1/4 (8-bit)
		         (0b1111 << SPI_CR2_DS_Pos);	// data size = 16 bit
//		
	SPI1->CR1 |= SPI_CR1_SPE;					// SPI enable
	
	// send calibration value
	
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = 0b0010001110100000;	// correction value=165
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = 0b0010010100100000;	// correction axis=x
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 	
}

int spiReadAngle() {
	uint16_t data = 0;
	
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = 0xffff;				// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer

	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	data = *((__IO uint16_t *)&SPI1->DR);
	return data >> 4;									// only leave 12 bit because the rest is noice any way
}

#endif