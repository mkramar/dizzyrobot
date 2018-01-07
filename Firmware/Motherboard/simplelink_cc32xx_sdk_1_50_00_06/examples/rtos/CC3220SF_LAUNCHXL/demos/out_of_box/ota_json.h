/*
 * Copyright (c) 2016, Texas Instruments Incorporated
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * *  Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 *
 * *  Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * *  Neither the name of Texas Instruments Incorporated nor the names of
 *    its contributors may be used to endorse or promote products derived
 *    from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
 * OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 * WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
 * OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE,
 * EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
 
#ifndef __OTA_JSON_H__
#define __OTA_JSON_H__

#ifdef    __cplusplus
extern "C" {
#endif
#include <ti/net/json/include/json.h>
#include "ota_archive.h"

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

extern int snprintf(char *_string, size_t _n, const char *_format, ...);

/* service routine */
uint8_t *Str_FindChar(uint8_t *pBuf, uint8_t CharVal, int32_t BufLen);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_JSON_H__ */
