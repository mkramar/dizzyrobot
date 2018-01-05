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
#include "server_plug.h"
#include "server_core.h"
#include "server_util.h"

//*****************************************************************************
// defines
//*****************************************************************************
#define MAX_PLUGINS            PG_MAP_MAX_ELEMS
#define PG_NAME_LEN            32

//*****************************************************************************
// typedefs
//*****************************************************************************
typedef struct _MQTTServerPlug_desc_t_
{

    char *name;
    uint8_t index;
    uint8_t inuse;

    MQTTServerCore_AppCBs_t app_cbs;

} MQTTServerPlug_desc_t; 

//*****************************************************************************
//globals
//*****************************************************************************
MQTTServerPlug_desc_t MQTTServerPlug_plugins[MAX_PLUGINS];
static MQTTServerPlug_desc_t *MQTTServerPlug_aclPg = NULL;

static MQTTServerPlug_CBs_t MQTTServerPlug_msgCBacks = { NULL, NULL, NULL };
static MQTTServerPlug_CBs_t *MQTTServerPlug_msgCBs;

//*****************************************************************************
// Internal Routines
//*****************************************************************************
//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static inline bool is_inuse(MQTTServerPlug_desc_t *plugin)
{
    return (plugin->inuse ? true : false);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static inline void inuse_set(MQTTServerPlug_desc_t *plugin, bool inuse)
{
    plugin->inuse = inuse ? 0x01 : 0x00;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static inline MQTTServerPlug_desc_t *plugin_find(int32_t idx)
{
    return (MQTTServerPlug_plugins + idx);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static void plugin_reset(MQTTServerPlug_desc_t *plugin)
{
    inuse_set(plugin, false);

    return;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static MQTTServerPlug_desc_t *plugin_alloc(void)
{
    MQTTServerPlug_desc_t *plugin = NULL;
    int32_t idx = 0;

    for (idx = 0; idx < MAX_PLUGINS; idx++)
    {
        plugin = MQTTServerPlug_plugins + idx;
        if (false == is_inuse(plugin))
        {
            inuse_set(plugin, true);
            break;
        }
    }

    DBG_INFO("Plugin allocation %s\n\r", (MAX_PLUGINS == idx)? "Failed" : "Success");

    return ((MAX_PLUGINS != idx) ? plugin : NULL);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
static void *server_app_register(const MQTTServerCore_AppCBs_t *cbs, const char *name)
{
    MQTTServerPlug_desc_t *plugin = plugin_alloc();

    if (NULL != plugin)
    {
        strncpy(plugin->name, name, PG_NAME_LEN - 1);
        memcpy(&plugin->app_cbs, cbs, sizeof(MQTTServerCore_AppCBs_t));

        if ((NULL == MQTTServerPlug_aclPg) && cbs->connect)
        {
            MQTTServerPlug_aclPg = plugin;
        }
    }
    return plugin;
}


//*****************************************************************************
// External Routines
//*****************************************************************************

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
uint16_t MQTTServerPlug_connect(const MQTT_UTF8String_t *clientId, const MQTT_UTF8String_t *username, 
                        const MQTT_UTF8String_t *password, void **appUsr)
{
    uint16_t rv = MQTT_CONNACK_RC_REQ_ACCEPT; /* Accept everything from MQTT network */

    *appUsr = NULL;
    if (MQTTServerPlug_aclPg)
    {
        rv = MQTTServerPlug_aclPg->app_cbs.connect(clientId, username, password, appUsr);
    }
    return rv;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerPlug_publish( uint8_t pg_map, const MQTT_UTF8String_t *topic, const uint8_t *payload, 
                        uint32_t payLen, bool dup, uint8_t qos, bool retain)
{
    int32_t i = 0;

    for (i = 0; i < MAX_PLUGINS; i++)
    {
        if (PG_MAP_HAS_VALUE(pg_map, i))
        {
            MQTTServerPlug_desc_t *plugin = plugin_find(i);

            DBG_INFO("Publishing to Plugin ID: %d (%s)\n\r", plugin->index, plugin->name);

            if (false == is_inuse(plugin))
            {
                continue; /* Must not happen */
            }
            plugin->app_cbs.publish(topic, payload, payLen, dup, qos, retain);
        }
    }

    return payLen;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerPlug_disconn(const void *appUsr, bool due2err)
{
    if (MQTTServerPlug_aclPg)
    {
        MQTTServerPlug_aclPg->app_cbs.disconn(appUsr, due2err);
    }
    return 0;
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerCore_topicEnroll(const void *app_hnd, const MQTT_UTF8String_t *topic, MQTT_QOS qos)
{
    return (app_hnd ? MQTTServerPlug_msgCBs->topicEnroll(((MQTTServerPlug_desc_t *)(app_hnd))->index, topic, qos) : -1);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerCore_topicDisenroll(const void *app_hnd, const MQTT_UTF8String_t *topic)
{
    return (app_hnd ? MQTTServerPlug_msgCBs->topicCancel(((MQTTServerPlug_desc_t *)(app_hnd))->index, topic) : -1);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerCore_pubSend(const MQTT_UTF8String_t *topic, const uint8_t *dataBuf, uint32_t dataLen, MQTT_QOS qos, bool retain)
{
    return (MQTTServerPlug_msgCBs->publish(topic, dataBuf, dataLen, qos, retain));
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
void *MQTTServerCore_appRegister(const MQTTServerCore_AppCBs_t *cbs, const char *name)
{
    if ((NULL == cbs) || ((!!cbs->connect) ^ (!!cbs->disconn)) || (MQTTServerPlug_aclPg && cbs->connect))
    {
        return NULL;
    }
    return server_app_register(cbs, name);
}

//*****************************************************************************
//
//! \brief
//
//*****************************************************************************
int32_t MQTTServerPlug_init(const MQTTServerPlug_CBs_t *cbs)
{
    int32_t idx = 0;
    MQTTServerPlug_desc_t *plugin;

    MQTTServerPlug_aclPg = NULL;

    if (NULL == cbs)
    {
        return -2;
    }
    if (!(cbs->topicEnroll && cbs->topicCancel && cbs->publish))
    {
        return -3;
    }
    for (idx = 0; idx < MAX_PLUGINS; idx++)
    {
        plugin = MQTTServerPlug_plugins + idx;
        plugin->index = idx;

        plugin_reset(plugin);
    }

    MQTTServerPlug_msgCBs = &MQTTServerPlug_msgCBacks;
    memcpy(MQTTServerPlug_msgCBs, cbs, sizeof(MQTTServerPlug_CBs_t));

    USR_INFO("Plugin module has been initialized.\n\r");
    return 0;
}

