/*
 * OtaArchive.h - Archive file parser header file
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

typedef enum
{
    ARCHIVE_STATE_IDLE = 0,
    ARCHIVE_STATE_PARSE_HDR,
    ARCHIVE_STATE_PARSE_CMD_FILE,
    ARCHIVE_STATE_PARSE_CMD_SIGNATURE_FILE,
    ARCHIVE_STATE_OPEN_FILE,
    ARCHIVE_STATE_SAVE_FILE,
    ARCHIVE_STATE_COMPLETE_PENDING_TESTING,
    ARCHIVE_STATE_PARSING_FAILED
} OtaArchiveState_e;

#define TAR_HDR_SIZE            512
#define MAX_SIGNATURE_SIZE      256
#define MAX_FILE_NAME_SIZE      128
#define MAX_SHA256_DIGEST_SIZE  65
#define MAX_BUNDLE_CMD_FILES    8

#ifdef SL_OTA_ARCHIVE_STANDALONE
#define VERSION_STR_SIZE        14      /* sizeof "YYYYMMDDHHMMSS"    */
extern int ltoa(long val, char *buffer);
extern int Report(const char *format, ...);
#define _SlOtaLibTrace(pargs) Report pargs
#endif

typedef struct  
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

typedef struct  
{
    int16_t                     NumFiles;
    int16_t                     NumFilesSavedInFS;
    OtaArchive_BundleFileInfo_t BundleFileInfo[MAX_BUNDLE_CMD_FILES];
    uint8_t                     VerifiedSignature;
    uint16_t                    TotalParsedBytes;
} OtaArchive_BundleCmdTable_t;

typedef struct
{
    /* File info from TAR file header */
	uint8_t  FileNameBuf[MAX_FILE_NAME_SIZE];
	uint8_t *pFileName;
	uint32_t FileSize;
	int16_t  FileType;

    uint32_t ulToken;
    int32_t  lFileHandle;
    uint32_t WriteFileOffset;
} TarObj_t;

typedef struct 
{
    char VersionFilename[VERSION_STR_SIZE+1];
} OtaVersionFile_t;

typedef struct
{
    OtaArchiveState_e           State;              /* internal archive state machine state */
    int32_t                     TotalBytesReceived; /* Should be keeped over states */
    TarObj_t                    CurrTarObj;         /* Current file info from the TAR file itself */
    OtaArchive_BundleCmdTable_t BundleCmdTable;     /* Table of files info from "ota.cmd" */
    int32_t                     SavingStarted;      /* if 1 on error need rollback */
    OtaVersionFile_t            OtaVersionFile;     /* save version file to save on download done */
} OtaArchive_t;

/*
  get a chunk of the the tar file and process that
*/
int16_t OtaArchive_init(OtaArchive_t *pOtaArchive);
int16_t OtaArchive_process(OtaArchive_t *pOtaArchive, uint8_t *pBuf, int16_t BufLen, int16_t *pProcessedBytes);
int16_t OtaArchive_abort(OtaArchive_t *pOtaArchive);
int16_t OtaArchive_getStatus(OtaArchive_t *pOtaArchive);
int16_t OtaArchive_rollback(void);
int16_t OtaArchive_commit(void);
int16_t OtaArchive_getPendingCommit(void);
int16_t OtaArchive_checkVersion(OtaArchive_t *pOtaArchive, uint8_t *pFileName);
int16_t OtaArchive_getCurrentVersion(uint8_t *pVersionBuf);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* _OTA_ARCHIVE_H__ */
