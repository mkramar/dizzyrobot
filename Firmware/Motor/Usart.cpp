#include <main.h>

const uint sendBufferSize = 4;
unsigned char sendBuffer[sendBufferSize] = { 0 };

const uint recvBufferSize = 6;
unsigned char recvBuffer[recvBufferSize] = { 0 };
volatile unsigned int ringPosition = 0;

volatile bool usartDmaSendRequested;
volatile bool usartDmaSendBusy;
volatile int usartTorqueCommandValue;

const int COMMAND_TORQUE = 1;

extern "C"
void DMA1_Channel2_3_IRQHandler(){
	if (DMA1->ISR & DMA_ISR_TCIF2)				// transfer complete on channel 2
	{
		GPIOA->BRR |= 0b10;						// DriverEnable disable
		DMA1->IFCR |= DMA_IFCR_CTCIF2;			// clear "transfer complete" flag of channel 2
		DMA1_Channel2->CCR &= ~DMA_CCR_EN;		// disable channel 2
		usartDmaSendBusy = false;
	}
}

extern "C"
void USART1_IRQHandler(void) {
	// idle line
	
	if (USART1->ISR & USART_ISR_IDLE)
	{
		USART1->ICR |= USART_ICR_IDLECF;		// clear IDLE flag bit	
		
		uint bufferPosition = recvBufferSize - DMA1_Channel3->CNDTR;
		uint i = bufferPosition - 3;
		if (bufferPosition < 3) i += recvBufferSize;
		
		if (recvBuffer[i] == 1 /*config->controllerId*/)
		{
			// message addressed to this controller
			
			i++;
			i %= recvBufferSize;

			if (recvBuffer[i] == 1)
			{
				// command is "set torque"
				
				i++;
				i %= recvBufferSize;
				
				unsigned char torqueValue = recvBuffer[i];
				if (torqueValue > 60)
				{
					torqueValue = 60;
				}

				usartTorqueCommandValue = (int)torqueValue;
				usartDmaSendRequested = true;				
			}
		}
	}
}

void initUsart() {
	usartDmaSendRequested = false;
	usartTorqueCommandValue = 0;
	usartDmaSendBusy = false;
	
	// config A-1 pin as DE

	GPIOA->MODER |= (0x01 << GPIO_MODER_MODER1_Pos);
	GPIOA->OSPEEDR |= (0b11 << GPIO_OSPEEDR_OSPEEDR1_Pos);
	
	// config B-6 and B-7 as TX and RX
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER6_Pos) |		// alt function for pin B-6 (TX)
					(0x02 << GPIO_MODER_MODER7_Pos);		// alt function for pin B-7 (RX)
	
	GPIOB->OSPEEDR |= (0b11 << GPIO_OSPEEDR_OSPEEDR6_Pos) |	// high speed for pin B-6 (TX)
		              (0b11 << GPIO_OSPEEDR_OSPEEDR7_Pos);	// high speed for pin B-7 (RX)
	
	GPIOB->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL6_Pos) |		// alt function 00 for pin B-6 (TX)
		             (0x00 << GPIO_AFRL_AFSEL7_Pos);		// alt function 00 for pin B-7 (RX)

	// config USART
		
	int baud = 115200;
	
	USART1->BRR = (8000000U + baud / 2U) / baud;			// baud rate (should be 69)
	
	CLEAR_BIT(USART1->CR2, (USART_CR2_LINEN | USART_CR2_CLKEN));
	CLEAR_BIT(USART1->CR3, (USART_CR3_SCEN | USART_CR3_HDSEL | USART_CR3_IREN));
	
	USART1->CR3 |= USART_CR3_OVRDIS |						// disable overrun error interrupt
				   USART_CR3_DMAT |							// enable DMA transmit
		           USART_CR3_DMAR;							// enable DMA receive
	
	USART1->CR1 |= USART_CR1_TE |							// enable transmitter
		           USART_CR1_RE |							// enable receiver
				   USART_CR1_UE |							// enable usart
				   //USART_CR1_RXNEIE |						// interrupt on receive
				   USART_CR1_IDLEIE;						// enanle IDLE LINE detection interrupt
	
	//TODO: for some reason RS485 hardware control is not working, so setting pin A-1 manually
	//HAL_RS485Ex_Init(&huart1, UART_DE_POLARITY_HIGH, 0, 0)
	//USART1->CR3 |= USART_CR3_DEM;							// enable automatic DriverEnable mode
	//USART1->CR1 |= (2 << UART_CR1_DEAT_ADDRESS_LSB_POS) |	// 2/16th of a bit assertion time on DriverEnable output
	//				(2 << UART_CR1_DEDT_ADDRESS_LSB_POS);	// 2/16th of a bit de-assertion time on DriverEnable output	
	
	while ((USART1->ISR & USART_ISR_TEACK) == 0) {}			// wait for transmitter to enable
	while ((USART1->ISR & USART_ISR_REACK) == 0) {}			// wait for receiver to enable
	
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_SetPriority(USART1_IRQn, 0);
	
	// config DMA
	
	RCC->AHBENR |= RCC_AHBENR_DMA1EN;						// enable clock for DMA
	
	// transmit channel 2

	DMA1_Channel2->CPAR = (uint32_t)(&(USART1->TDR));		// USART TDR is destination
	DMA1_Channel2->CMAR = (uint32_t)(sendBuffer);			// source
	
	DMA1_Channel2->CCR |= DMA_CCR_MINC |					// increment memory
		                  DMA_CCR_DIR |						// memory to peripheral
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  DMA_CCR_TCIE |					// interrupt on full transfer
		                  //DMA_CCR_EN |						// enable DMA
						  (0b10 << DMA_CCR_PL_Pos);			// priority = high
	
	// receive channel 3
	
	DMA1_Channel3->CPAR = (uint32_t)(&(USART1->RDR));		// USART RDR is source
	DMA1_Channel3->CMAR = (uint32_t)(recvBuffer);			// destination
	DMA1_Channel3->CNDTR = recvBufferSize;					// buffer size	
	
	DMA1_Channel3->CCR |= DMA_CCR_MINC |					// increment memory
						  DMA_CCR_CIRC |					// circular mode
						  //								// peripheral to memory
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  //DMA_CCR_TCIE |					// interrupt on full transfer
					      DMA_CCR_EN |						// enable DMA
					      (0b10 << DMA_CCR_PL_Pos);			// priority = high
	
	//
	
	HAL_NVIC_SetPriority(DMA1_Channel2_3_IRQn, 0, 0);
	HAL_NVIC_EnableIRQ(DMA1_Channel2_3_IRQn);
}

void usartSendAngle() {
	sendBuffer[0] = 0;											// to main controller
	sendBuffer[1] = config->controllerId;						// id of the sender	
	sendBuffer[2] = (uint8_t)(spiCurrentAngle & (uint8_t)0x00FFU);
	sendBuffer[3] = (uint8_t)((spiCurrentAngle >> 8) & (uint8_t)0x00FFU);

	GPIOA->BSRR |= 0b10;										// DriverEnable enable
	DMA1_Channel2->CNDTR = sendBufferSize;						// buffer size	
	DMA1_Channel2->CCR |= DMA_CCR_EN;							// enable DMA channel 2
	usartDmaSendBusy = true;
}