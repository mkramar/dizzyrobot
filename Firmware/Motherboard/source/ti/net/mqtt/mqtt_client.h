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

/**
 \mainpage SimpleLink MQTT Client Layer

 * \section intro_sec Introduction

 The SimpleLink MQTT Client Layer provides an easy-to-use API(s) to enable
 constrained and deeply embedded micro-controller based products to interact
 with cloud or network based server for telemetry. The users of SL MQTT
 Client services, while benefiting from the abstraction of the MQTT protocol
 would find them suitable for varied deployments of MQTT subscribers and / or
 publishers.

 The following figure outlines the composition of the SL MQTT Client Layer.

 * \image html ./sl_mqtt_client_view.png

 * \section descrypt_sec Description

 The SL MQTT Client Layer, in addition to providing services to the application,
 encompasses a RTOS task to handle the incoming messages from the server. Such
 a dedicated context to process the messages from the server facilitates the
 apps to receive data (i.e. PUBLISH messages) even when they are blocked, whilst
 awaiting ACK for a previous transaction with the server. The receive task in
 the SL MQTT Layer can not be disabled anytime, however its system wide priority
 is configurable and can be set.

 Some of the salient features of the SL MQTT Layer are

 - Easy-to-use, intuitive and small set of MQTT API
 - App can indicate its choice to await ACK for a message transaction
 - Supports MQTT 3.1 protocol

 * \section config_sec Configuration
 The SL implementation enables the application developers to configure the
 following parameters using the compile line flags (-D option)
 * - <b> CFG_SL_CL_MAX_MQP: </b> the count of TX + RX resources in the buffer pool
 for the library to use. \n\n
 * - <b> CFG_SL_CL_BUF_LEN: </b> the length of the TX and RX buffers in the pool. \n\n
 * - <b> CFG_SL_CL_STACK: </b> Max stack (bytes) for RX Task executed by SL-MQTT. \n\n
 * - <b> CFG_CL_MQTT_CTXS: </b> the max number of simultaneous network connections
 to one or more servers. \n\n

 * \section seq_sec Sequence Diagram
 The following sequence diagram outlines one of the possible use cases
 (Blocking APIs with QOS1) using the SL MQTT Client Layer
 * \image html ./sl_mqtt_client_seq.jpg

 * \note An app that has chosen not to await an ACK from the server for an
 scheduled transaction can benefit from the availability of control to
 pursue other activities to make overall progress in the system. However,
 an attempt to schedule another transaction with the server, while the
 previous one is still active, will depend on the availability of buffers for transaction.


 \subsection seq_subsec Typical Sequences:

 - Publishers:  INIT --> CONTEXT_CREATE --> CONNECT --> PUBLISH (TX) --> DISCONNECT --> CONTEXT_DELETE --> EXIT
 - Subscribers: INIT --> CONTEXT_CREATE --> CONNECT --> SUBSCRIBE --> PUBLISH (RX) --> UNSUBSCRIBE --> DISCONNECT --> CONTEXT_DELETE --> EXIT

 */

#ifndef __SL_MQTT_H__
#define __SL_MQTT_H__

#ifdef __cplusplus
extern "C" {
#endif


//*****************************************************************************
// includes
//*****************************************************************************
#include <string.h>
#include <stdbool.h>
#include <ti/drivers/net/wifi/simplelink.h>
#include <ti/net/mqtt/common/mqtt_common.h>


//*****************************************************************************
// defines
//*****************************************************************************

/** @defgroup sl_mqtt_cl_api SL MQTT Client API
 @{
 */

/** @defgroup sl_mqtt_cl_evt SL MQTT Client Events
 @{
 */
#define MQTTCLIENT_ERR_NETWORK     MQTT_PACKET_ERR_NETWORK  /**< Problem in network (sock err) */
#define MQTTCLIENT_ERR_TIMEOUT     MQTT_PACKET_ERR_TIMEOUT  /**< Net transaction has timed out */
#define MQTTCLIENT_ERR_NET_OPS     MQTT_PACKET_ERR_NET_OPS  /**< Platform Net Ops un-available */
#define MQTTCLIENT_ERR_FNPARAM     MQTT_PACKET_ERR_FNPARAM  /**< Invalid parameter(s) provided */
#define MQTTCLIENT_ERR_PKT_AVL     MQTT_PACKET_ERR_PKT_AVL  /**< No pkts are available in pool */
#define MQTTCLIENT_ERR_PKT_LEN     MQTT_PACKET_ERR_PKT_LEN  /**< Inadequate free buffer in pkt */
#define MQTTCLIENT_ERR_NOTCONN     MQTT_PACKET_ERR_NOTCONN  /**< Lib isn't CONNECTED to server */
#define MQTTCLIENT_ERR_BADCALL     MQTT_PACKET_ERR_BADCALL  /**< Irrelevant call for LIB state */
#define MQTTCLIENT_ERR_CONTENT     MQTT_PACKET_ERR_CONTENT  /**< MSG / Data content has errors */
#define MQTTCLIENT_ERR_LIBQUIT     MQTT_PACKET_ERR_LIBQUIT  /**< Needs reboot library has quit */
#define MQTTCLIENT_ERR_REMLSTN     MQTT_PACKET_ERR_REMLSTN  /**< No remote listener for socket */
/** @} *//* End Client events */

#define MQTTCLIENT_OPERATION_CONNACK       MQTT_CONNACK     /**< CONNACK has been received from the server  */
#define MQTTCLIENT_OPERATION_EVT_PUBACK    MQTT_PUBACK      /**< PUBACK has been received from the server   */
#define MQTTCLIENT_OPERATION_PUBCOMP       MQTT_PUBCOMP     /**< PUBCOMP has been received from the server  */
#define MQTTCLIENT_OPERATION_SUBACK        MQTT_SUBACK      /**< SUBACK has been received from the server   */
#define MQTTCLIENT_OPERATION_UNSUBACK      MQTT_UNSUBACK    /**< UNSUBACK has been received from the server */

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

#define MQTTCLIENT_NETCONN_IP4                                   0x00  /**< Assert for IPv4 connection                  */
#define MQTTCLIENT_NETCONN_IP6                                   0x04  /**< Assert for IPv6 connection, otherwise  IPv4 */
#define MQTTCLIENT_NETCONN_URL                                   0x08  /**< Server address is an URL and not IP address */
#define MQTTCLIENT_NETCONN_SEC                                   0x10  /**< Connection to server  must  be secure (TLS) */

#define MQTTCLIENT_NETCONN_SKIP_DOMAIN_NAME_VERIFICATION         0x20  /**< Assert to skip domain name verfication      */
#define MQTTCLIENT_NETCONN_SKIP_CERTIFICATE_CATALOG_VERIFICATION 0x40  /**< Assert to skip certificate catalog
                                                                              verfication                               */

//*****************************************************************************
// typedefs
//*****************************************************************************

/** @defgroup sl_mqtt_cl_params SL MQTT Oper Parameters
 @{
 */
typedef enum
{
    MQTT_CLIENT_USER_NAME,
    MQTT_CLIENT_PASSWORD,
    MQTT_CLIENT_WILL_PARAM,
    MQTT_CLIENT_CALLBACKS,
    MQTT_CLIENT_KEEPALIVE_TIME,
    MQTT_CLIENT_CLEAN_CONNECT,
    MQTT_CLIENT_MAX_PARAM
} MQTTClient_Option;

/* callbacks   */

typedef enum
{
    MQTT_CLIENT_RECV_CB_EVENT,
    MQTT_CLIENT_OPERATION_CB_EVENT,
    MQTT_CLIENT_DISCONNECT_CB_EVENT
} MQTTClient_EventCB;

typedef struct _MQTTClient_OperationMetaDataCB_t_
{
    uint32_t messageType;
} MQTTClient_OperationMetaDataCB_t;

typedef struct _MQTTClient_RecvMetaDataCB_t_
{
    const char *topic;
    int32_t topLen;
    bool dup;
    uint8_t qos;
    bool retain;
} MQTTClient_RecvMetaDataCB_t;

/** @} *//* End Client API */

/** Secure Socket Parameters to open a secure connection */
/*
 Note: value of n_files can vary from 1 to 4, with corresponding pointers to
 the files in files field. Value of 1(n_files) will assume the corresponding
 pointer is for CA File Name. Any other value of n_files expects the files to
 be in following order:
 1.  Private Key File
 2.  Certificate File Name
 3.  CA File Name
 4.  DH Key File Name

 example:
 If you want to provide only CA File Name, following are the two way of doing it:
 for n_files = 1
 char *security_file_list[] = {"/cert/testcacert.der"};
 for n_files = 4
 char *security_file_list[] = {NULL, NULL, "/cert/testcacert.der", NULL};

 where secure_files = security_file_list
 */

typedef struct _MQTTClient_NetAppConnParams_t_
{
    uint32_t netconnFlags; /**< Enumerate connection type  */
    const char *serverAddr; /**< Server Address: URL or IP  */
    uint16_t port; /**< Port number of MQTT server */
    uint8_t method; /**< Method to tcp secured socket */
    uint32_t cipher; /**< Cipher to tcp secured socket */
    uint32_t nFiles; /**< Number of files for secure transfer */
    char * const *secureFiles; /* SL needs 4 files*/
} MQTTClient_NetAppConnParams_t;

typedef struct _MQTTClient_Attrib_t_
{
    char *clientId;
    bool mqttMode31; /**< Operate LIB in MQTT 3.1 mode; default is 3.1.1. false - default( 3.1.1) & true - 3.1) */
    bool blockingSend;
    MQTTClient_NetAppConnParams_t *connParams; // pointer to connection param

} MQTTClient_Attrib_t;

#ifndef METTAP_COMMON_H
#define METTAP_COMMON_H
typedef void (*NetAppCallBack_t)(int32_t event, void * metaData, uint32_t metaDateLen, void *data, uint32_t dataLen);
typedef void* NetAppHandle_t;
#endif

typedef struct _MQTTClient_SubscribeParams_t_
{
    char* topic;
    NetAppCallBack_t callback; // optional - if NULL use the default callback
    uint8_t qos;
    uint8_t persistent;
} MQTTClient_SubscribeParams_t;

typedef struct _MQTTClient_UnsubscribeParams_t_
{
    char* topic;
    uint8_t persistent;
} MQTTClient_UnsubscribeParams_t;

/*  Data structure which holds a will data message. */

typedef struct _MQTTClient_Will_t_
{
    const char *willTopic; /**< Will Topic   */
    const char *willMsg;   /**< Will message */
    int8_t      willQos;   /**< Will Qos     */
    bool        retain;    /**< Retain Flag  */

} MQTTClient_Will_t;

//*****************************************************************************
// function prototypes
//*****************************************************************************

/* Initialize the SL MQTT Implementation.
 A caller must initialize the MQTT implementation prior to using its services.

 \param[in]
 \return Success Handle or Failure NULL
 */

NetAppHandle_t MQTTClient_create(NetAppCallBack_t defaultCallback, MQTTClient_Attrib_t *attrib);

/** This function delete MQTT instance. It close the connection if exists and release all resources

 \return Success (0) or Failure (-1)
 */

int16_t MQTTClient_delete(NetAppHandle_t handle);

/**
 *  mqtt client state machine
 *  This function need to be called from the context created by the user in case of OS environment

 \return Success (0) or Failure (-1)
 */

int16_t MQTTClient_run(NetAppHandle_t handle);

/**

 Function connects MQTT client to a broker

 */
int16_t MQTTClient_connect(NetAppHandle_t handle);

/** DISCONNECT from the server.
 The caller must use this service to close the connection with the
 server.

 \param[in]  handle to the client context

 \return Success (0) or Failure (> 0)
 */
int16_t MQTTClient_disconnect(NetAppHandle_t handle);

/** PUBLISH a named message to the server.
 In addition to the PUBLISH specific parameters, the caller can indicate
 whether the routine should block until the time, the message has been
 acknowledged by the server. This is applicable only for non-QoS0 messages.

 In case, the app has chosen not to await for the ACK from the server,
 the SL MQTT implementation will notify the app about the subscription
 through the callback routine.

 \param[in] handle refers to the handle to the client context
 \param[in] topic  topic of the data to be published. It is NULL terminated.
 \param[in] topicLen  topic length.
 \param[in] msg   binary data to be published
 \param[in] msgLen    length of the msg
 \param[in] flags QOS define MQTT_PUBLISH_QOS_0, MQTT_PUBLISH_QOS_1 or MQTT_PUBLISH_QOS_2
 use MQTT_PUBLISH_RETAIN is message should be retained

 \return Success(transaction Message ID) or Failure(> 0)
 */

int16_t MQTTClient_publish(NetAppHandle_t handle, char *topic, uint16_t topicLen, char *msg, uint16_t msgLen, uint32_t flags);

int16_t MQTTClient_subscribe(NetAppHandle_t handle,    MQTTClient_SubscribeParams_t *value, uint8_t numberOfTopics);

int16_t MQTTClient_unsubscribe(NetAppHandle_t handle, MQTTClient_UnsubscribeParams_t *value, uint8_t numberOfTopics);

int16_t MQTTClient_set(NetAppHandle_t handle, uint16_t option, void *value,    uint16_t valueLength);

int16_t MQTTClient_get(NetAppHandle_t handle, uint16_t option, void *value,    uint16_t valueLength);

#ifdef __cplusplus  
}
#endif  

#endif // __SL_MQTT_H__
