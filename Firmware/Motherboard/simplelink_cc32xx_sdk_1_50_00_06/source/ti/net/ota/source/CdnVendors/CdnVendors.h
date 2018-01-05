/*
 * CdnVendors.h - Header file for CdnVendors = Dropbox, Github, ...
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
#ifndef __CDN_VENDORS_H__
#define __CDN_VENDORS_H__

#ifdef    __cplusplus
extern "C" {
#endif

#include <ti/net/ota/otauser.h>

/* OTA server info */
/* --------------- */
#if OTA_SERVER_TYPE == OTA_SERVER_GITHUB

#include <ti/net/ota/source/CdnVendors/CdnGithub.h>

#define CdnVendor_SendReqDir            CdnGithub_SendReqDir
#define CdnVendor_ParseRespDir          CdnGithub_ParseRespDir
#define CdnVendor_SendReqFileUrl        CdnGithub_SendReqFileUrl
#define CdnVendor_ParseRespFileUrl      CdnGithub_ParseRespFileUrl
#define CdnVendor_SendReqFileContent    CdnGithub_SendReqFileContent

#elif OTA_SERVER_TYPE == OTA_SERVER_DROPBOX_V2

#include <ti/net/ota/source/CdnVendors/CdnDropboxV2.h>

#define CdnVendor_SendReqDir            CdnDropboxV2_SendReqDir
#define CdnVendor_ParseRespDir          CdnDropboxV2_ParseRespDir
#define CdnVendor_SendReqFileUrl        CdnDropboxV2_SendReqFileUrl
#define CdnVendor_ParseRespFileUrl      CdnDropboxV2_ParseRespFileUrl
#define CdnVendor_SendReqFileContent    CdnDropboxV2_SendReqFileContent

#endif


#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __CDN_VENDORS_H__ */
