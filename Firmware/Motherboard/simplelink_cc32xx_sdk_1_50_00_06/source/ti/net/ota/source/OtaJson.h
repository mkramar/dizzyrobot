/*
 * OtaJson.h - Minimal Json parser services tailored for OTA header file
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
#ifndef __OTA_JSON_H__
#define __OTA_JSON_H__

#ifdef    __cplusplus
extern "C" {
#endif

#include <ti/net/json/include/json.h>
#include "OtaArchive.h"

typedef struct
{
    char *fileBuffer;
} Json_Filename_t;

typedef struct OtaJson {
    handle          jsonObjHandle;
    handle          templateHandle;
    Json_Filename_t jsonBuffer;
}OtaJson;

/*base64 decode module */
void    B64_Init(void);
uint8_t *B64_Decode(uint8_t *pInputData, int32_t InputLen, uint8_t *pOutputData, int32_t *OutputLen);

int16_t OtaJson_init(char *template, char **text, uint16_t textLen);
int16_t OtaJson_destroy(void);
int16_t OtaJson_getArrayMembersCount(handle objHandle, const char * pKey);
int16_t OtaJson_getFilename(OtaArchive_BundleFileInfo_t *CurrBundleFile);
int16_t OtaJson_getSignature(OtaArchive_BundleFileInfo_t *CurrBundleFile);
int16_t OtaJson_getCertificate(OtaArchive_BundleFileInfo_t *CurrBundleFile);
int16_t OtaJson_getSha256Digest (OtaArchive_BundleFileInfo_t *CurrBundleFile);
int16_t OtaJson_getSecureField(OtaArchive_BundleFileInfo_t *CurrBundleFile);
int16_t OtaJson_getBundleField(OtaArchive_BundleFileInfo_t *CurrBundleFile);
uint8_t *OtaJson_FindStartObject(uint8_t *pBuf, uint8_t *pEndBuf);
uint8_t *OtaJson_FindEndObject(uint8_t *pBuf, uint8_t *pEndBuf);
int16_t OtaJson_getURL (uint8_t *pFileUrl, const char *downloadKey);
int16_t OtaJson_getMetadataFileName (uint8_t *pFileName, const char *FileNameKey);
int16_t OtaJson_getMetadataFileSize (uint32_t *pFileSize, const char *fileSizeKey);

extern int snprintf(char *_string, size_t _n, const char *_format, ...);

/* service routine */
uint8_t *Str_FindChar(uint8_t *pBuf, uint8_t CharVal, int32_t BufLen);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_JSON_H__ */
