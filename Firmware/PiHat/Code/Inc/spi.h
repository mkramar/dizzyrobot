
#ifndef __spi_H
#define __spi_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"
#include "main.h"

extern SPI_HandleTypeDef hspi1;
extern void _Error_Handler(const char *, int);

void HandleSpiRx();
void MX_SPI1_Init();
void StartSpiDmaRead(uint8_t* dataRx, uint32_t bufferSize);

#ifdef __cplusplus
}
#endif
#endif /*__ spi_H */
