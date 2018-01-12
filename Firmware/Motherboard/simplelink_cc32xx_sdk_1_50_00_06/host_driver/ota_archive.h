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
 
#ifndef _OTA_ARCHIVE_H__
#define _OTA_ARCHIVE_H__

#ifdef    __cplusplus
extern "C" {
#endif

#include <ti/drivers/crypto/CryptoCC32XX.h>

#define OTA_ARCHIVE_VERSION    "OTA_ARCHIVE_2.0.0.4"

/* RunStatus */
#define ARCHIVE_STATUS_FORCE_READ_MORE                  (2L)
#define ARCHIVE_STATUS_DOWNLOAD_DONE                    (1L)
#define ARCHIVE_STATUS_CONTINUE                         (0L)
#define ARCHIVE_STATUS_OK                               (0L)
#define ARCHIVE_STATUS_ERROR_STATE                      (-20101L)
#define ARCHIVE_STATUS_ERROR_FILE_NAME_SLASHES          (-20102L)
#define ARCHIVE_STATUS_ERROR_BUNDLE_CMD_FILE_NAME       (-20103L)   
#define ARCHIVE_STATUS_ERROR_BUNDLE_CMD_SKIP_OBJECT     (-20104L)   
#define ARCHIVE_STATUS_ERROR_BUNDLE_CMD_ERROR           (-20105L)
#define ARCHIVE_STATUS_ERROR_OPEN_FILE                  (-20106L)
#define ARCHIVE_STATUS_ERROR_SAVE_CHUNK                 (-20107L)
#define ARCHIVE_STATUS_ERROR_CLOSE_FILE                 (-20108L)
#define ARCHIVE_STATUS_ERROR_BUNDLE_CMD_MAX_OBJECT      (-20109L)   
#define ARCHIVE_STATUS_ERROR_SECURITY_ALERT             (-20199L)


#define TAR_HDR_SIZE            512
#define MAX_SIGNATURE_SIZE      256
#define MAX_FILE_NAME_SIZE      128
#define MAX_SHA256_DIGEST_SIZE  65
#define MAX_BUNDLE_CMD_FILES    20


#define VERSION_STR_SIZE        14      /* sizeof "YYYYMMDDHHMMSS"    */
#define _SlOtaLibTrace(pargs) Report pargs


typedef enum
{
    OtaArchiveState_Idle = 0,
    OtaArchiveState_ParseHdr,
    OtaArchiveState_ParseCmdFile,
	OtaArchiveState_ParseCmdSignatureFile,
    OtaArchiveState_OpenFile,
    OtaArchiveState_SaveFile,
    OtaArchiveState_CompletePendingTesting,
    OtaArchiveState_ParsingFailed
} OtaArchiveState;

typedef struct	_OtaArchive_BundleFileInfo_t_
{
    uint8_t  FileNameBuf[MAX_FILE_NAME_SIZE];  
    uint8_t  CertificateFileNameBuf[MAX_FILE_NAME_SIZE];  
    uint8_t  SignatureBuf[MAX_SIGNATURE_SIZE];  
    uint32_t SignatureLen;
    uint8_t  Sha256Digest[MAX_SHA256_DIGEST_SIZE];
    uint16_t Sha256DigestLen;
    uint32_t Secured;
    uint32_t Bundle;
    uint8_t  SavedInFS;
} OtaArchive_BundleFileInfo_t;

typedef struct     _OtaArchive_BundleCmdTable_t_
{
    int16_t                     NumFiles;
    int16_t                     NumFilesSavedInFS;
    OtaArchive_BundleFileInfo_t BundleFileInfo[MAX_BUNDLE_CMD_FILES];
    uint8_t                     VerifiedSignature;
    uint16_t                    TotalParsedBytes;
} OtaArchive_BundleCmdTable_t;

typedef struct  _OtaArchive_TarObj_t_
{
    /* File info from TAR file header */
    uint8_t  FileNameBuf[MAX_FILE_NAME_SIZE];
    uint8_t *pFileName;
    uint32_t FileSize;
    uint16_t FileType;

    uint32_t ulToken;
    int32_t lFileHandle;
    uint32_t WriteFileOffset;
} OtaArchive_TarObj_t;

typedef struct _OtaArchive_VersionFile_t_ 
{
    char VersionFilename[VERSION_STR_SIZE+1];
} OtaArchive_VersionFile_t;


typedef struct	_OtaArchive_t_
{
    OtaArchiveState             State;              /* internal archive state machine state */
    int32_t                     TotalBytesReceived; /* Should be keeped over states */
    OtaArchive_TarObj_t         CurrTarObj;         /* Current file info from the TAR file itself */
    OtaArchive_BundleCmdTable_t BundleCmdTable;     /* Table of files info from "ota.cmd" */ 
    int32_t                     SavingStarted;      /* if 1 on error need rollback */
    OtaArchive_VersionFile_t    OtaVersionFile;     /* save version file to save on download done */
} OtaArchive_t;

extern long atol(const char *buffer);
extern int Report(const char *format, ...);

//****************************************************************************
//                      FUNCTION PROTOTYPES
//****************************************************************************

int16_t OtaArchive_Init(OtaArchive_t *pOtaArchive);

int16_t OtaArchive_Process(OtaArchive_t *pOtaArchive, uint8_t *pBuf, int16_t BufLen, int16_t *pProcessedBytes);

int16_t OtaArchive_Abort(OtaArchive_t *pOtaArchive);

int16_t OtaArchive_GetStatus(OtaArchive_t *pOtaArchive);

int16_t OtaArchive_Rollback(void);

int16_t OtaArchive_Commit(void);

int16_t OtaArchive_GetPendingCommit(void );

int16_t OtaArchive_CheckVersion(OtaArchive_t *pOtaArchive, uint8_t *pFileName);

int16_t OtaArchive_GetCurrentVersion(uint8_t *pVersionBuf);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* _OTA_ARCHIVE_H__ */
