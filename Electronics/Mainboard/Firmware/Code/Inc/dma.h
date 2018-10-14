
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __dma_H
#define __dma_H

#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"
#include "main.h"

/* DMA memory to memory transfer handles -------------------------------------*/
extern void _Error_Handler(const char*, int);

void MX_DMA_Init(void);

#ifdef __cplusplus
}
#endif

#endif /* __dma_H */
