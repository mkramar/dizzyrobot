/*
 * OtaDropbox.h - Header file for OtaDropbox.c
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
#ifndef __OTA_DROPBOX_V2_H__
#define __OTA_DROPBOX_V2_H__

#ifdef    __cplusplus
extern "C" {
#endif

#include <ti/net/ota/source/CdnClient.h>

/* dropbox specific functions */
int16_t  CdnDropboxV2_SendReqDir(int16_t SockId, uint8_t *pSendBuf, uint8_t *pServerName, uint8_t *pVendorDir, uint8_t *pVendorToken);
int16_t  CdnDropboxV2_ParseRespDir(int16_t SockId, uint8_t *pRespBuf, OtaDirData_t *pOtaDirData);
int16_t  CdnDropboxV2_SendReqFileUrl(int16_t SockId, uint8_t *pSendBuf, uint8_t *pServerName, uint8_t *pFileName, uint8_t *pVendorToken);
int16_t  CdnDropboxV2_ParseRespFileUrl(uint16_t SockId, uint8_t *pRespBuf, uint8_t *pFileUrl, uint32_t FileUrlBufSize);
int16_t  CdnDropboxV2_SendReqFileContent(int16_t SockId, uint8_t *pSendBuf, uint8_t *pFileServerName, uint8_t *pFileName);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_DROPBOX_V2_H__ */
