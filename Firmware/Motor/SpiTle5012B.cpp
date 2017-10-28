#include <main.h>

#define READ_STATUS				0x8001			//8000
#define READ_ANGLE_VALUE		0x8021			//8020
#define READ_SPEED_VALUE		0x8031			//8030

#define WRITE_MOD1_VALUE		0x5060			//0_1010_0_000110_0001
#define MOD1_VALUE				0x0001

#define WRITE_MOD2_VALUE		0x5080			//0_1010_0_001000_0001
#define MOD2_VALUE				0x0801

#define WRITE_MOD3_VALUE		0x5091			//0_1010_0_001001_0001
#define MOD3_VALUE				0x0000

#define WRITE_MOD4_VALUE		0x50E0			//0_1010_0_001110_0001
#define MOD4_VALUE				0x0098			//9bit 512

#define WRITE_IFAB_VALUE		0x50B1
#define IFAB_VALUE				0x000D

//

int spiCurrentAngle;
unsigned int spiTickAngleRead;

void initSpi() {
	spiCurrentAngle = 0;
	spiTickAngleRead = 0;
	
	//
	
	GPIOA->MODER |= (0b01 << GPIO_MODER_MODER4_Pos) |	// output for pin A-4 (CS)
		            (0x02 << GPIO_MODER_MODER5_Pos) |	// alt func mode for pin A-5 (SCK)
		            (0x02 << GPIO_MODER_MODER7_Pos);	// alt func mode for pin A-7 (MOSI)
		
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR4 |			// high speed for pin A-4 (SC)
					  GPIO_OSPEEDR_OSPEEDR5 |			// high speed for pin A-5 (SCK)
				      GPIO_OSPEEDR_OSPEEDR7;			// high speed for pin A-7 (MOSI)
	
	GPIOA->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL5_Pos) |	// alternative funciton 0 for pin A-5
		             (0x00 << GPIO_AFRL_AFSEL7_Pos);	// alternative funciton 0 for pin A-7
	
	GPIOA->BSRR |= 1 << 4;								// CS high (disable)
	
	//
	
	SPI1->CR1 |= SPI_CR1_BIDIMODE |				// half-duplex mode
		         SPI_CR1_BIDIOE |				// output mode
				 SPI_CR1_SSM |					// software slave management
		         SPI_CR1_SSI |					// internal slave select
		         (0b011 << SPI_CR1_BR_Pos) |	// baud rate = PCLK/16
		         SPI_CR1_MSTR;					// master mode
		
	SPI1->CR2 |= SPI_CR2_FRXTH |				// RXNE event is generated if the FIFO level is greater than or equal to 1/4 (8-bit)
		         (0b1111 << SPI_CR2_DS_Pos);	// data size = 16 bit
//		
	SPI1->CR1 |= SPI_CR1_SPE;					// SPI enable

//	GPIO_InitTypeDef GPIO_InitStruct;
//	GPIO_InitStruct.Pin = GPIO_PIN_5 | GPIO_PIN_7;
//	GPIO_InitStruct.Mode = GPIO_MODE_AF_PP;
//	GPIO_InitStruct.Pull = GPIO_NOPULL;
//	GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_HIGH;
//	GPIO_InitStruct.Alternate = GPIO_AF0_SPI1;
//	HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);	
		
//	SPI_HandleTypeDef hspi1;	
//	hspi1.Instance = SPI1;
//	hspi1.Init.Mode = SPI_MODE_MASTER;
//	hspi1.Init.Direction = SPI_DIRECTION_1LINE;
//	hspi1.Init.DataSize = SPI_DATASIZE_8BIT;
//	hspi1.Init.CLKPolarity = SPI_POLARITY_LOW;
//	hspi1.Init.CLKPhase = SPI_PHASE_1EDGE;
//	hspi1.Init.NSS = SPI_NSS_SOFT;
//	hspi1.Init.BaudRatePrescaler = SPI_BAUDRATEPRESCALER_8;
//	hspi1.Init.FirstBit = SPI_FIRSTBIT_MSB;
//	hspi1.Init.TIMode = SPI_TIMODE_DISABLE;
//	hspi1.Init.CRCCalculation = SPI_CRCCALCULATION_DISABLE;
//	hspi1.Init.CRCPolynomial = 7;
//	hspi1.Init.CRCLength = SPI_CRC_LENGTH_DATASIZE;
//	hspi1.Init.NSSPMode = SPI_NSS_PULSE_ENABLE;
//	HAL_SPI_Init(&hspi1);
}
uint16_t SpiGetRegister(uint16_t wr) {
	uint16_t data = 0;
	
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	SPI1->CR1 |= SPI_CR1_BIDIOE;						// output mode
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = wr;					// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	//for (int i = 0; i < 10; i++) asm("nop");	
	
	SPI1->CR1 &= ~SPI_CR1_BIDIOE;						// input mode	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer
	SPI1->CR1 |= SPI_CR1_BIDIOE;						// output mode
	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	data = *((__IO uint16_t *)&SPI1->DR);
	return data;
}
int SpiReadAngle() {
	int reg = SpiGetRegister(READ_ANGLE_VALUE);
	reg &= ~0x8000;										// clear "new value" flag which we don't need
	if (reg & 0x4000) reg |= 0xFFFF8000;				// move 15-bit sign into 32nd bit
	//reg &= ~0x4000;
	return reg;
}