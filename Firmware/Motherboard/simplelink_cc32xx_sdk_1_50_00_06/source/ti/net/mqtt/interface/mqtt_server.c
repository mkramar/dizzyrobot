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
 
#include <ti/net/mqtt/common/mqtt_common.h>
#include <ti/net/mqtt/mqtt_server.h>
#include <ti/net/mqtt/server/server_core.h>
#include <ti/net/mqtt/server/client_mgmt.h>
#include <ti/net/mqtt/server/server_util.h>
#include <ti/net/mqtt/platform/cc32xx_sl_net.h>

/* POSIX Header files */
#include <pthread.h>
#include <semaphore.h>

//*****************************************************************************
// defines
//*****************************************************************************
#define UART_PRINT                  Report

#define MQTTSERVER_LOOPBACK_PORT    (1882)

// Specifying Receive time out for the Receive task
#define MQTTSERVER_RCV_TIMEOUT      (30)

//*****************************************************************************
// typedefs
//*****************************************************************************
typedef struct _MQTTServer_Ctrl_t_
{
    _const void* pluginHndl;
}MQTTServer_Ctrl_t;

//*****************************************************************************
//globals
//*****************************************************************************
extern int32_t Report(const char *pcFormat, ...);
extern int32_t MQTTServerPkts_recvHvec[];
extern uint32_t MQTTServerPkts_closeInProgress;

pthread_mutex_t MQTTServer_mutex;
MQTTServer_Ctrl_t MQTTServer_appHndl;

MQTTServerCore_AppCfg_t MQTTServer_appConfig = { NULL };

/* Global that holds parameters on the server for */
/* Authentication of Clients by the Server        */
MQTTServer_LocalAuthenticationData_t MQTTServer_LocalAuthenticationData;

/*Task Priority and Response Time*/
uint32_t MQTTServer_waitSecs = MQTTSERVER_RCV_TIMEOUT;

MQTT_DeviceNetServices_t MQTTServer_netOps = 
{  
    commOpen, tcpSend, tcpRecv, sendTo, recvFrom,
    commClose, tcpListen, tcpAccept, tcpSelect, rtcSecs
};

NetAppCallBack_t MQTTServer_cbs = NULL;

uint16_t SlMQTTServerConnectCB(_const MQTT_UTF8String_t *clientId,
                            _const MQTT_UTF8String_t *username,
                            _const MQTT_UTF8String_t *password, void **appUsr);
                            
void SlMQTTServerPublishCB(_const MQTT_UTF8String_t *topic,
                        _const uint8_t *payload, uint32_t payLen,
                        bool dup, uint8_t qos, bool retain);
                        
void SlMQTTServerDisconnCB(_const void *appUsr, bool due2err);

static void MQTTServerMutexLock(void* mutexHndl);
static void MQTTServerMutexUnlock(void* mutexHndl);

MQTTServerCore_AppCBs_t MQTTServer_appCBs =
{
    SlMQTTServerConnectCB,
    SlMQTTServerPublishCB,
    SlMQTTServerDisconnCB
};
                                                    
MQTTServerPkts_LibCfg_t MQTTServer_cfg =
{
    0, MQTTSERVER_LOOPBACK_PORT, &MQTTServer_mutex, MQTTServerMutexLock,
    MQTTServerMutexUnlock, (int32_t (*)(const char *, ...)) UART_PRINT, true
};


//*****************************************************************************
// MQTT Server Internal Routines
//*****************************************************************************

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static void MQTTServerMutexLock(void* mutexHndl)
{
    pthread_mutex_lock((pthread_mutex_t)mutexHndl);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static void MQTTServerMutexUnlock(void* mutexHndl)
{
    pthread_mutex_unlock((pthread_mutex_t)mutexHndl);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
uint16_t SlMQTTServerConnectCB(_const MQTT_UTF8String_t *clientId,
                            _const MQTT_UTF8String_t *username,
                            _const MQTT_UTF8String_t *password, void **appUsr)
{
    MQTTServer_ConnectMetaDataCB_t meta;

    meta.clientId = (char*)MQ_CONN_UTF8_BUF(clientId);
    meta.clientIdLen = MQ_CONN_UTF8_LEN(clientId);
    meta.userName = (char*)MQ_CONN_UTF8_BUF(username);
    meta.usernameLen = MQ_CONN_UTF8_LEN(username);
    meta.password = (char*)MQ_CONN_UTF8_BUF(password);
    meta.passwordLen = MQ_CONN_UTF8_LEN(password);
    meta.usr = appUsr;

    /* When the server set user name, that means that local               */
    /* authentication, Authentication of Clients by the Server, is        */
	/* required                                                           */
    if (strlen(MQTTServer_LocalAuthenticationData.userName) > 0)
    {
        /* Comparing the server user name with the user name that the     */
        /* client sent in the connection request                                    */
        if ((username != NULL) && strcmp(MQTTServer_LocalAuthenticationData.userName, meta.userName) == 0)
        {
            /* Comparing the server password with the password that the   */
            /* client sent in the connection request                      */
            if ((password != NULL) && strcmp(MQTTServer_LocalAuthenticationData.password, meta.password) == 0)
            {
                MQTTServer_cbs( MQTT_SERVER_CONNECT_CB_EVENT, &meta, sizeof(meta), NULL, 0 );
                return 0;
            }
        }
    }
    else
    {
        /* No local authentication is required                            */
        MQTTServer_cbs( MQTT_SERVER_CONNECT_CB_EVENT, &meta, sizeof(meta), NULL, 0 );
        return 0;
    }

    /* Local authentication is required and the user name or password doesn't */
	/* not match                                                              */
    MQTTServer_cbs( MQTT_SERVER_CONNECT_CB_EVENT, &meta, sizeof(meta), (void *)MQTT_CONNACK_RC_BAD_USRPWD, sizeof(int) );    
    return MQTT_CONNACK_RC_BAD_USRPWD;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void SlMQTTServerPublishCB(_const MQTT_UTF8String_t *topic,
                        _const uint8_t *payload, uint32_t payLen,
                        bool dup, uint8_t qos, bool retain)
{
    MQTTServer_RecvMetaDataCB_t meta;

    meta.topic  = (char*)MQ_CONN_UTF8_BUF(topic);
    meta.topLen = MQ_CONN_UTF8_LEN(topic);
    meta.qos    = qos;
    meta.dup    = dup;
    meta.retain = retain;
    MQTTServer_cbs( MQTT_SERVER_RECV_CB_EVENT, &meta, sizeof(MQTTServer_RecvMetaDataCB_t), (char*)payload, payLen );
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void SlMQTTServerDisconnCB(_const void *appUsr, bool due2err)
{
    MQTTServer_DisconnectMetaDataCB_t meta;
    
    meta.dueToErr = due2err;
    meta.user = (char*)appUsr;
    MQTTServer_cbs( MQTT_SERVER_DISCONNECT_CB_EVENT, &meta, sizeof(MQTTServer_DisconnectMetaDataCB_t), NULL, 0 );
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
uint16_t MQTTServerSend(NetAppHandle_t hdl , void* meta , uint16_t metaLen , void* data , uint16_t dataLen , uint32_t flags)
{
    char qos_level = (flags & (MQTT_QOS_1 | MQTT_QOS_1 | MQTT_QOS_2));
    bool retain =  (flags & MQTT_PUBLISH_RETAIN);
    MQTT_UTF8String_t topicUTF8 = { NULL };
    
    topicUTF8.buffer = (char*) meta;
    topicUTF8.length = strlen(meta);
    
    return (MQTTServerCore_pubSend(&topicUTF8, data, dataLen, (MQTT_QOS) qos_level, retain));
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerTopicEnroll(_const char *topic)
{
    MQTT_UTF8String_t topicUTF8 = { NULL };
    
    topicUTF8.buffer = (char*) topic;
    topicUTF8.length = strlen(topic);
    
    return (MQTTServerCore_topicEnroll((void*) (MQTTServer_appHndl.pluginHndl), &topicUTF8, MQTT_QOS2));

}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerTopicDisenroll(_const char *topic)
{
    MQTT_UTF8String_t topicUTF8 = { NULL };
    
    topicUTF8.buffer = (char*) topic;
    topicUTF8.length = strlen(topic);
    
    return (MQTTServerCore_topicDisenroll((void*) &(MQTTServer_appHndl.pluginHndl), &topicUTF8));
}


//*****************************************************************************
// MQTT Client External Routines
//*****************************************************************************

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
NetAppHandle_t MQTTServer_create(NetAppCallBack_t defaultCallback,  MQTTServer_Attrib_t *attrib)
{
    NetAppHandle_t  handle = (NetAppHandle_t)1;
    int32_t ret;
    
    MQTTServerPkts_closeInProgress = 0;

    MQTTServer_cbs = defaultCallback;
    MQTTServer_cfg.listenerPort =  attrib->connParams->port;
    MQTTServer_cfg.secure.method =  &(attrib->connParams->method);
    MQTTServer_cfg.secure.cipher = &(attrib->connParams->cipher);
    MQTTServer_cfg.secure.nFile = attrib->connParams->nFiles;
    MQTTServer_cfg.secure.files = (char **) (attrib->connParams->secureFiles);

    /* Initialize UserName and password to NULL */
    MQTTServer_LocalAuthenticationData.userName = NULL;
    MQTTServer_LocalAuthenticationData.password = NULL;

    ret = pthread_mutex_init(&MQTTServer_mutex, (const pthread_mutexattr_t *)NULL);
    if (ret < 0)
    {
        UART_PRINT("could not create Multi-task Lock mutex\n\r");
        return NULL;
    }
    if(NULL != MQTTServer_mutex)
    {
        ret = MQTTServerCore_init(&MQTTServer_cfg, &MQTTServer_appConfig);
    }
    else
    {
        return NULL;
    }
    /* registering the device specific implementations for net operations */
    MQTTServerPkts_registerNetSvc(&MQTTServer_netOps);

    /* registering the apps callbacks */
    MQTTServer_appHndl.pluginHndl = MQTTServerCore_appRegister(&MQTTServer_appCBs, "temp");

    if(0 == ret)
    {
        return handle;
    }
    else
    {
        return NULL;
    }
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int16_t MQTTServer_delete(NetAppHandle_t handle)
{
    int32_t rdIdx = 0;
    int32_t fd;
    int32_t retCode;

    MQTTServerPkts_closeInProgress = 1;
    fd = MQTTServerPkts_recvHvec[rdIdx];
    while (-1 != fd)
    {
        MQTTServer_netOps.close(fd);
        fd = MQTTServerPkts_recvHvec[++rdIdx];
    }

    retCode = pthread_mutex_destroy(&MQTTServer_mutex);

    /* Initialize and free allocated memory for the clients */
    MQTTClientMgmt_init();

    /* Delete and free the topic node tree */
    MQTTServerCore_topicNodeExit();

    return retCode;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int16_t MQTTServer_run(NetAppHandle_t handle)
{
    MQTTServerPkts_run(MQTTServer_waitSecs);
    return 0;
}


//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int16_t MQTTServer_subscribe(NetAppHandle_t handle, MQTTServer_SubscribeParams_t *value, uint8_t numberOfTopics)
{
    int i;
    
    for( i = 0; i < numberOfTopics; i++ )
    {
        MQTTServerTopicEnroll((char*) value[i].topic);
    }
    return 0;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int16_t MQTTServer_unsubscribe(NetAppHandle_t handle, MQTTServer_UnSubscribeParams_t *value, uint8_t numberOfTopics)
{
    int i;
    
    for( i = 0; i < numberOfTopics; i++ )
    {
        MQTTServerTopicDisenroll((char*) value[i].topic);
    }
    return 0;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int16_t MQTTServer_publish(NetAppHandle_t handle, char *topic,  uint16_t topicLen, char *msg, uint16_t msgLen, uint32_t flags)
{
    return (MQTTServerSend(handle, topic, topicLen, msg, msgLen, flags));
}

//*****************************************************************************
//
//! \brief  Set User name and password on the server for Clients Authentication
//   Note: Only when setting the User name the authentication mechanism works    
//
//*****************************************************************************
int16_t MQTTServer_set(NetAppHandle_t handle , uint16_t option , void *value , uint16_t valueLength)
{
    int32_t retVal = 0;

    switch (option)
    {
        case MQTT_SERVER_USER_NAME:
            /* Save the reference to the User name */
            MQTTServer_LocalAuthenticationData.userName = (char*) value;
            break;

        case MQTT_SERVER_PASSWORD:
            /* Save the reference to the password */
            MQTTServer_LocalAuthenticationData.password = (char*) value;
            break;
        default:
            break;
    }
    return retVal;
}

