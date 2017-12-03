#include <main.h>

const uint sendBufferSize = 6;
unsigned char sendBuffer[sendBufferSize] = { 0 };

const uint recvBufferSize = 6;
unsigned char recvBuffer[recvBufferSize] = { 0 };
volatile unsigned int ringPosition = 0;

volatile bool usartPendingTorqueCommand;
volatile int usartTorqueCommandValue;

const int COMMAND_TORQUE = 1;

extern "C"
void DMA1_Channel2_3_IRQHandler()
{
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
				usartPendingTorqueCommand = true;				
			}
		}
	}
	
	// char received
	
//	while (USART1->ISR & USART_ISR_RXNE)
//	{
//		unsigned char newByte = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);
//		
//		recvBuffer[ringPosition % recvBufferSize] = newByte;
//		
//		if (recvBuffer[(ringPosition + recvBufferSize - 5) % recvBufferSize] == 0xFF &&			// FF 4 bytes back
//			recvBuffer[(ringPosition + recvBufferSize - 4) % recvBufferSize] == 0xFF/* &&			// FF 3 bytes back
//			recvBuffer[(ringPosition + recvBufferSize - 3) % recvBufferSize] == config->controllerId*/)	// ID 2 bytes back
//		{
//			if (recvBuffer[(ringPosition + recvBufferSize - 2) % recvBufferSize] == 0 &&		// comes from main controller
//				recvBuffer[(ringPosition + recvBufferSize - 1) % recvBufferSize] == COMMAND_TORQUE)
//			{
//				if (newByte > 30)
//				{
//					newByte = 30;
//				}
//				//if (!usartPendingTorqueCommand)
//				//{
//				usartTorqueCommandValue = (int)newByte;
//				usartPendingTorqueCommand = true;
////}
//			}
//		}
//		
//		ringPosition++;
//	}
}

void initUsart() {
	usartPendingTorqueCommand = false;
	usartTorqueCommandValue = 0;
	
	sendBuffer[0] = 0xFF;
	sendBuffer[1] = 0xFF;
	sendBuffer[2] = 0;						// to main controller
	sendBuffer[3] = config->controllerId;	// id of the sender
	
	// config A-1 pin as DE

	GPIOA->MODER |= (0x01 << GPIO_MODER_MODER1_Pos);
	GPIOA->OSPEEDR |= (0b11 << GPIO_OSPEEDR_OSPEEDR1_Pos);
	
	//TODO:
	//HAL_RS485Ex_Init(&huart1, UART_DE_POLARITY_HIGH, 0, 0)
	
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
	
	//USART1->ICR |= USART_ICR_IDLECF;						// clear IDLE flag bit so we don't receive interrupt on startup
	
	while ((USART1->ISR & USART_ISR_TEACK) == 0) {}			// wait for transmitter to enable
	while ((USART1->ISR & USART_ISR_REACK) == 0) {}			// wait for receiver to enable
	
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_SetPriority(USART1_IRQn, 0);
	
	// config DMA
	
	RCC->AHBENR |= RCC_AHBENR_DMA1EN;						// enable clock for DMA
	
	// transmit channel 2

	DMA1_Channel2->CPAR = (uint32_t)(&(USART1->TDR));		// USART TDR is destination
	DMA1_Channel2->CMAR = (uint32_t)(sendBuffer);			// source
	DMA1_Channel2->CNDTR = sendBufferSize;					// buffer size
	
	DMA1_Channel2->CCR |= DMA_CCR_MINC |					// increment memory
		                  DMA_CCR_DIR |						// memory to peripheral
		                  //DMA_CCR_TEIE |					// interrupt on error
		                  //DMA_CCR_HTIE |					// interrupt on half-transfer
		                  //DMA_CCR_TCIE |					// interrupt on full transfer
		                  DMA_CCR_EN |						// enable DMA
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

void usartSend(uint8_t *pData, uint16_t size) {
	GPIOA->BSRR |= 0b10;										// DE enable
		
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_TXE) == 0) {}			// wait for transmit data register empty
		USART1->TDR = (*pData++ & (uint8_t)0xFFU);
	}
	while ((USART1->ISR & USART_ISR_TC) == 0) {}				// wait for transmit complete
	
	GPIOA->BRR |= 0b10;											// DE disable
}
void usartReceive(uint8_t *pData, uint16_t size) {
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_RXNE) == 0) {}			// wait for receive data register
		*pData++ = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);	// read byte
	}
}

void usartSendAngle() {
	sendBuffer[4] = (uint8_t)(spiCurrentAngle & (uint8_t)0x00FFU);
	sendBuffer[5] = (uint8_t)((spiCurrentAngle >> 8) & (uint8_t)0x00FFU);
	usartSend(sendBuffer, 5);	
}