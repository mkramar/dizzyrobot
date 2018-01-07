/*
 * otauser.h - Header file for user configurations (CdnVendor=Dropbox/Github)
 *
 * 
 * Copyright (C) 2016 Texas Instruments Incorporated
 * 
 * All rights reserved. Property of Texas Instruments Incorporated.
 * Restricted rights to use, duplicate or disclose this code are
 * granted through contract.
 * The program may not be used without the written permission of
 * Texas Instruments Incorporated or against the terms and conditions
 * stipulated in the agreement under which this program has been supplied,
 * and under no circumstances can it be used with non-TI connectivity device.
 *
*/
#ifndef __OTA_USER_H__
#define __OTA_USER_H__

#ifdef    __cplusplus
extern "C" {
#endif

#include <stdlib.h>

#include <ti/drivers/net/wifi/simplelink.h>
#include <ti/net/ota/ota.h>

//#define SL_ENABLE_OTA_DEBUG_TRACES /* uncomment to enable internal OTA debug info */
#ifndef SL_ENABLE_OTA_DEBUG_TRACES
#define _SlOtaLibTrace(pargs) 
#else

#ifdef _WIN32

#define _SlOtaLibTrace(pargs)  printf pargs

#elif __MSP432P401R__

extern void LogMessage(const char *pcFormat, ...);
#define _SlOtaLibTrace(pargs)  LogMessage pargs

#else /*CC3220*/

extern int Report(const char *format, ...);
#define _SlOtaLibTrace(pargs)  Report pargs

#endif

#endif

#define OTA_SERVER_GITHUB      1
#define OTA_SERVER_DROPBOX_V2  2
#define OTA_SERVER_CUSTOM      99

/* USER SHOULD DEFINE HERE WHICH CLOUD TO USE */
/* -------------------------------------------*/
//#define OTA_SERVER_TYPE    OTA_SERVER_GITHUB
#define OTA_SERVER_TYPE    OTA_SERVER_DROPBOX_V2

/* OTA server info */
/* --------------- */

#ifdef _WIN32
#define OTA_VENDOR_DIR  "OTA_CC3120"
#elif __MSP432P401R__
#define OTA_VENDOR_DIR  "OTA_CC3120"
#else
#define OTA_VENDOR_DIR  "OTA_CC3220SF"
#endif

#if OTA_SERVER_TYPE == OTA_SERVER_GITHUB

/* Github server info */
#define OTA_SERVER_NAME                 "api.github.com"
#define OTA_SERVER_IP_ADDRESS           0x00000000
#define OTA_SERVER_SECURED              1

/* Github vendor info */
#define OTA_VENDOR_ROOT_DIR             "/repos/<user account>/<user directory>"
//#define OTA_VENDOR_TOKEN              "<User defined Github token>"
#ifndef OTA_VENDOR_TOKEN
#error "Please define your personal cloud account token in OTA_VENDOR_TOKEN above"
#endif

#define OTA_SERVER_ROOT_CA_CERT         "DigCert_High_Assurance_CA.der"
#define OTA_SERVER_AUTH_IGNORE_DATA_TIME_ERROR
#define OTA_SERVER_AUTH_DISABLE_CERT_STORE

#elif OTA_SERVER_TYPE == OTA_SERVER_DROPBOX_V2

/* Dropbox V2 server info */
#define OTA_SERVER_NAME                 "api.dropboxapi.com"
#define OTA_SERVER_IP_ADDRESS           0x00000000
#define OTA_SERVER_SECURED              1

/* Dropbox V2 vendor info */
//#define OTA_VENDOR_TOKEN              "<User defined Dropbox token>"
#ifndef OTA_VENDOR_TOKEN
#error "Please define your personal cloud account token in OTA_VENDOR_TOKEN above"
#endif

#define OTA_SERVER_ROOT_CA_CERT         "DigCert_High_Assurance_CA.der"
#define OTA_SERVER_AUTH_IGNORE_DATA_TIME_ERROR
#define OTA_SERVER_AUTH_DISABLE_CERT_STORE

#elif OTA_SERVER_TYPE == OTA_SERVER_CUSTOM

/* add your customer server header here */
#include ""

/* Github server info */
#define OTA_SERVER_NAME                 ""
#define OTA_SERVER_IP_ADDRESS           0x00000000
#define OTA_SERVER_SECURED              1

/* Vendor info */
#define OTA_VENDOR_TOKEN                "User defined token"

#define CdnVendor_SendReqDir           
#define CdnVendor_ParseRespDir          
#define CdnVendor_SendReqFileUrl        
#define CdnVendor_ParseRespFileUrl      
#define CdnVendor_SendReqFileContent    

#endif


#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_USER_H__ */
