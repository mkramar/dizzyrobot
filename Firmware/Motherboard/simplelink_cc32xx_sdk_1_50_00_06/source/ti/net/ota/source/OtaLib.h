/*
 * OtaLib.h - Header OTA APP Implementation
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
#ifndef __OTA_LIB_H__
#define __OTA_LIB_H__

#ifdef    __cplusplus
extern "C" {
#endif

/******************************************************************************
 * OTA states
******************************************************************************/
typedef enum
{
    OTA_STATE_IDLE = 0,
    OTA_STATE_CONNECT_SERVER,
    OTA_STATE_REQ_OTA_DIR,
    OTA_STATE_CHECK_ARCHIVE_NEW_UPDATE,
    OTA_STATE_REQ_FILE_URL,
    OTA_STATE_CONNECT_FILE_SERVER,
    OTA_STATE_REQ_FILE_CONTENT,
    OTA_STATE_PREPARE_DOWNLOAD,
    OTA_STATE_DOWNLOADING,
    OTA_STATE_WAIT_CONFIRM,
    OTA_STATE_NUMBER_OF_STATES
} OtaState_e;

#define MAX_VENDIR_DIR_SIZE     50

typedef struct
{
    OtaState_e  State;
    uint32_t        Options;

    /* Keep OTA parameters */
    uint8_t         VendorDir[MAX_VENDIR_DIR_SIZE];
    Ota_optServerInfo OtaServerInfo;

    /* OTA objects */
    CdnClient_t  CdnClient;
    OtaArchive_t OtaArchive;

    /* OtaDir and FileUrl info */
    uint8_t  *pOtaFileName;
    int32_t OtaFileSize;
    uint8_t  FileUrlBuf[MAX_URL_SIZE];

    /* file content buffer */
    uint8_t *pRecvChunk;
    int16_t RecvChunkSize;
    int16_t RecvChunkOffset;
    int16_t RecvChunkForceReadMode;
    int16_t RecvChunkReserved;

    /* send/recv buffer - must be 4 bytes alignment */
    uint8_t NetBuf[NET_BUF_SIZE+1];

    /* Retries */
    int8_t  ConsecutiveOtaErrors;

} OtaLib_t;

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_LIB_H__ */
