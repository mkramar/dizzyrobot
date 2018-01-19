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

#ifndef __CLIENT_MGMT_H__
#define __CLIENT_MGMT_H__

//*****************************************************************************
// includes
//*****************************************************************************
#include <ti/net/mqtt/common/mqtt_common.h>

//*****************************************************************************
// function prototypes
//*****************************************************************************
uint32_t MQTTClientMgmt_bmapGet(void *usrCl);

void *MQTTClientMgmt_appHndlGet(void *usrCl);

void *MQTTClientMgmt_willHndlGet(void *usrCl);

bool MQTTClientMgmt_canSessionDelete(void *usrCl);

void MQTTClientMgmt_subCountAdd(void *usrCl);

void MQTTClientMgmt_subCountDel(void *usrCl);

bool MQTTClientMgmt_qos2PubRxUpdate(void *usrCl, uint16_t msgID);

void MQTTClientMgmt_pubDispatch(uint32_t clMap, MQTT_Packet_t *mqp);

int32_t MQTTClientMgmt_pubMsgSend(void *usrCl,
                    const MQTT_UTF8String_t *topic, const uint8_t *dataBuf,
                    uint32_t dataLen, MQTT_QOS qos, bool retain);

void MQTTClientMgmt_onNetClose(void *usrCl);

bool MQTTClientMgmt_notifyAck(void *usrCl, uint8_t msgType, uint16_t msgID);

/* uint16_t composition: MSB is CONNACK-Flags and LSB is CONNACK-RC. The place-holder
   '*usrCl' has valid value, only if CONNACK-RC in return value is 0.
*/
uint16_t MQTTClientMgmt_connectRx(void *ctxCl, bool cleanSession, char *clientID,
                  void *appCl, void *will, void **usrCl);

void MQTTClientMgmt_onConnackSend(void *usrCl, bool cleanSession);

int32_t MQTTClientMgmt_init(void);

#endif
