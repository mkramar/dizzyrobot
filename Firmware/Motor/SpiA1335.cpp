#include <main.h>

#ifdef A1335

const uint32_t WRITE = 0x40;
const uint32_t READ = 0x00;
const uint32_t COMMAND_MASK = 0xC0;
const uint32_t ADDRESS_MASK = 0x3F;

uint16_t SpiWriteRead(uint16_t data) {
	GPIOA->BRR |= 1 << 4;								// A-4 down - enable CS 
	
	while ((SPI1->SR & SPI_SR_TXE) != SPI_SR_TXE) {}	// wait till transmit buffer empty
	*((__IO uint16_t *)&SPI1->DR) = data;				// write
	while ((SPI1->SR & SPI_SR_BSY) == SPI_SR_BSY) {}	// wait till end of transmission
	
	while ((SPI1->SR & SPI_SR_RXNE) != SPI_SR_RXNE) {}	// wait for input buffer

	GPIOA->BSRR |= 1 << 4;								// A-4 up - disable CS 
	
	return *((__IO uint16_t *)&SPI1->DR);	
}

void initSpi() {
	GPIOA->MODER |= (0b01 << GPIO_MODER_MODER4_Pos) |	// output for pin A-4 (CS)
		            (0x02 << GPIO_MODER_MODER5_Pos) |	// alt func mode for pin A-5 (SCK)
					(0x02 << GPIO_MODER_MODER6_Pos);	// alt func mode for pin A-6 (MISO)
		
	GPIOA->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR4 |			// high speed for pin A-4 (SC)
					  GPIO_OSPEEDR_OSPEEDR5 |			// high speed for pin A-5 (SCK)
					  GPIO_OSPEEDR_OSPEEDR6;			// high speed for pin A-6 (MISO)
	
	GPIOA->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL5_Pos) |	// alternative funciton 0 for pin A-5
					 (0x00 << GPIO_AFRL_AFSEL6_Pos);	// alternative funciton 0 for pin A-6
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER5_Pos);	// alt func mode for pin B-5 (MOSI)
		
	GPIOB->OSPEEDR |= GPIO_OSPEEDR_OSPEEDR5;			// high speed for pin B-5 (MOSI)
	
	GPIOB->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL5_Pos);	// alternative funciton 0 for pin B-5

	GPIOA->BSRR |= 1 << 4;								// CS high (disable)
	
	//
	
	SPI1->CR1 |= //SPI_CR1_BIDIMODE |			// half-duplex mode
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

uint16_t PrimaryRead(uint16_t address){
	// Combine the register address and the command into one byte
	uint16_t command = ((address & ADDRESS_MASK) | READ) << 8;

	// send the device the register you want to read
	SpiWriteRead(command);

	// send the command again to read the contents
	return SpiWriteRead(command);
}

void PrimaryWrite(uint16_t address, uint16_t value){
	uint16_t command = ((address & ADDRESS_MASK) | WRITE) << 8;
	SpiWriteRead(command | ((value >> 8) & 0x0FF)); // Send MSB
	
	command = (((address + 1) & ADDRESS_MASK) | WRITE) << 8;
	SpiWriteRead(command | (value & 0x0FF));		// Send LSB
}

uint32_t ExtendedRead(uint16_t address){
	uint16_t value;
	uint16_t readFlags;
	uint16_t valueMSW;
	uint16_t valueLSW;

	// Write the address to the Extended Read Address register
	PrimaryWrite(0x0A, address & 0xFFFF);

	// Initiate the extended read
	PrimaryWrite(0x0C, 0x8000);

	// Wait for the read to be complete
	do
	{
		readFlags = PrimaryRead(0x0C);
	} while ((readFlags & 0x0001) != 0x0001);
    
	// Read MSW
	valueMSW = PrimaryRead(0x0E);

	// Read LSW
	valueLSW = PrimaryRead(0x10);

	value = ((uint32_t)valueMSW << 16) + valueLSW;
	return value;
}

void ExtendedWrite(uint16_t address, uint32_t value){
	uint16_t writeFlags;

	// Write into the extended address register
	PrimaryWrite(0x02, address & 0xFFFF);
    
	// Write the MSW (Most significant word) into the high order write data register
	PrimaryWrite(0x04, (value >> 16) & 0xFFFF);

	// Write the LSW (Least significant word) into the low order write data register
	PrimaryWrite(0x06, value & 0xFFFF);

	// Start the write process
	PrimaryWrite(0x08, 0x8000);

	// Wait for the write to complete
	do
	{
		writeFlags = PrimaryRead(0x08);
	} while ((writeFlags & 0x0001) != 0x0001);
}

bool SetProcessorStateToIdle(){
	uint16_t value;
 
    // Write the enter idle state command into the control register
	PrimaryWrite(0x1F, 0x8046);
    
	delay(1);

	// Read the status register to see if the processor is in the idle state
	value = PrimaryRead(0x22);
        
	return ((value & 0x00FF) == 0x0010);
}

bool SetProcessorStateToRun(){
	uint16_t value;
 
    // Write the enter idle state command into the control register
	PrimaryWrite( 0x1F, 0xC046);
    
	delay(1);

	// Read the status register to see if the processor is in the idle state
	value = PrimaryRead(0x22);
	
    return (value & 0x00FF) == 0x0011;
}

void A1335DisableLinearization() {
	uint32_t flags = ExtendedRead(0x60);
	flags &= ~(1 << 20);		// disable Segmented Linearization
	ExtendedWrite(0x06, flags);
} 
		
void A1335InitFromFlash() {
	uint32_t odd, eve, flags, test;
	uint16_t address = 0x0C;
	
	ExtendedWrite(0xFFFE, 0x27811F77);
	
	for (int i = 1; i < numLinCoeff; i += 2)
	{
		odd = (uint32_t)(config->coefficients[i] - config->coefficients[0]) << 4;
		eve = (uint32_t)(config->coefficients[i + 1] - config->coefficients[0]) << 4;
		flags = odd | (eve << 16);
		ExtendedWrite(address, flags);
		
		test = ExtendedRead(address);
		
		address++;
	}
	
	//	
	
	odd = (uint32_t)(config->coefficients[15] - config->coefficients[0]) << 4;
	eve = (uint32_t)(config->coefficients[0]) << 4;
	flags = odd | (eve << 16);
	ExtendedWrite(0x13, flags);	
	
	//
	
	flags = (1 << 20);						// enable Segmented Linearization
	flags &= ~(1 << 25);					// disable linearization bypass
	//flags |= (config->coefficients[0]);		// zero offset (optional)
	ExtendedWrite(0x06, flags);
	
	test = ExtendedRead(0x06);
}

int spiReadAngle() {
	uint16_t data = SpiWriteRead(0x2000);
	//uint16_t data = PrimaryRead(0x20);
	data = (data & 0x0FFF);
	return data;
}

#endif