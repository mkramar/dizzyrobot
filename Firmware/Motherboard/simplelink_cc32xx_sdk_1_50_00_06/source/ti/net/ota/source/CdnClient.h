/*
 * CdnClient.h - Header file OTA Client implementation
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
#ifndef __CDN_CLIENT_H__
#define __CDN_CLIENT_H__

#ifdef    __cplusplus
extern "C" {
#endif

#define MAX_DIR_FILES             4
#define MAX_CDN_FILE_NAME_SIZE  128

typedef struct  
{
    uint8_t   OtaFileName[MAX_CDN_FILE_NAME_SIZE+1];
    int32_t  OtaFileSize;
} OtaFileInfo_t; 

typedef struct 
{
    int16_t  NumFiles;
    OtaFileInfo_t OtaFileInfo[MAX_DIR_FILES];
} OtaDirData_t; 

typedef struct 
{
    /* Keep OTA parameters */
	Ota_optServerInfo *pOtaServerInfo;

    /* Keep OTA dir info */
    int32_t CurrDirFileIndex;
    OtaDirData_t OtaDirData;

    /* CdnDirServer connection info */
    int16_t ServerSockId;
    int32_t PortNum;
    int16_t FileSockId;
    uint8_t *pRecvChunk;
    uint8_t *pNetBuf;

} CdnClient_t; 

/* Internal return values */
#define CDN_STATUS_OK                                   (0L)
#define CDN_STATUS_ERROR_SL_SEND                        (-20201L)
#define CDN_STATUS_ERROR_SL_RECV_HDR_EAGAIN             (-20202L)
#define CDN_STATUS_ERROR_PARSE_URL_NOT_FOUND            (-20203L)
#define CDN_STATUS_ERROR_PARSE_DIR_NO_ARRAY             (-20204L)
#define CDN_STATUS_ERROR_PARSE_DIR_NO_OBJECT            (-20205L)
#define CDN_STATUS_ERROR_PARSE_DIR_NO_FILE_SIZE         (-20206L)
#define CDN_STATUS_ERROR_PARSE_DIR_NO_FILE_NAME         (-20207L)

int16_t  CdnClient_Init(CdnClient_t *pCdnClient, uint8_t *pNetBuf);
int16_t  CdnClient_ConnectServer(CdnClient_t *pCdnClient, Ota_optServerInfo *pOtaServerInfo);
int16_t  CdnClient_CloseServer(CdnClient_t *pCdnClient);
int16_t  CdnClient_ReqOtaDir(CdnClient_t *pCdnClient, uint8_t *pVendorDir);
uint8_t  *CdnClient_GetNextDirFile(CdnClient_t *pCdnClient, int32_t *OtaFileSize);
int16_t  CdnClient_ReqFileUrl(CdnClient_t *pCdnClient, uint8_t *pOtaFileName, uint8_t *pFileUrlBuf, uint32_t FileUrlBufSize);
int16_t  CdnClient_ConnectFileServer(CdnClient_t *pCdnClient, uint8_t *pFileUrl, int32_t SecuredConnection);
int16_t  CdnClient_ReqFileContent(CdnClient_t *pCdnClient, uint8_t *pFileUrl);
int16_t  CdnClient_CloseFileServer(CdnClient_t *pCdnClient);
int16_t  CdnClient_RecvSkipHdr(int16_t SockId, uint8_t *pRespBuf, int16_t RespBufSize);
int16_t  CdnClient_RecvAppend(int16_t SockId, uint8_t *pRecvBuf, int16_t RecvBufSize, int16_t RecvLen, int16_t RecvOffset);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __CDN_CLIENT_H__ */
