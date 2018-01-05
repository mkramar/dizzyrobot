/*
 * OtaHttpClient.h - Minimal Http client services tailored for OTA header file
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
#ifndef __OTA_HTTP_CLIENT_H__
#define __OTA_HTTP_CLIENT_H__

#ifdef    __cplusplus
extern "C" {
#endif

#define HTTP_MAX_RETRIES          2   /* Max retries to skip http headers */
#define HTTP_HEADER_STR           "HTTP/1.1 200"
#define HTTP_HEADER_MIN_SIZE      12     /* HTTP/x.x YYY */
#define HTTP_HEADER_OK            "200"  /* OK Code      */

#define SOCKET_SECURED            1
#define SOCKET_NON_SECURED        0
#define SOCKET_BLOCKING           0
#define SOCKET_NON_BLOCKING       1
#define SOCKET_PORT_DEFAULT       0
#define SOCKET_PORT_HTTP          80
#define SOCKET_PORT_HTTPS         443

#define MAX_EAGAIN_RETRIES        15

#define OTA_HTTP_CLIENT_STATUS_OK                       (0L)
#define OTA_HTTP_CLIENT_ERROR_CONNECT_GET_HOST_BY_NAME  (-20301L)
#define OTA_HTTP_CLIENT_ERROR_CONNECT_SL_SOCKET         (-20302L)
#define OTA_HTTP_CLIENT_ERROR_CONNECT_SL_SET_SOC_OPT    (-20303L)
#define OTA_HTTP_CLIENT_ERROR_CONNECT_SL_CONNECT        (-20304L)
#define OTA_HTTP_CLIENT_ERROR_DOUBLE_SLASH_NOT_FOUND    (-20305L)
#define OTA_HTTP_CLIENT_ERROR_END_SLASH_NOT_FOUND       (-20306L)
#define OTA_HTTP_CLIENT_ERROR_EMPTY_URL                 (-20307L)
#define OTA_HTTP_CLIENT_ERROR_RESP_HDR_SIZE             (-20308L)
#define OTA_HTTP_CLIENT_ERROR_RESP_HDR_END_NOT_FOUND    (-20309L)
#define OTA_HTTP_CLIENT_ERROR_RESP_STATUS_NOT_OK        (-20310L)
#define OTA_HTTP_CLIENT_ERROR_OFFSET_AND_SIZE           (-20311L)
#define OTA_HTTP_CLIENT_ERROR_RECV_MAX_EAGAIN_RETRIES   (-20312L)
#define OTA_HTTP_CLIENT_ERROR_RECV_LEN_0                (-20313L)

int16_t  HttpClient_Connect(uint8_t *ServerName, int32_t IpAddr, int32_t Port, int32_t Secured, int32_t NonBlocking);
int16_t  HttpClient_CloseConnection(int16_t SockId);
int16_t  HttpClient_Recv(int16_t SockId, void *pBuf, int16_t Len, int16_t Flags, int16_t MaxEagain);
int16_t  HttpClient_RecvAppend(int16_t SockId, uint8_t *pRecvBuf, int16_t RecvBufSize, int16_t RecvLen, int16_t RecvOffset);
int16_t HttpClient_RecvSkipHdr(int16_t SockId, uint8_t *pRespBuf, int16_t RespBufSize, uint32_t *contentLen);
int16_t  HttpClient_SendReq(int16_t SockId, uint8_t *pHttpReqBuf, uint8_t *pReqMethod, uint8_t *pServerName, uint8_t *pUriPrefix, uint8_t *pUriVal, uint8_t *pHdrName, uint8_t *pHdrVal);
uint8_t  *HttpClient_ParseUrl(uint8_t *pUrlName, uint8_t *PServerName, int16_t *Status);

#ifdef  __cplusplus
}
#endif /* __cplusplus */

#endif /* __OTA_HTTP_CLIENT_H__ */
