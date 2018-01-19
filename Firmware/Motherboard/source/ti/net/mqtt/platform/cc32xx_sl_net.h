/*
 *   Copyright (C) 2016 Texas Instruments Incorporated
 *
 *   All rights reserved. Property of Texas Instruments Incorporated.
 *   Restricted rights to use, duplicate or disclose this code are
 *   granted through contract.
 *
 *   The program may not be used without the written permission of
 *   Texas Instruments Incorporated or against the terms and conditions
 *   stipulated in the agreement under which this program has been supplied,
 *   and under no circumstances can it be used with non-TI connectivity device.
 *   
 */

/*
  Network Services for General Purpose Linux environment
*/

#ifndef __CC31XX_SL_NET_H__
#define __CC31XX_SL_NET_H__

//*****************************************************************************
// includes
//*****************************************************************************
#include <ti/drivers/net/wifi/simplelink.h>
#include <ti/net/mqtt/client/client_core.h>         /* conn options */

//*****************************************************************************
// defines
//*****************************************************************************

// MACRO to include receive time out feature
#define SOC_RCV_TIMEOUT_OPT     1


//*****************************************************************************
// typedefs
//*****************************************************************************


//*****************************************************************************
// function prototypes
//*****************************************************************************

int32_t commOpen(uint32_t nwconnOpts, const char *serverAddr, uint16_t portNumber,
                const MQTT_SecureConn_t *nwSecurity);
int32_t tcpSend(int32_t comm, const uint8_t *buf, uint32_t len, void *ctx);
int32_t tcpRecv(int32_t comm, uint8_t *buf, uint32_t len, uint32_t waitSecs, bool *timedOut,
              void *ctx);
int32_t commClose(int32_t comm);
uint32_t rtcSecs(void);

/*-----------------functions added for server -----------------------------*/

int32_t tcpListen(uint32_t nwconnInfo,  uint16_t portNumber,
                const MQTT_SecureConn_t *nwSecurity);

int32_t tcpSelect(int32_t *recvCvec, int32_t *sendCvec, int32_t *rsvdCvec,
                uint32_t waitSecs);


int32_t tcpAccept(int32_t listenHnd, uint8_t *clientIP,
                uint32_t *ipLen);

/*----------------- adding functions for udp functionalities -------------------*/

/** Send a UDP packet 
    
    @param[in] comm communication entity handle; socket handle in this case
    @param[in] buf buf to be sent in the udp packet
    @param[in] len length of the buffer buf
    @param[in] destPort destination port number
    @param[in] destIP ip address of the destination in dot notation, interpreted as a string;
                Only IPV4 is supported currently.
    @param[in] ipLen length of string destIP; currently not used
    @return number of bytes sent or error returned by sl_SendTo call
*/
int32_t sendTo(int32_t comm, const uint8_t *buf, uint32_t len, uint16_t destPort, const uint8_t *destIP, uint32_t ipLen);

/** Receive a UDP packet
    
    @param[in] comm communication entity handle; socket handle in this case
    @param[out] buf into which received UDP packet is written
    @param[in] maximum len length of the buffer buf
    @param[out] fromPort port number of UDP packet source
    @param[out] fromIP ip address of the UDP packet source. 
                The ip address is to be interpreted as a uint32_t number in network byte ordering
                Only IPV4 is supported currently.
    @param[out] ipLen length of string fromIP; 
               currently always populated with 4 as the address is a IPV4 address
    @return number of bytes received or error returned by sl_RecvFrom call
*/
int32_t recvFrom(int32_t comm, uint8_t *buf, uint32_t len, uint16_t *fromPort, uint8_t *fromIP, uint32_t *ipLen);

#endif
