#include <main.h>

const int sendBufferSize = 6;
unsigned char sendBuffer[sendBufferSize] = { 0 };

const int recvBufferSize = 6;
unsigned char recvBuffer[recvBufferSize] = { 0 };
volatile unsigned int ringPosition = 0;

volatile bool usartPendingTorqueCommand;
volatile int usartTorqueCommandValue;

const int COMMAND_TORQUE = 1;

extern "C"
void USART1_IRQHandler(void) {
	while (USART1->ISR & USART_ISR_RXNE)
	{
		unsigned char newByte = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);
		
		recvBuffer[ringPosition % recvBufferSize] = newByte;
		
		if (recvBuffer[(ringPosition + recvBufferSize - 5) % recvBufferSize] == 0xFF &&			// FF 4 bytes back
			recvBuffer[(ringPosition + recvBufferSize - 4) % recvBufferSize] == 0xFF &&			// FF 3 bytes back
			recvBuffer[(ringPosition + recvBufferSize - 3) % recvBufferSize] == config->controllerId)	// ID 2 bytes back
		{
			if (recvBuffer[(ringPosition + recvBufferSize - 2) % recvBufferSize] == 0 &&		// comes from main controller
				recvBuffer[(ringPosition + recvBufferSize - 1) % recvBufferSize] == COMMAND_TORQUE)
			{
				if (!usartPendingTorqueCommand)
				{
					usartTorqueCommandValue = (int)newByte;
					usartPendingTorqueCommand = true;
				}
			}
		}
		
		ringPosition++;
	}
}

void initUsart() {
	usartPendingTorqueCommand = false;
	usartTorqueCommandValue = 0;
	
	sendBuffer[0] = 0xFF;
	sendBuffer[1] = 0xFF;
	sendBuffer[2] = 0;						// to main controller
	sendBuffer[3] = config->controllerId;	// id of the sender

	//
	
	int baud = 115200;
	
	GPIOB->MODER |= (0x02 << GPIO_MODER_MODER6_Pos) |		// alt function for pin B-6 (TX)
					(0x02 << GPIO_MODER_MODER7_Pos);		// alt function for pin B-7 (RX)
	
	GPIOB->OSPEEDR |= (0b11 << GPIO_OSPEEDR_OSPEEDR6_Pos) |	// high speed for pin B-6 (TX)
		              (0b11 << GPIO_OSPEEDR_OSPEEDR7_Pos);	// high speed for pin B-7 (RX)
	
	GPIOB->AFR[0] |= (0x00 << GPIO_AFRL_AFSEL6_Pos) |		// alt function 00 for pin B-6 (TX)
		             (0x00 << GPIO_AFRL_AFSEL7_Pos);		// alt function 00 for pin B-7 (RX)

	USART1->BRR = (8000000U + baud / 2U) / baud;			// baud rate (should be 69)
	
	CLEAR_BIT(USART1->CR2, (USART_CR2_LINEN | USART_CR2_CLKEN));
	CLEAR_BIT(USART1->CR3, (USART_CR3_SCEN | USART_CR3_HDSEL | USART_CR3_IREN));
	
	USART1->CR3 |= USART_CR3_OVRDIS;						// disable overrun error interrupt
	
	USART1->CR1 |= USART_CR1_TE |							// enable transmitter
		           USART_CR1_RE |							// enable receiver
				   USART_CR1_UE |							// enable usart
				   USART_CR1_RXNEIE;						// interrupt on receive
	
	while ((USART1->ISR & USART_ISR_TEACK) == 0) {}			// wait for transmitter to enable
	while ((USART1->ISR & USART_ISR_REACK) == 0) {}			// wait for receiver to enable
	
	NVIC_EnableIRQ(USART1_IRQn);
	NVIC_SetPriority(USART1_IRQn, 0);
}

void usartSend(uint8_t *pData, uint16_t size) {
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_TXE) == 0) {}			// wait for transmit data register empty
		USART1->TDR = (*pData++ & (uint8_t)0xFFU);
	}
	while ((USART1->ISR & USART_ISR_TC) == 0) {}				// wait for transmit complete
}
void usartReceive(uint8_t *pData, uint16_t size) {
	while (size > 0)
	{
		size--;
		while ((USART1->ISR & USART_ISR_RXNE) == 0) {}			// wait for receive data register
		*pData++ = (uint8_t)(USART1->RDR & (uint8_t)0x00FFU);	// read byte
	}
}

void usartSendAngle(){
	sendBuffer[4] = (uint8_t)(spiCurrentAngle & (uint8_t)0x00FFU);
	sendBuffer[5] = (uint8_t)((spiCurrentAngle >> 8) & (uint8_t)0x00FFU);
	usartSend(sendBuffer, 5);	
}