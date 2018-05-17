
#ifndef __usart_H
#define __usart_H
#ifdef __cplusplus
 extern "C" {
#endif

	#include "stm32f0xx_hal.h"
	#include "main.h"

	//extern UART_HandleTypeDef huart1;
	 
	#define usartBufferSize		10
	#define usartReadTimeout	100										// this many ms before give up listening

	extern volatile char usartInBuffer[usartBufferSize];
	extern volatile char usartOutBuffer[usartBufferSize];
	 
	 extern volatile bool usartResponseReceived;

	extern void _Error_Handler(const char *, int);

	void MX_USART1_UART_Init(void);
	 
	 void ScheduleUsartDmaWrite(uint32_t length);
	 void ScheduleUsartDmaRead();
	 
	 void BlockingUsartWrite(uint32_t length);
	 bool BlockingUsartRead();
	 
	 void BlockingUsartDmaWrite(uint32_t length);
	 bool BlockingUsartDmaRead();

#ifdef __cplusplus
}
#endif
#endif /*__ usart_H */
