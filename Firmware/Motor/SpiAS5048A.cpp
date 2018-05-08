#include <main.h>

#ifdef AS5048A

#define SPI_CMD_READ 0x4000 // flag indicating read attempt
#define SPI_CMD_WRITE 0x8000 // flag indicating write attempt
#define SPI_REG_AGC 0x3ffd // agc register when using SPI
#define SPI_REG_MAG 0x3ffe // magnitude register when using SPI
#define SPI_REG_DATA 0x3fff // data register when using SPI
#define SPI_REG_CLRERR 0x1 // clear error register when using SPI
#define SPI_REG_ZEROPOS_HI 0x0016 // zero position register high byte
#define SPI_REG_ ZEROPOS_LO 0x0017 // zero position register low byte

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
}

static uint8_t spiCalcEvenParity(uint16_t value)
{
	uint8_t cnt = 0;
	uint8_t i;
	for (i = 0; i < 16; i++)
	{
		if (value & 0x1) cnt++;
		value >>= 1;
	}
	return cnt & 0x1;
}

uint16_t spiGetRegister(uint16_t wr) {
	uint16_t data = 0;
	
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	
	//SPI1->CR1 |= SPI_CR1_BIDIOE;						// output mode
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = wr;					// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	//for (int i = 0; i < 10; i++) asm("nop");	
	
	//SPI1->CR1 &= ~SPI_CR1_BIDIOE;						// input mode	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer
	//SPI1->CR1 |= SPI_CR1_BIDIOE;						// output mode
	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	data = *((__IO uint16_t *)&SPI1->DR);
	return data;
}
int spiReadAngle() {
	uint16_t dat;
	
	dat = 0xFFFF;
	
//	dat = SPI_CMD_READ | SPI_REG_DATA;
//	dat |= spiCalcEvenParity(dat) << 15;
	
	int reg = spiGetRegister(dat);

//	if (reg & 0x4000)
//	{
//		// error flag set - need to reset it
//		dat = SPI_CMD_READ | SPI_REG_CLRERR;
//		dat |= spiCalcEvenParity(dat) << 15;
//		int error = spiGetRegister(dat);
//	}
	
	reg &= 0x1FFF;	// clear parity and error bits
	
	//reg &= (16384 - 31 - 1);
	//if (reg & 0x2000) reg |= 0xFFFFC000;
	return reg;
}

#endif
