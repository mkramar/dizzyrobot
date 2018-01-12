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

//*****************************************************************************
//
//! \addtogroup out_of_box
//! @{
//
//*****************************************************************************

/* standard includes */
#include <stdlib.h>
#include <string.h>

/* POSIX Header files */
#ifdef USE_FREERTOS
#include <sys/signal.h>
#include <os/freertos/posix/time.h>
#endif

/* TI-DRIVERS Header files */
#include <Board.h>
#include <uart_term.h>

/* Example/Board Header files */
#include "ota_task.h"
#include "link_local_task.h"
#include "out_of_box.h"


#define OTA_REPORT_SERVER_PORT       (5432)
#define OTA_REPORT_TIMEOUT           (10)        /* in mSec */
#define OTA_NB_TIMEOUT               (20)    /* in mSec */
#define OTA_BLOCKED_TIMEOUT          (20)        /* in seconds */
#define OTA_NUM_OF_ACCEPT_TRIALS     (1000/OTA_NB_TIMEOUT * OTA_BLOCKED_TIMEOUT)
#define OTA_NUM_OF_MAILBOX_TRIALS    (1000/OTA_REPORT_TIMEOUT * OTA_BLOCKED_TIMEOUT)

#define OTA_PROGRESS_BAR_STR_LEN     (4)
#define HTTP_HEADER_METADATA_STR_LEN (105)

extern int snprintf(char *_string, size_t _n, const char *_format, ...);

/****************************************************************************
                      GLOBAL VARIABLES
****************************************************************************/

uint8_t gPayloadData[32];    // data buffer used to send messages reporting on ota progress
uint8_t gMetadataResponse[512];


//****************************************************************************
//                            MAIN FUNCTION
//****************************************************************************

//*****************************************************************************
//
//! \brief This task handles ota status reports to client
//!
//! \param[in]  None
//!
//! \return None
//!
//****************************************************************************
void * otaTask(void *pvParameter)
{
    uint8_t                    otaProgressBar, mailboxItems;
    uint16_t    acceptTrials, recvTrials, mailboxTrials;

    int16_t        sock;
    int16_t        newsock = -1;
    int32_t        status;
    int32_t        nonBlocking = 0;
    int16_t        addrSize;
    uint32_t     contentLen;

    int32_t     msgqRetVal;
    struct timespec     ts;
    mq_attr     attr;

    SlSockAddrIn_t  sAddr;
    SlSockAddrIn_t  sLocalAddr;

    /* initializes mailbox for ota report server */
    attr.mq_maxmsg = 50;         /* queue size */
    attr.mq_msgsize = sizeof( uint8_t );      /* Size of message */
    LinkLocal_ControlBlock.reportServerMQueue = mq_open("report server msg q", O_CREAT, 0, &attr);
    if(LinkLocal_ControlBlock.reportServerMQueue == NULL)
    {
        UART_PRINT("[Link local task] could not create msg queue\n\r");
        while (1);
    }

    /* waits for valid local connection - via provisioning task  */
    sem_wait(&Provisioning_ControlBlock.provisioningConnDoneToOtaServerSignal);

ota_task_restart:
    /* filling the TCP server socket address */
    sLocalAddr.sin_family = SL_AF_INET;
    sLocalAddr.sin_port = sl_Htons((uint16_t)OTA_REPORT_SERVER_PORT);
    sLocalAddr.sin_addr.s_addr = SL_INADDR_ANY;

    addrSize = sizeof(SlSockAddrIn_t);

    sock = sl_Socket(sLocalAddr.sin_family, SL_SOCK_STREAM, 0);
    if(sock < 0)
    {
        UART_PRINT("[ota report task] Error openning socket, %d \n\r", sock);
        goto ota_task_restart;
    }

    status = sl_Bind(sock, (SlSockAddr_t *)&sLocalAddr, addrSize);
    if(status < 0)
    {
        UART_PRINT("[ota report task] Error binding socket, error %d \n\r", status);
        sl_Close(sock);
        goto ota_task_restart;
    }

    status = sl_Listen(sock, 0);
    if(status < 0)
    {
        UART_PRINT("[ota report task] Error listening on socket, error %d \n\r", status);
        sl_Close(sock);
        goto ota_task_restart;
    }

    nonBlocking = 1;
    status = sl_SetSockOpt(sock, SL_SOL_SOCKET, SL_SO_NONBLOCKING, &nonBlocking, sizeof(nonBlocking));
    if( status < 0 )
    {
        UART_PRINT("[ota report task] Error setting socket as non-blocking, error %d \n\r", status);
        sl_Close(sock);
        goto ota_task_restart;
    }

    while (1)
    {
        otaProgressBar = 0;
        acceptTrials = 0;
        recvTrials = 0;
        mailboxTrials = 0;

        /* waits for ota request from client before openning the ota response server */
        sem_wait(&LinkLocal_ControlBlock.otaReportServerStartSignal);

        while ((otaProgressBar != 100) && (otaProgressBar != 0xFF))
        {
ota_task_accept_start:
            newsock = SL_ERROR_BSD_EAGAIN;

            /* wait for client */
            while(newsock < 0)
            {
                newsock = sl_Accept(sock, ( struct SlSockAddr_t *)&sAddr, (SlSocklen_t *)&addrSize);
                if( (newsock == SL_ERROR_BSD_EAGAIN) && nonBlocking)
                {
                    usleep(OTA_NB_TIMEOUT*1000);

                    /* increase accept counter to protect from cases were connection cannot be created so OTA task would not block the procedure */
                    acceptTrials++;
                    if (acceptTrials > OTA_NUM_OF_ACCEPT_TRIALS)
                    {
                        UART_PRINT("[ota report task] Error accepting client connection, aborting progress bar... \n\r");
                        acceptTrials = 0;

                        goto ota_task_end;
                    }
                }
                else if( newsock < 0 )
                {
                    UART_PRINT("[ota report task] Error accepting client connection, error %d \n\r", newsock);
                    if ((newsock == SL_RET_CODE_DEV_LOCKED) || (newsock == SL_API_ABORTED))    /* means client failed to connect and command to driver has aborted */
                                                                                            /* in this case, it is better to abort the report server and continue */
                                                                                            /* with file upload to server                                        */
                    {
                        goto ota_task_end;
                    }
                    else
                    {
                        goto ota_task_accept_start;
                    }
                }
                else        /* this case means the server accepted the incoming connection from client */
                {
                    acceptTrials = 0;
                }
            }

            /* receive some data from the peer client */
            while(1)
            {
                status = sl_Recv(newsock, gMetadataResponse, sizeof(gMetadataResponse), 0);
                if( (status == SL_ERROR_BSD_EAGAIN) && nonBlocking)
                {
                    usleep(OTA_NB_TIMEOUT*1000);

                /* increase recv counter to protect from cases were no message received from client  so OTA task would not block the procedure */
                recvTrials++;
                if (recvTrials > OTA_NUM_OF_ACCEPT_TRIALS)
                {
                    UART_PRINT("[ota report task] Error receiving message from client, aborting progress bar... \n\r");
                    sl_Close(newsock);
                    recvTrials = 0;

                    goto ota_task_end;
                }
                }
                else if(status < 0)
                {
                    sl_Close(newsock);
                    goto ota_task_accept_start;
                }
                else if (status == 0)
                {
                    INFO_PRINT("[ota report task] client closed connection \n\r");
                    sl_Close(newsock);
                    goto ota_task_accept_start;
                }
                else
                {
                    INFO_PRINT("[ota report task] received some data from client \n\r");
                    recvTrials = 0;

                    break;
                }
            }

            /* flush the mailbox since post may be faster than fetch */
            mailboxItems = 0;
            mailboxTrials = 0;
            while (mailboxItems == 0)
            {
                do
                {
                    clock_gettime(CLOCK_REALTIME, &ts);
                    ts.tv_nsec += (1000000 * OTA_REPORT_TIMEOUT);
                    ts.tv_sec += (ts.tv_nsec / 1000000000);
                    ts.tv_nsec = ts.tv_nsec % 1000000000;

                    msgqRetVal = mq_timedreceive(LinkLocal_ControlBlock.reportServerMQueue, (char *)&otaProgressBar, sizeof( uint8_t ), NULL, &ts);
                    if (msgqRetVal >= 0)
                    {
                        mailboxItems++;
                    }
                }
                while (msgqRetVal >= 0);

                /* increase mailbox counter to protect from cases were mailbox is stuck so OTA task would not block the procedure */
                mailboxTrials++;
                if (mailboxTrials > OTA_NUM_OF_MAILBOX_TRIALS)
                {
                    UART_PRINT("[ota report task] Error reading from mailbox, aborting progress bar... \n\r");
                    sl_Close(newsock);
                    mailboxTrials = 0;

                    goto ota_task_end;
                }
            }
 
            if (otaProgressBar == 0xFF)        /* 0xFF means ota procedure failed, abort to restart socket */
            {
                UART_PRINT("[ota report task] OTA progress failed, aborting... \n\r");
                /* prepare the http content */
                strcpy((char *)gPayloadData, "fail");
                contentLen = strlen((const char *)gPayloadData);
            }
            else
            {
                UART_PRINT("[ota report task] OTA progress %d%% \n\r", otaProgressBar);

                /* send ota progress to client */
                /* prepare the http content */
                snprintf((char *)gPayloadData, OTA_PROGRESS_BAR_STR_LEN, "%d", otaProgressBar);
                contentLen = strlen((const char *)gPayloadData);
            }
            /* send the http header metadata */
            /* http status */
            snprintf((char *)gMetadataResponse, HTTP_HEADER_METADATA_STR_LEN, "HTTP/1.0 200 OK\r\nContent-type: text/html\r\nAccess-Control-Allow-Origin: *\r\nContent-Length: %d\r\n\r\n", (int)contentLen);
            while (1)
            {
                status = sl_Send(newsock, gMetadataResponse, strlen((const char *)gMetadataResponse), 0);
                if( (status == SL_ERROR_BSD_EAGAIN) && nonBlocking)
                {
                    INFO_PRINT("[ota report task] pending metadata send \n\r");
                    usleep(OTA_NB_TIMEOUT*1000);
                    continue;
                }
                else if(status < 0)
                {
                    UART_PRINT("[ota report task] Error sending progress metadata to client, error %d \n\r", status);
                    sl_Close(newsock);
                    goto ota_task_accept_start;
                }
                else
                {
                    INFO_PRINT("[ota report task] sent metadata to client \n\r");
                    break;
                }
            }
            while (1)
            {
                status = sl_Send(newsock, gPayloadData, contentLen, 0);
                if( (status == SL_ERROR_BSD_EAGAIN) && nonBlocking)
                {
                    INFO_PRINT("[ota report task] pending report send \n\r");
                    usleep(OTA_NB_TIMEOUT*1000);
                    continue;
                }
                else if(status < 0)
                {
                    UART_PRINT("[ota report task] Error sending progress data to client, error %d \n\r", status);
                    sl_Close(newsock);
                    goto ota_task_accept_start;
                }
                else
                {
                    INFO_PRINT("[ota report task] sent payload to client \n\r");
                    break;
                }
            }

            /* close the sockets for next time */
            sl_Close(newsock);
        }

ota_task_end:

        /* signal back to link local task that report is done */
        sem_post(&LinkLocal_ControlBlock.otaReportServerStopSignal);
    }
}



