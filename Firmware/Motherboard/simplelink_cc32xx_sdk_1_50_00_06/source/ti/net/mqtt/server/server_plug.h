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

#ifndef __SERVER_PLUG_H__
#define __SERVER_PLUG_H__

//*****************************************************************************
// includes
//*****************************************************************************
#include "server_pkts.h"


//*****************************************************************************
// defines
//*****************************************************************************
/* Used by Server Core Logic */
#define PG_MAP_BITS_SIZE     2
#define PG_MAP_BITS_MASK     ((1 << PG_MAP_BITS_SIZE) - 1)
#define PG_MAP_MAX_ELEMS     4  /* should be able accomodate in 1 byte */
#define PG_MAP_ALL_DFLTS     ((1 << (PG_MAP_BITS_SIZE * PG_MAP_MAX_ELEMS)) - 1)

#define PG_MAP_HAS_VALUE(pg_map, index)                 \
        (((~pg_map) >> (index * PG_MAP_BITS_SIZE)) & PG_MAP_BITS_MASK)

#define PG_MAP_VAL_SETUP(pg_map, qid, index)                            \
        {                                                               \
                uint32_t ofst = index * PG_MAP_BITS_SIZE;                    \
                pg_map  &= ~(PG_MAP_BITS_MASK << ofst);                 \
                pg_map  |= qid << ofst;                                 \
        }

#define PG_MAP_VAL_RESET(pg_map, index)                                 \
        pg_map |= PG_MAP_BITS_MASK << (index * PG_MAP_BITS_SIZE);

#if (PG_MAP_BITS_MASK != QID_VMASK)
#error "PG_MAP_BITS_MASK must be same as 2bit QOS_VMASK"
#endif

#if ((PG_MAP_MAX_ELEMS * PG_MAP_BITS_SIZE) > 8)
#error "Make size-of pg_map greate than 1 byte"
#endif

//*****************************************************************************
// typedefs
//*****************************************************************************
typedef struct _MQTTServerPlug_CBs_t_
{
        int32_t (*topicEnroll)(uint8_t pgID, const MQTT_UTF8String_t *topic,
                            MQTT_QOS qos);
        int32_t (*topicCancel)(uint8_t pgID, const MQTT_UTF8String_t *topic);
        int32_t (*publish)(const MQTT_UTF8String_t *topic,    const uint8_t *dataBuf,
                       uint32_t dataLen, MQTT_QOS qos, bool retain);
}MQTTServerPlug_CBs_t;

//*****************************************************************************
// function prototypes
//*****************************************************************************
int32_t MQTTServerPlug_init(const MQTTServerPlug_CBs_t *cbs);

/* uint16_t composition: MSB is CONNACK-Flags = 0, LSB is CONNACK-RC */
uint16_t MQTTServerPlug_connect(const MQTT_UTF8String_t *clientId,
                   const MQTT_UTF8String_t *username,
                   const MQTT_UTF8String_t *password,
                   void **appUsr);

int32_t MQTTServerPlug_publish(uint8_t pg_map, const MQTT_UTF8String_t *topic,
                   const uint8_t *payload, uint32_t payLen,
                   bool dup, uint8_t qos, bool retain);

int32_t MQTTServerPlug_disconn(const void *appUsr, bool due2err);

#endif

