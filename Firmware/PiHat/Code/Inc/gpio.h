
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __gpio_H
#define __gpio_H
#ifdef __cplusplus
 extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "stm32f0xx_hal.h"
#include "main.h"

#define PIN_READY_TO_RECEIVE	GPIO_PIN_5
#define PIN_READY_TO_RESPOND	GPIO_PIN_6

void MX_GPIO_Init(void);


#ifdef __cplusplus
}
#endif
#endif /*__ pinoutConfig_H */
