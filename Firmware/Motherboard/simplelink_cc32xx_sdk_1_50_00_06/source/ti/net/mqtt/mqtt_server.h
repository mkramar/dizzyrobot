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


#ifndef __SL_MQTT_SRVR_H__
#define __SL_MQTT_SRVR_H__

#ifdef __cplusplus
extern "C" {
#endif


//*****************************************************************************
// includes
//*****************************************************************************
#include <string.h>
#include <stdbool.h>
#include <ti/drivers/net/wifi/simplelink.h>

//*****************************************************************************
// defines
//*****************************************************************************

#ifndef MQTT_QOS_0
#define MQTT_QOS_0  (0)
#endif
#ifndef MQTT_QOS_1
#define MQTT_QOS_1  (1)
#endif
#ifndef MQTT_QOS_2
#define MQTT_QOS_2  (2)
#endif
#ifndef MQTT_PUBLISH_RETAIN
#define MQTT_PUBLISH_RETAIN (8)
#endif

//*****************************************************************************
// typedefs
//*****************************************************************************
typedef enum
{
    MQTT_SERVER_USER_NAME,
    MQTT_SERVER_PASSWORD,
} MQTTServer_Option;

#ifndef METTAP_COMMON_H
#define METTAP_COMMON_H
typedef void (*NetAppCallBack_t)(int32_t event, void * metaData, uint32_t metaDateLen, void *data, uint32_t dataLen);

typedef void* NetAppHandle_t;
#endif

typedef struct _MQTTServer_SubscribeParams_t_
{
    char* topic;
    NetAppCallBack_t callback; /**< optional - if NULL use the default callback */
    uint8_t persistent;
} MQTTServer_SubscribeParams_t;

typedef struct _MQTTServer_UnSubscribeParams_t_
{
    char* topic;
    uint8_t persistent;
} MQTTServer_UnSubscribeParams_t;


typedef enum
{
    MQTT_SERVER_RECV_CB_EVENT,
    MQTT_SERVER_CONNECT_CB_EVENT,
    MQTT_SERVER_DISCONNECT_CB_EVENT
} MQTTServer_EventCB;

/* Structure that holds parameters on the server for */
/* Authentication of Clients by the Server           */
typedef struct _MQTTServer_LocalAuthenticationData_t_
{
    char *userName;
    char *password;
} MQTTServer_LocalAuthenticationData_t;

typedef struct _MQTTServer_ConnectMetaDataCB_t_
{
    char *clientId;
    int32_t clientIdLen;
    char *userName;
    int32_t usernameLen;
    char *password;
    int32_t passwordLen;
    void **usr;
} MQTTServer_ConnectMetaDataCB_t;

typedef struct _MQTTServer_RecvMetaDataCB_t_
{
    const char *topic;
    int32_t topLen;
    bool dup;
    uint8_t qos;
    bool retain;
} MQTTServer_RecvMetaDataCB_t;

typedef struct _MQTTServer_DisconnectMetaDataCB_t_
{
    char *user;
    bool dueToErr;
} MQTTServer_DisconnectMetaDataCB_t;

/** Secure Socket Parameters to open a secure connection */
typedef struct _MQTTServer_NetAppParams_t_
{
    uint16_t port;             /**< Port number of MQTT server          */
    uint8_t method;            /**< Method to tcp secured socket        */
    uint32_t cipher;           /**< Cipher to tcp secured socket        */
    uint32_t nFiles;           /**< Number of files for secure transfer */
    char * const *secureFiles; /**< SL needs 4 files                    */
} MQTTServer_NetAppParams_t;

typedef struct
{
    MQTTServer_NetAppParams_t *connParams; // pointer to connection param
} MQTTServer_Attrib_t;


//*****************************************************************************
// function prototypes
//*****************************************************************************

/** Stop the MQTT Server
 Disconnect and remove all MQTT Server connections and data
 User will need to re-initialize after disconnect
 */
int16_t MQTTServer_delete(NetAppHandle_t handle);

/** Initialize the SL MQTT Server Implementation.
 A caller must initialize the MQTT Server implementation prior to using its services.

 \param[in] attrib - parameters
 \param[in] defaultCallback - Async Event Handler
 \return Success (0) or Failure (-1)

 */
NetAppHandle_t MQTTServer_create(NetAppCallBack_t defaultCallback, MQTTServer_Attrib_t *attrib);

/** Start the MQTT Server
 Main Task loop function that will start the MQTT server
 Connect and wait for data received
 */

int16_t MQTTServer_run(NetAppHandle_t handle);


int16_t MQTTServer_subscribe(NetAppHandle_t handle,    MQTTServer_SubscribeParams_t *value, uint8_t numberOfTopics);

int16_t MQTTServer_unsubscribe(NetAppHandle_t handle, MQTTServer_UnSubscribeParams_t *value, uint8_t numberOfTopics);

int16_t MQTTServer_publish(NetAppHandle_t handle, char *topic, uint16_t topicLen, char *msg, uint16_t msgLen, uint32_t flags);

int16_t MQTTServer_set(NetAppHandle_t handle , uint16_t option , void *value , uint16_t valueLength);

#ifdef __cplusplus  
}
#endif  

#endif // __SL_MQTT_SRVR_H__

