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

//*****************************************************************************
// includes
//*****************************************************************************
#include "server_util.h"

//*****************************************************************************
// defines
//*****************************************************************************
/*----------------------------------------------------------------------------
 * Try to prevent fragmentation by consistently allocating a fixed memory size
 *----------------------------------------------------------------------------
 */
#ifndef CFG_SR_MAX_MQP_TX_LEN
#define MQP_SERVER_TX_LEN        1024
#else
#define MQP_SERVER_TX_LEN        CFG_SR_MAX_MQP_TX_LEN
#endif

//*****************************************************************************
//globals
//*****************************************************************************
static uint16_t MQTTServerUtil_msgID = 0xFFFF;

int32_t (*MQTTServerUtil_dbgPrn)(const char *fmt, ...) = NULL;
bool MQTTServerUtil_prnAux = false;

static void (*MQTTServerUtil_registerMutexLock)(void*) = NULL;
static void (*MQTTServerUtil_registerMutexUnlock)(void*) = NULL;
static void *MQTTServerUtil_mutex = NULL;

//*****************************************************************************
// Internal Routines
//*****************************************************************************

//*****************************************************************************
//
//! \brief Increment the message ID
//
//*****************************************************************************
static inline uint16_t assign_new_msg_id()
{
    return MQTTServerUtil_msgID += 2;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static void my_pkt_free(MQTT_Packet_t *mqp)
{
    free((void*) mqp);
}

//*****************************************************************************
//
//! \brief The server_mqp_alloc function allocates memory for the message for
//! each message received by the server.
//
//*****************************************************************************
static MQTT_Packet_t *server_mqp_alloc(uint8_t msgType, uint32_t buf_sz, uint8_t offset)
{
    uint32_t mqp_sz = sizeof(MQTT_Packet_t);
    MQTT_Packet_t *mqp = NULL;

    buf_sz += offset;

    if ((mqp_sz + buf_sz) > MQP_SERVER_TX_LEN)
    {
        USR_INFO("S: fatal, buf allocate len > MQP_SERVER_TX_LEN\n\r");
        return NULL;
    }

    /* The size of the message is the size of the MQTT packet + payload (data) */
    mqp = malloc(mqp_sz + buf_sz);
    if (NULL != mqp)
    {
        MQTT_packetInit(mqp, offset);

        mqp->msgType = msgType;
        mqp->maxlen = buf_sz;
        mqp->buffer = (uint8_t*) mqp + mqp_sz;

        mqp->free = my_pkt_free;

    }
    else
    {
        USR_INFO("S: fatal, failed to allocate Server MQP\n\r");
    }

    return mqp;
}

//*****************************************************************************
// External Routines
//*****************************************************************************

//*****************************************************************************
//
//! \brief Reset the Message ID counter
//
//*****************************************************************************
void MQTTServerUtil_resetMsgID(void)
{
    MQTTServerUtil_msgID = 0xFFFF;
}

//*****************************************************************************
//
//! \brief Set new message ID
//
//*****************************************************************************
uint16_t MQTTServerUtil_setMsgID(void)
{
    return assign_new_msg_id();
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
MQTT_Packet_t *MQTTServerUtil_mqpAlloc(uint8_t msgType, uint32_t buf_sz)
{
    return server_mqp_alloc(msgType, buf_sz, MQTT_MAX_FH_LEN);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
MQTT_Packet_t *MQTTServerUtil_mqpCopy(const MQTT_Packet_t *mqp)
{
    MQTT_Packet_t *cpy = server_mqp_alloc(mqp->msgType, mqp->maxlen, 0);
    uint8_t *buffer;
    
    if (NULL != cpy)
    {
        buffer = cpy->buffer;

        /* Copy to overwrite everything in 'cpy' from source 'mqp' */
        MQTT_bufWrNbytes((uint8_t*) cpy, (uint8_t*) mqp, sizeof(MQTT_Packet_t));

        cpy->buffer = buffer; /* Restore buffer and copy */
        MQTT_bufWrNbytes(cpy->buffer, mqp->buffer, mqp->maxlen);
    }

    return cpy;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void MQTTServerUtil_mutexLock(void)
{
    if (MQTTServerUtil_registerMutexLock)
    {
        MQTTServerUtil_registerMutexLock(MQTTServerUtil_mutex);
    }
    return;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void MQTTServerUtil_mutexUnlock(void)
{
    if (MQTTServerUtil_registerMutexUnlock)
    {
        MQTTServerUtil_registerMutexUnlock(MQTTServerUtil_mutex);
    }
    return;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void MQTTServerUtil_setParams(int32_t (*dbg_prn)(const char *fmt, ...), void *mutex, void (*mutexLockin)(void*), void (*mutexUnlock)(void*))
{
    MQTTServerUtil_dbgPrn = dbg_prn;
    MQTTServerUtil_mutex = mutex;
    MQTTServerUtil_registerMutexLock = mutexLockin;
    MQTTServerUtil_registerMutexUnlock = mutexUnlock;

    return;
}
