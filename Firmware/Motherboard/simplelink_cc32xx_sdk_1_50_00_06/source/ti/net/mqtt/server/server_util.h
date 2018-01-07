/*
 *   Copyright (C) 2016 Texas Instruments Incorporated
 *
 *   All rights reserved. Property of Texas Instruments Incorporated.
 *   Restricted rights to use, duplicate or disclose this code are
 *   granted through contract.
 *
 *   The program may not be used without the written permission of
 *   Texas Instruments Incorporated or against the terms and conditions
 *   stipulated in the agreement under which this program has been supplied,
 *   and under no circumstances can it be used with non-TI connectivity device.
 *   
 */

#ifndef __SERVER_UTIL_H__
#define __SERVER_UTIL_H__

//*****************************************************************************
// includes
//*****************************************************************************
#include <ti/net/mqtt/common/mqtt_common.h>

//*****************************************************************************
// defines
//*****************************************************************************
#define MQTT_SERVER_VERSTR "1.0.4"

#define MIN(a,b) ((a > b)? b : a)

#define MUTEX_LOCKIN()    MQTTServerUtil_mutexLock()
#define MUTEX_UNLOCK()    MQTTServerUtil_mutexUnlock()

#define USR_INFO(FMT, ...) if(MQTTServerUtil_dbgPrn) MQTTServerUtil_dbgPrn(FMT, ##__VA_ARGS__)

#define DBG_INFO(FMT, ...)                              \
        if(MQTTServerUtil_prnAux && MQTTServerUtil_dbgPrn)                \
                MQTTServerUtil_dbgPrn(FMT, ##__VA_ARGS__)

//*****************************************************************************
// function prototypes
//*****************************************************************************
extern int32_t (*MQTTServerUtil_dbgPrn)(const char *fmt, ...);
extern bool  MQTTServerUtil_prnAux; 

void MQTTServerUtil_mutexLock(void);
void MQTTServerUtil_mutexUnlock(void);

uint16_t MQTTServerUtil_setMsgID(void);

void MQTTServerUtil_resetMsgID(void);

MQTT_Packet_t *MQTTServerUtil_mqpAlloc(uint8_t msgType, uint32_t buf_sz);

MQTT_Packet_t *MQTTServerUtil_mqpCopy(const MQTT_Packet_t *mqp);

void MQTTServerUtil_setParams(int32_t  (*dbg_prn)(const char *fmt, ...),
                     void  *mutex,
                     void (*mutexLockin)(void*),
                     void (*mutexUnlock)(void*));

#endif
