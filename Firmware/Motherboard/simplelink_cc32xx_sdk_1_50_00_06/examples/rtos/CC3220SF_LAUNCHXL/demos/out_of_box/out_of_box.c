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

/*****************************************************************************
 
 Application Name     -   Getting started with OUT_OF_BOX
 Application Overview -	This application demonstrates the Out of Box Experience
 							with CC32xx LaunchPad.
 							It highlights the following features:
 							1. easy and straight-forward provisioning methods
 							2. easy access to CC32xx Using internal HTTP server
 							3. attractive Demos showing LAN communication
 
 Application Details  - Refer to 'Out of box' README.html
 
*****************************************************************************/

//****************************************************************************
//
//! \addtogroup out_of_box
//! @{
//
//****************************************************************************

/* Example/Board Header files */
#include "out_of_box.h"
#include "provisioning_task.h"
#include "link_local_task.h"
#include "ota_task.h"

/* TI-DRIVERS Header files */
#include <ti/drivers/net/wifi/simplelink.h>
#include <ti/drivers/SPI.h>
#include <Board.h>

/* driverlib Header files */
#include <ti/devices/cc32xx/inc/hw_types.h>
#include <ti/devices/cc32xx/inc/hw_memmap.h>
#include <ti/devices/cc32xx/driverlib/rom.h>
#include <ti/devices/cc32xx/driverlib/rom_map.h>
#include <ti/devices/cc32xx/driverlib/prcm.h>

/* POSIX Header files */
#include <mqueue.h>

/****************************************************************************
                      LOCAL FUNCTION PROTOTYPES
****************************************************************************/
//*****************************************************************************
//
//! Application Boarders display on UART
//!
//! \param  ch - Character to be displayed , n - number of time to display
//!
//! \return none
//!
//*****************************************************************************
void printBorder(char ch, int n);
//*****************************************************************************
//
//! Application startup display on UART
//!
//! \param  none
//!
//! \return none
//!
//*****************************************************************************
int32_t DisplayBanner(char * AppName, char * AppVer);

//*****************************************************************************
//
//! This function initializes the application variables
//!
//! \param    None
//!
//! \return None
//!
//*****************************************************************************
static void InitializeAppVariables(void);

//*****************************************************************************
//
//! This  function clears and enables a GPIO pin interrupt flag
//!
//! \param    index - GPIO index
//!
//! \return None
//!
//*****************************************************************************
static void GPIO_clearAndEnable(uint8_t index);

/****************************************************************************
                      GLOBAL VARIABLES
****************************************************************************/
pthread_t gProvisioningThread = (pthread_t)NULL;
pthread_t gLinklocalThread = (pthread_t)NULL;
pthread_t gControlThread = (pthread_t)NULL;
pthread_t gOtaThread = (pthread_t)NULL;
pthread_t gSpawnThread = (pthread_t)NULL;
/* message queue for control messages */
mqd_t controlMQueue;

OutOfBox_CB	OutOfBox_ControlBlock;


/*****************************************************************************
                  Callback Functions
*****************************************************************************/

//*****************************************************************************
//
//! The Function Handles WLAN Events
//!
//! \param[in]  pWlanEvent - Pointer to WLAN Event Info
//!
//! \return None
//!
//*****************************************************************************
void SimpleLinkWlanEventHandler(SlWlanEvent_t *pWlanEvent)
{
    switch(pWlanEvent->Id)
    {
        case SL_WLAN_EVENT_CONNECT:
        {
            SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Connection);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6gAcquired);

            /*
             Information about the connected AP (like name, MAC etc) will be
             available in 'slWlanConnectAsyncResponse_t'-Applications
             can use it if required:

              slWlanConnectAsyncResponse_t *pEventData = NULL;
              pEventData = &pWlanEvent->EventData.STAandP2PModeWlanConnected;
            */

            /* Copy new connection SSID and BSSID to global parameters */
            memcpy(OutOfBox_ControlBlock.connectionSSID,
                    pWlanEvent->Data.Connect.SsidName,
                    pWlanEvent->Data.Connect.SsidLen);

            OutOfBox_ControlBlock.ssidLen = pWlanEvent->Data.Connect.SsidLen;

            memcpy(OutOfBox_ControlBlock.connectionBSSID,
                    pWlanEvent->Data.Connect.Bssid,
                    SL_WLAN_BSSID_LENGTH);

            UART_PRINT("[WLAN EVENT] STA Connected to the AP: %s ,"
                        "BSSID: %x:%x:%x:%x:%x:%x\n\r",
                            OutOfBox_ControlBlock.connectionSSID,
                            OutOfBox_ControlBlock.connectionBSSID[0], OutOfBox_ControlBlock.connectionBSSID[1],
                            OutOfBox_ControlBlock.connectionBSSID[2], OutOfBox_ControlBlock.connectionBSSID[3],
                            OutOfBox_ControlBlock.connectionBSSID[4], OutOfBox_ControlBlock.connectionBSSID[5]);

            sem_post(&Provisioning_ControlBlock.connectionAsyncEvent);
        }
        break;

        case SL_WLAN_EVENT_DISCONNECT:
        {
            SlWlanEventDisconnect_t*    pEventData = NULL;

            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Connection);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired);
            CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6gAcquired);

            pEventData = &pWlanEvent->Data.Disconnect;

            /* 	If the user has initiated 'Disconnect' request,
             	'reason_code' is SL_WLAN_DISCONNECT_USER_INITIATED.
             */
            if(SL_WLAN_DISCONNECT_USER_INITIATED == pEventData->ReasonCode)
            {
                UART_PRINT("[WLAN EVENT]Device disconnected from the "
                            "AP: %s, BSSID: %x:%x:%x:%x:%x:%x "
                            "on application's request \n\r",
                            OutOfBox_ControlBlock.connectionSSID,
                            OutOfBox_ControlBlock.connectionBSSID[0], OutOfBox_ControlBlock.connectionBSSID[1],
                            OutOfBox_ControlBlock.connectionBSSID[2], OutOfBox_ControlBlock.connectionBSSID[3],
                            OutOfBox_ControlBlock.connectionBSSID[4], OutOfBox_ControlBlock.connectionBSSID[5]);
            }
            else
            {
                UART_PRINT("[WLAN ERROR]Device disconnected from the AP AP: %s,"
                            "BSSID: %x:%x:%x:%x:%x:%x on an ERROR..!! \n\r",
                            OutOfBox_ControlBlock.connectionSSID,
                            OutOfBox_ControlBlock.connectionBSSID[0], OutOfBox_ControlBlock.connectionBSSID[1],
                            OutOfBox_ControlBlock.connectionBSSID[2], OutOfBox_ControlBlock.connectionBSSID[3],
                            OutOfBox_ControlBlock.connectionBSSID[4], OutOfBox_ControlBlock.connectionBSSID[5]);
            }
            memset(OutOfBox_ControlBlock.connectionSSID, 0, sizeof(OutOfBox_ControlBlock.connectionSSID));
            memset(OutOfBox_ControlBlock.connectionBSSID, 0, sizeof(OutOfBox_ControlBlock.connectionBSSID));
        }
        break;

	 case SL_WLAN_EVENT_STA_ADDED:
        {
        	UART_PRINT("[WLAN EVENT] External Station connected to SimpleLink AP\r\n");

        	UART_PRINT("[WLAN EVENT] STA BSSID: %02x:%02x:%02x:%02x:%02x:%02x\r\n",
        						   pWlanEvent->Data.STAAdded.Mac[0],
        						   pWlanEvent->Data.STAAdded.Mac[1],
        						   pWlanEvent->Data.STAAdded.Mac[2],
        						   pWlanEvent->Data.STAAdded.Mac[3],
        						   pWlanEvent->Data.STAAdded.Mac[4],
        						   pWlanEvent->Data.STAAdded.Mac[5]);

        }
        break;

        case SL_WLAN_EVENT_STA_REMOVED:
        {
        	UART_PRINT("[WLAN EVENT] External Station disconnected from SimpleLink AP\r\n");
        }
        break;

        case SL_WLAN_EVENT_PROVISIONING_PROFILE_ADDED:
        {
            UART_PRINT("[WLAN EVENT] Profile Added\r\n");
        }
        break;

		case SL_WLAN_EVENT_PROVISIONING_STATUS:
		{
            uint16_t status = pWlanEvent->Data.ProvisioningStatus.ProvisioningStatus;
            switch(status)
			{
				case SL_WLAN_PROVISIONING_GENERAL_ERROR:
				case SL_WLAN_PROVISIONING_ERROR_ABORT:
				{
					UART_PRINT("[WLAN EVENT] Provisioning Error status=%d\r\n",status);
					SignalProvisioningEvent(PrvnEvent_Error);
				}
				break;
				case SL_WLAN_PROVISIONING_ERROR_ABORT_INVALID_PARAM:
				case SL_WLAN_PROVISIONING_ERROR_ABORT_HTTP_SERVER_DISABLED:
				case SL_WLAN_PROVISIONING_ERROR_ABORT_PROFILE_LIST_FULL:
				{
					UART_PRINT("[WLAN EVENT] Provisioning Error status=%d\r\n",status);
					SignalProvisioningEvent(PrvnEvent_StartFailed);
				}
				break;
				case SL_WLAN_PROVISIONING_ERROR_ABORT_PROVISIONING_ALREADY_STARTED:
                {
                	UART_PRINT("[WLAN EVENT] Provisioning already started");
                }
				break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_STATUS_FAIL_NETWORK_NOT_FOUND:
                {
                    UART_PRINT("[WLAN EVENT] Confirmation fail: network not found\r\n");
                    SignalProvisioningEvent(PrvnEvent_ConfirmationFailed);
                }
                break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_STATUS_FAIL_CONNECTION_FAILED:
                {
                    UART_PRINT("[WLAN EVENT] Confirmation fail: Connection failed\r\n");
                    SignalProvisioningEvent(PrvnEvent_ConfirmationFailed);
                }
                break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_STATUS_CONNECTION_SUCCESS_IP_NOT_ACQUIRED:
                {
                    UART_PRINT("[WLAN EVENT] Confirmation fail: IP address not acquired\r\n");
                    SignalProvisioningEvent(PrvnEvent_ConfirmationFailed);
                }
                break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_STATUS_SUCCESS_FEEDBACK_FAILED:
                {
                    UART_PRINT("[WLAN EVENT] Connection Success (feedback to Smartphone app failed)\r\n");
                    SignalProvisioningEvent(PrvnEvent_ConfirmationFailed);
                }
                break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_STATUS_SUCCESS:
                {
                    UART_PRINT("[WLAN EVENT] Confirmation Success!\r\n");
                    SignalProvisioningEvent(PrvnEvent_ConfirmationSuccess);
                }
                break;

                case SL_WLAN_PROVISIONING_AUTO_STARTED:
                {
                    UART_PRINT("[WLAN EVENT] Auto-Provisioning Started\r\n");
                    /* stop auto provisioning - may trigger in case of returning to default */
                    SignalProvisioningEvent(PrvnEvent_Stopped);
                }
                break;

                case SL_WLAN_PROVISIONING_STOPPED:
                {
					UART_PRINT("[WLAN EVENT] Provisioning stopped\r\n");
					if(ROLE_STA == pWlanEvent->Data.ProvisioningStatus.Role)
					{
						UART_PRINT(" [WLAN EVENT] - WLAN Connection Status:%d\r\n",pWlanEvent->Data.ProvisioningStatus.WlanStatus);

						if(SL_WLAN_STATUS_CONNECTED == pWlanEvent->Data.ProvisioningStatus.WlanStatus)
						{
							UART_PRINT(" [WLAN EVENT] - Connected to SSID:%s\r\n",pWlanEvent->Data.ProvisioningStatus.Ssid);

							memcpy (OutOfBox_ControlBlock.connectionSSID, pWlanEvent->Data.ProvisioningStatus.Ssid, pWlanEvent->Data.ProvisioningStatus.Ssidlen);
							OutOfBox_ControlBlock.ssidLen = pWlanEvent->Data.ProvisioningStatus.Ssidlen;

							/* Provisioning is stopped by the device and provisioning is done successfully */
							SignalProvisioningEvent(PrvnEvent_Stopped);

							break;
						}
						else
						{
							CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Connection);
							CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);
							CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired);
							CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6gAcquired);

							/* Provisioning is stopped by the device and provisioning is not done yet, still need to connect to AP */
							SignalProvisioningEvent(PrvnEvent_WaitForConn);

							break;
						}
					}
                }

                SignalProvisioningEvent(PrvnEvent_Stopped);

                break;

                case SL_WLAN_PROVISIONING_SMART_CONFIG_SYNCED:
                {
                    UART_PRINT("[WLAN EVENT] Smart Config Synced!\r\n");
                }
                break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_WLAN_CONNECT:
				{
					SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Connection);
					CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);
					CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired);
					CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6gAcquired);

					UART_PRINT("[WLAN EVENT] Connection to AP succeeded\r\n");
				}
				break;

                case SL_WLAN_PROVISIONING_CONFIRMATION_IP_ACQUIRED:
				{
					SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);

					UART_PRINT("[WLAN EVENT] IP address acquired\r\n");
				}
				break;

                case SL_WLAN_PROVISIONING_SMART_CONFIG_SYNC_TIMEOUT:
                {
					UART_PRINT("[WLAN EVENT] Smart Config Sync timeout\r\n");
				}
				break;

                default:
                {
                    UART_PRINT("[WLAN EVENT] Unknown Provisioning Status: %d\r\n",pWlanEvent->Data.ProvisioningStatus.ProvisioningStatus);
                }
                break;
            }
        }
        break;

        default:
        {
            UART_PRINT("[WLAN EVENT] Unexpected event [0x%x]\n\r",
                                                            pWlanEvent->Id);

            SignalProvisioningEvent(PrvnEvent_Error);
        }
        break;
    }
}

//*****************************************************************************
//
//! The Function Handles the Fatal errors
//!
//! \param[in]  slFatalErrorEvent - Pointer to Fatal Error Event info
//!
//! \return None
//!
//*****************************************************************************
void SimpleLinkFatalErrorEventHandler(SlDeviceFatal_t *slFatalErrorEvent)
{
	uint8_t msg = 4;
	int32_t msgqRetVal;
	
    switch (slFatalErrorEvent->Id)
    {
        case SL_DEVICE_EVENT_FATAL_DEVICE_ABORT:
        {
            UART_PRINT("[ERROR] - FATAL ERROR: Abort NWP event detected: "
                        "AbortType=%d, AbortData=0x%x\n\r",
                        slFatalErrorEvent->Data.DeviceAssert.Code,
                        slFatalErrorEvent->Data.DeviceAssert.Value);
        }
        break;

        case SL_DEVICE_EVENT_FATAL_DRIVER_ABORT:
        {
            UART_PRINT("[ERROR] - FATAL ERROR: Driver Abort detected. \n\r");
        }
        break;

        case SL_DEVICE_EVENT_FATAL_NO_CMD_ACK:
        {
            UART_PRINT("[ERROR] - FATAL ERROR: No Cmd Ack detected "
                       "[cmd opcode = 0x%x] \n\r",
                       slFatalErrorEvent->Data.NoCmdAck.Code);
        }
        break;

        case SL_DEVICE_EVENT_FATAL_SYNC_LOSS:
        {
            UART_PRINT("[ERROR] - FATAL ERROR: Sync loss detected n\r");
        }
        break;

        case SL_DEVICE_EVENT_FATAL_CMD_TIMEOUT:
        {
            UART_PRINT("[ERROR] - FATAL ERROR: Async event timeout detected "
                       "[event opcode =0x%x]  \n\r",
                       slFatalErrorEvent->Data.CmdTimeout.Code);
        }
        break;

		default:
			UART_PRINT("[ERROR] - FATAL ERROR: Unspecified error detected \n\r");
			break;
    }

	msgqRetVal = mq_send(controlMQueue, (char *)&msg, 1, 0);
	if(msgqRetVal < 0)
	{
		UART_PRINT("[Control task] could not send element to msg queue\n\r");
		while (1);
	}
}

//*****************************************************************************
//
//! This function handles network events such as IP acquisition, IP
//!           leased, IP released etc.
//!
//! \param[in]  pNetAppEvent - Pointer to NetApp Event Info
//!
//! \return None
//!
//*****************************************************************************
void SimpleLinkNetAppEventHandler(SlNetAppEvent_t *pNetAppEvent)
{
	SlNetAppEventData_u *pNetAppEventData = NULL;

	if (NULL == pNetAppEvent)
	{
		return;
	}

	pNetAppEventData = &pNetAppEvent->Data;

	 switch(pNetAppEvent->Id)
	{
		case SL_NETAPP_EVENT_IPV4_ACQUIRED:
		{
			SlIpV4AcquiredAsync_t   *pEventData = NULL;

			SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpAcquired);

			/* Ip Acquired Event Data */
			pEventData = &pNetAppEvent->Data.IpAcquiredV4;

			/* Gateway IP address */
			OutOfBox_ControlBlock.gatewayIP = pEventData->Gateway;

			UART_PRINT("[NETAPP EVENT] IP Acquired: IP=%d.%d.%d.%d , "
						"Gateway=%d.%d.%d.%d\n\r",
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Ip,3),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Ip,2),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Ip,1),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Ip,0),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Gateway,3),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Gateway,2),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Gateway,1),
						SL_IPV4_BYTE(pNetAppEvent->Data.IpAcquiredV4.Gateway,0));

			sem_post(&Provisioning_ControlBlock.connectionAsyncEvent);
		}
		break;

		case SL_NETAPP_EVENT_IPV6_ACQUIRED:
		{
			if(!GET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired))
			{
				SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6lAcquired);
				UART_PRINT("[NETAPP EVENT] Local IPv6 Acquired\n\r");
			}
			else
			{
				SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_Ipv6gAcquired);
				UART_PRINT("[NETAPP EVENT] Global IPv6 Acquired\n\r");
			}

			sem_post(&Provisioning_ControlBlock.connectionAsyncEvent);
		}
		break;

		case SL_NETAPP_EVENT_DHCPV4_LEASED:
		{
			SET_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpLeased);

			UART_PRINT("[NETAPP EVENT] IPv4 leased %d.%d.%d.%d for device %02x:%02x:%02x:%02x:%02x:%02x\n\r",\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpLeased.IpAddress,3),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpLeased.IpAddress,2),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpLeased.IpAddress,1),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpLeased.IpAddress,0),\
				pNetAppEventData->IpLeased.Mac[0],\
				pNetAppEventData->IpLeased.Mac[1],\
				pNetAppEventData->IpLeased.Mac[2],\
				pNetAppEventData->IpLeased.Mac[3],\
				pNetAppEventData->IpLeased.Mac[4],\
				pNetAppEventData->IpLeased.Mac[5]);

		}
		break;

        case SL_NETAPP_EVENT_DHCPV4_RELEASED:
        {
        	CLR_STATUS_BIT(OutOfBox_ControlBlock.status, AppStatusBits_IpLeased);

        	UART_PRINT("[NETAPP EVENT] IPv4 released %d.%d.%d.%d for device %02x:%02x:%02x:%02x:%02x:%02x\n\r",\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpReleased.IpAddress,3),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpReleased.IpAddress,2),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpReleased.IpAddress,1),\
				(uint8_t)SL_IPV4_BYTE(pNetAppEventData->IpReleased.IpAddress,0),\
				pNetAppEventData->IpReleased.Mac[0],\
				pNetAppEventData->IpReleased.Mac[1],\
				pNetAppEventData->IpReleased.Mac[2],\
				pNetAppEventData->IpReleased.Mac[3],\
				pNetAppEventData->IpReleased.Mac[4],\
				pNetAppEventData->IpReleased.Mac[5]);

			UART_PRINT("Reason: ");
			switch(pNetAppEventData->IpReleased.Reason)
			{
				case SL_IP_LEASE_PEER_RELEASE: UART_PRINT("Peer released\n\r");
				break;

				case SL_IP_LEASE_PEER_DECLINE: UART_PRINT("Peer declined\n\r");
				break;

				case SL_IP_LEASE_EXPIRED: UART_PRINT("Lease expired\n\r");
				break;
			}
        }
        break;

        case SL_NETAPP_EVENT_DHCP_IPV4_ACQUIRE_TIMEOUT:
        {
            UART_PRINT("[NETAPP EVENT] DHCP IPv4 Acquire timeout\n\r");
        }
        break;

		default:
		{
			UART_PRINT("[NETAPP EVENT] Unexpected event [0x%x] \n\r",
					   pNetAppEvent->Id);
		}
		break;
	}
}


//*****************************************************************************
//
//! This function handles HTTP server events
//!
//! \param[in]  pServerEvent    - Contains the relevant event information
//! \param[in]  pServerResponse - Should be filled by the user with the
//!                               relevant response information
//!
//! \return None
//!
//****************************************************************************
void SimpleLinkHttpServerEventHandler(SlNetAppHttpServerEvent_t *pHttpEvent,
                                SlNetAppHttpServerResponse_t *pHttpResponse)
{
    /* Unused in this application */
	UART_PRINT("[HTTP SERVER EVENT] Unexpected HTTP server event \n\r");
}

//*****************************************************************************
//
//! This function handles General Events
//!
//! \param[in]  pDevEvent - Pointer to General Event Info
//!
//! \return None
//!
//*****************************************************************************
void SimpleLinkGeneralEventHandler(SlDeviceEvent_t *pDevEvent)
{
	uint8_t msg = 4;
	int32_t msgqRetVal;

    /*
        Most of the general errors are not FATAL are are to be handled
        appropriately by the application.
    */
    if(NULL == pDevEvent) return;
    switch(pDevEvent->Id)
    {
        case SL_DEVICE_EVENT_RESET_REQUEST:
        {
        	UART_PRINT("[GENERAL EVENT] Reset Request Event\r\n");
        }
        break;

        default:
        {
        	UART_PRINT("[GENERAL EVENT] - ID=[%d] Sender=[%d]\n\n",
                                                pDevEvent->Data.Error.Code,
                                                pDevEvent->Data.Error.Source);

        	msgqRetVal = mq_send(controlMQueue, (char *)&msg, 1, 0);
			if(msgqRetVal < 0)
			{
					UART_PRINT("[Control task] could not send element to msg queue\n\r");
					while (1);
			}
		}
		break;
	}
}


//*****************************************************************************
//
//! This function handles socket events indication
//!
//! \param[in]  pSock - Pointer to Socket Event Info
//!
//! \return None
//!
//*****************************************************************************
void SimpleLinkSockEventHandler(SlSockEvent_t *pSock)
{
	if(SL_SOCKET_ASYNC_EVENT == pSock->Event)
	{
		UART_PRINT("[SOCK ERROR] an event received on socket %d\r\n",pSock->SocketAsyncEvent.SockAsyncData.Sd);
		switch(pSock->SocketAsyncEvent.SockAsyncData.Type)
		{
		case SL_SSL_NOTIFICATION_CONNECTED_SECURED:
		UART_PRINT("[SOCK ERROR] SSL handshake done");
			break;
		case SL_SSL_NOTIFICATION_HANDSHAKE_FAILED:
		UART_PRINT("[SOCK ERROR] SSL handshake failed with error %d\r\n", pSock->SocketAsyncEvent.SockAsyncData.Val);
			break;
		case SL_SSL_ACCEPT:
			UART_PRINT("[SOCK ERROR] Recoverable error occurred during the handshake %d\r\n",pSock->SocketAsyncEvent.SockAsyncData.Val);
			break;
		case SL_OTHER_SIDE_CLOSE_SSL_DATA_NOT_ENCRYPTED:
			UART_PRINT("[SOCK ERROR] Other peer terminated the SSL layer.\r\n");
			break;
		case SL_SSL_NOTIFICATION_WRONG_ROOT_CA:
			UART_PRINT("[SOCK ERROR] Used wrong CA to verify the peer.\r\n");

			break;
		default:
			break;
		}
	}
	
	/* This application doesn't work w/ socket - Events are not expected */
	 switch( pSock->Event )
	 {
	   case SL_SOCKET_TX_FAILED_EVENT:
		   switch( pSock->SocketAsyncEvent.SockTxFailData.Status)
		   {
			  case SL_ERROR_BSD_ECLOSE:
				   UART_PRINT("[SOCK ERROR] - close socket (%d) operation "
								"failed to transmit all queued packets\n\r",
								pSock->SocketAsyncEvent.SockTxFailData.Sd);
			   break;
			   default:
					UART_PRINT("[SOCK ERROR] - TX FAILED  :  socket %d , "
								"reason (%d) \n\n",
								pSock->SocketAsyncEvent.SockTxFailData.Sd,
								pSock->SocketAsyncEvent.SockTxFailData.Status);
			   break;
		   }
		   break;

	   default:
			UART_PRINT("[SOCK EVENT] - Unexpected Event [%x0x]\n\n",pSock->Event);
			break;
	 }
}

void SimpleLinkNetAppRequestMemFreeEventHandler (uint8_t *buffer)
{
	/* Unused in this application */
}


//****************************************************************************
//
//! \brief Push Button Handler1(GPIOSW2). Press push button2 whenever user wants to
//! 		 switch to AP mode. Write message into message queue indicating
//! 		 switching to AP mode.
//!
//! \param[in] none
//!
//! return none
//
//****************************************************************************
void pushButtonInterruptHandler2(uint_least8_t index)
{
	int32_t 				msgqRetVal;
	struct timespec 		ts;
	
    /* Disable the SW2 interrupt */
    GPIO_disableInt(Board_BUTTON0); // SW2

	/* see ControlMessageType. msg=2 applies to ControlMessageType_Switch2 */
	uint8_t msg = 2;

	/* timeout is 0 to send the message immediatelly */
	ts.tv_sec = 0;
	ts.tv_nsec = 0;

	msgqRetVal = mq_timedsend(controlMQueue, (char *)&msg, 1, 0, &ts);
	if(msgqRetVal < 0)
	{
		UART_PRINT("[Control task] could not send element to msg queue\n\r");
		while (1);
	}
}


/*****************************************************************************
                 Local Functions
*****************************************************************************/
//*****************************************************************************
//
//! Application Boarders display on UART
//!
//! \param  ch - Character to be displayed , n - number of time to display
//!
//! \return none
//!
//*****************************************************************************
void printBorder(char ch, int n)
{
    int        i = 0;

    for(i=0; i<n; i++)    putch(ch);
}
//*****************************************************************************
//
//! Application startup display on UART
//!
//! \param  none
//!
//! \return none
//!
//*****************************************************************************
int32_t DisplayBanner(char * AppName, char * AppVer)
{
    int32_t            ret = 0;
    uint8_t            macAddress[SL_MAC_ADDR_LEN];
    uint16_t           macAddressLen = SL_MAC_ADDR_LEN;
    uint16_t           ConfigSize = 0;
    uint8_t            ConfigOpt = SL_DEVICE_GENERAL_VERSION;
    SlDeviceVersion_t ver = {0};
    char lineBreak[]                = "\n\r";
    ConfigSize = sizeof(SlDeviceVersion_t);

    /* Print device version info. */
    ret = sl_DeviceGet(SL_DEVICE_GENERAL, &ConfigOpt, &ConfigSize, (uint8_t*)(&ver));
    ASSERT_ON_ERROR(ret);

    /* Print device Mac address */
    ret = sl_NetCfgGet(SL_NETCFG_MAC_ADDRESS_GET, 0, &macAddressLen, &macAddress[0]);
    ASSERT_ON_ERROR(ret);

    UART_PRINT(lineBreak);
    UART_PRINT("\t");
    printBorder('=', 44);
    UART_PRINT(lineBreak);
    UART_PRINT("\t   %s Example Ver: %s",AppName, AppVer);
    UART_PRINT(lineBreak);
    UART_PRINT("\t");
    printBorder('=', 44);
    UART_PRINT(lineBreak);
    UART_PRINT(lineBreak);
    UART_PRINT("\t CHIP: 0x%x",ver.ChipId);
    UART_PRINT(lineBreak);
    UART_PRINT("\t MAC:  %d.%d.%d.%d",ver.FwVersion[0],ver.FwVersion[1],ver.FwVersion[2],ver.FwVersion[3]);
    UART_PRINT(lineBreak);
    UART_PRINT("\t PHY:  %d.%d.%d.%d",ver.PhyVersion[0],ver.PhyVersion[1],ver.PhyVersion[2],ver.PhyVersion[3]);
    UART_PRINT(lineBreak);
    UART_PRINT("\t NWP:  %d.%d.%d.%d",ver.NwpVersion[0],ver.NwpVersion[1],ver.NwpVersion[2],ver.NwpVersion[3]);
    UART_PRINT(lineBreak);
    UART_PRINT("\t ROM:  %d",ver.RomVersion);
    UART_PRINT(lineBreak);
    UART_PRINT("\t HOST: %s", SL_DRIVER_VERSION);
    UART_PRINT(lineBreak);
    UART_PRINT("\t MAC address: %02x:%02x:%02x:%02x:%02x:%02x", macAddress[0], macAddress[1], macAddress[2], macAddress[3], macAddress[4], macAddress[5]);
    UART_PRINT(lineBreak);
    UART_PRINT(lineBreak);
    UART_PRINT("\t");
    printBorder('=', 44);
    UART_PRINT(lineBreak);
    UART_PRINT(lineBreak);

    return ret;
}

//*****************************************************************************
//
//! This  function clears and enables a GPIO pin interrupt flag
//!
//! \param    index - GPIO index
//!
//! \return None
//!
//*****************************************************************************
static void GPIO_clearAndEnable(uint8_t index)
{
    GPIO_clearInt(index);
    GPIO_enableInt(index);
}

//*****************************************************************************
//
//! This function initializes the application variables
//!
//! \param    None
//!
//! \return None
//!
//*****************************************************************************
static void InitializeAppVariables(void)
{
	OutOfBox_ControlBlock.gatewayIP = 0;
	OutOfBox_ControlBlock.status = 0;

	memset(OutOfBox_ControlBlock.connectionSSID, 0, sizeof(OutOfBox_ControlBlock.connectionSSID));
	memset(OutOfBox_ControlBlock.connectionBSSID, 0, sizeof(OutOfBox_ControlBlock.connectionBSSID));
}

/*****************************************************************************
                 Main Functions
*****************************************************************************/

//**********************************************************************************************
//
//! \brief control task. Create switches handlers and waits for invokations on those switches.
//!		 Additinally, activate watchdog timer to validate the application code
//!
//! \param[in]  None
//!
//! \return None
//!
//***********************************************************************************************
void * controlTask(void *pvParameters)
{
	ControlMessageType 			queueMsg;
	int32_t							retVal;
	uint32_t						ocpRegVal;
	mq_attr 						attr;
	struct timespec 				ts;

	/* initializes mailbox for http messages */
	attr.mq_maxmsg = 10;         // queue size
	attr.mq_msgsize = sizeof( ControlMessageType );      // Size of message
	controlMQueue = mq_open("control msg q", O_CREAT, 0, &attr);
	if(controlMQueue == NULL)
	{
		UART_PRINT("[Control task] could not create msg queue\n\r");
		while (1);
	}

	/* enable interupt for the GPIO 22 (email trigger) */
	GPIO_setCallback(Board_BUTTON0, pushButtonInterruptHandler2);
	GPIO_enableInt(Board_BUTTON0);

	while (1)
	{
		queueMsg = ControlMessageType_ControlMessagesMax;

		clock_gettime(CLOCK_REALTIME, &ts);
       	ts.tv_sec += 2;

		retVal = mq_timedreceive(controlMQueue, (char *)&queueMsg, sizeof( ControlMessageType ), NULL,&ts);

		switch(queueMsg){
			case ControlMessageType_ControlMessagesMax:
				break;
			case ControlMessageType_Switch2:
				UART_PRINT("[Control task] switching to AP mode\n\r");
				/* SW2 is used to revert to AP mode and stop provisioning (if running) so device can be connected and controlled adhoc */
				retVal = provisioningStop();

				if (retVal == SL_RET_CODE_DEV_NOT_STARTED)	// intermmediate phase, need to push AP switch again
				{
					UART_PRINT("[Control task] device is not started yet, please press SW2 button again\n\r");
	                /* Clear and enable again the SW2 interrupt */
					GPIO_clearAndEnable(Board_BUTTON0);
					break;
				}

				if ((retVal == SL_RET_CODE_DEV_LOCKED) || (retVal == SL_API_ABORTED))	// should not happen
				{
					UART_PRINT("[Control task] device cannot start in AP mode, please reset the board\n\r");
	                /* Clear and enable again the SW2 interrupt */
					GPIO_clearAndEnable(Board_BUTTON0);
					break;
				}

				/* set AP mode regardless of the current mode */
				retVal = sl_WlanSetMode(ROLE_AP);

				/* Check if switching to AP command is successful */
				if (retVal == 0)
				{
					UART_PRINT("[Control task] device started in AP role, rebooting device...\n\r");
					
					/* indicate AP role on OCP register */
					ocpRegVal = MAP_PRCMOCRRegisterRead(OCP_REGISTER_INDEX);
					ocpRegVal |= (1<<OCP_REGISTER_OFFSET);
					MAP_PRCMOCRRegisterWrite(OCP_REGISTER_INDEX, ocpRegVal);
					/* Clear and enable again the SW2 interrupt */
					GPIO_clearAndEnable(Board_BUTTON0);
					mcuReboot();
				}
				else
				{
					UART_PRINT("[Control task] device not started in AP role\n\r");
				}

                /* Clear and enable again the SW2 interrupt */
				GPIO_clearAndEnable(Board_BUTTON0);
				break;
			case ControlMessageType_ResetRequired:
				UART_PRINT("[Control task] platform reboot is required\n\r");
				mcuReboot();

				break;

            default:
                break;
		}
	}
}

//*****************************************************************************
//
//! \brief This function reboot the M4 host processor
//!
//! \param[in]  none
//!
//! \return none
//!
//****************************************************************************
void mcuReboot(void)
{
	/* stop network processor activities before reseting the MCU */
	sl_Stop(SL_STOP_TIMEOUT );

	UART_PRINT("[Common] CC3220 MCU reset request\r\n");
	
	/* Reset the MCU in order to test the bundle */
	PRCMHibernateCycleTrigger();
}

void * mainThread( void *arg )
{
	int32_t RetVal ;
	pthread_attr_t      pAttrs;
	pthread_attr_t      pAttrs_spawn;
	struct sched_param  priParam;
	struct timespec     ts = {0};

	Board_initGPIO();
	Board_initSPI();
	Board_initI2C();

	/* init Terminal, and print App name */
	InitTerm();

        /* initilize the realtime clock */
	clock_settime(CLOCK_REALTIME, &ts);

	InitializeAppVariables();

	/* Switch off all LEDs on boards */
	GPIO_write(Board_LED0, Board_LED_OFF);

	/* initializes signals for all tasks */
	sem_init(&Provisioning_ControlBlock.connectionAsyncEvent, 0, 0);
	sem_init(&Provisioning_ControlBlock.provisioningDoneSignal, 0, 0);
	sem_init(&Provisioning_ControlBlock.provisioningConnDoneToOtaServerSignal, 0, 0);
	sem_init(&LinkLocal_ControlBlock.otaReportServerStartSignal, 0, 0);
	sem_init(&LinkLocal_ControlBlock.otaReportServerStopSignal, 0, 0);

	/* create the sl_Task */
	pthread_attr_init(&pAttrs_spawn);
	priParam.sched_priority = SPAWN_TASK_PRIORITY;
	RetVal = pthread_attr_setschedparam(&pAttrs_spawn, &priParam);
	RetVal |= pthread_attr_setstacksize(&pAttrs_spawn, TASK_STACK_SIZE);

	RetVal = pthread_create(&gSpawnThread, &pAttrs_spawn, sl_Task, NULL);

	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to create sl_Task thread \n");
        while(1);
	}
    RetVal = sl_Start(0, 0, 0);
    if (RetVal >= 0)
    {
        DisplayBanner(APPLICATION_NAME, APPLICATION_VERSION);
        RetVal = sl_Stop(SL_STOP_TIMEOUT );
        if (RetVal < 0)
        {
            /* Handle Error */
            UART_PRINT("\n sl_Stop failed\n");
            while(1);
        }
    }
    else if ((RetVal < 0) && (RetVal != SL_ERROR_RESTORE_IMAGE_COMPLETE))
    {
        /* Handle Error */
        UART_PRINT("\n sl_Start failed\n");
        UART_PRINT("\n %s Example Ver. %s\n",APPLICATION_NAME,APPLICATION_VERSION);
        while(1);
    }


	pthread_attr_init(&pAttrs);
	priParam.sched_priority = 1;
	RetVal = pthread_attr_setschedparam(&pAttrs, &priParam);
	RetVal |= pthread_attr_setstacksize(&pAttrs, TASK_STACK_SIZE);
	
	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to configure provisioningTask thread parameters \n");
        while(1);
	}

	RetVal = pthread_create(&gProvisioningThread, &pAttrs, provisioningTask, NULL);

	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to create provisioningTask thread \n");
        while(1);
	}

	pthread_attr_init(&pAttrs);
	priParam.sched_priority = 1;
	RetVal = pthread_attr_setschedparam(&pAttrs, &priParam);
	RetVal |= pthread_attr_setstacksize(&pAttrs, LINKLOCAL_STACK_SIZE);
	
	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to configure linkLocalTask thread parameters \n");
        while(1);
	}

	RetVal = pthread_create(&gLinklocalThread, &pAttrs, linkLocalTask, NULL);

	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to create linkLocalTask thread \n");
        while(1);
	}

	pthread_attr_init(&pAttrs);
	priParam.sched_priority = 1;
	RetVal = pthread_attr_setschedparam(&pAttrs, &priParam);
	RetVal |= pthread_attr_setstacksize(&pAttrs, CONTROL_STACK_SIZE);
	
	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to configure controlTask thread parameters \n");
        while(1);
	}

	RetVal = pthread_create(&gControlThread, &pAttrs, controlTask, NULL);

	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to create controlTask thread \n");
        while(1);
	}

	pthread_attr_init(&pAttrs);
	priParam.sched_priority = 5;
	RetVal = pthread_attr_setschedparam(&pAttrs, &priParam);
	RetVal |= pthread_attr_setstacksize(&pAttrs, TASK_STACK_SIZE);
	
	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to configure otaTask thread parameters \n");
        while(1);
	}

	RetVal = pthread_create(&gOtaThread, &pAttrs, otaTask, NULL);

	if(RetVal)
	{
        /* Handle Error */
        UART_PRINT("Unable to create otaTask thread \n");
        while(1);
	}

	return(0);
}
