
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __i2c_H
#define __i2c_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"
#include "main.h"

extern I2C_HandleTypeDef hi2c1;

extern void _Error_Handler(char *, int);

void MX_I2C1_Init(void);


#ifdef __cplusplus
}
#endif
#endif /*__ i2c_H */
