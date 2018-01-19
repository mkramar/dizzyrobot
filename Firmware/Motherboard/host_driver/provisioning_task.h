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

#ifndef __PROVISIONING_H__
#define __PROVISIONING_H__

/* TI-DRIVERS Header files */
#include <ti/drivers/net/wifi/simplelink.h>

/* POSIX Header files */
#include <semaphore.h>
#include <pthread.h>
#include <time.h>

/*!
 *  \brief  Provisioning events
 */
typedef enum
{
	PrvnEvent_Triggered,
	PrvnEvent_Started,
	PrvnEvent_StartFailed,
	PrvnEvent_ConfirmationSuccess,
	PrvnEvent_ConfirmationFailed,
	PrvnEvent_Stopped,
	PrvnEvent_WaitForConn,
	PrvnEvent_Timeout,
	PrvnEvent_Error,
	PrvnEvent_Max,
}PrvnEvent;

/*!
 *  \brief  Provisioning states
 */
typedef enum
{
	PrvnState_Init,
	PrvnState_Idle,
	PrvnState_WaitForConfirmation,
	PrvnState_Completed,
	PrvnState_Error,
	PrvnState_Max

}PrvnState;

typedef struct Provisioning_ControlBlock_t
{
	sem_t	connectionAsyncEvent;
	sem_t 	provisioningDoneSignal;
	sem_t	provisioningConnDoneToOtaServerSignal;
}Provisioning_CB;

/****************************************************************************
                      GLOBAL VARIABLES
****************************************************************************/
extern Provisioning_CB	Provisioning_ControlBlock;

//****************************************************************************
//                      FUNCTION PROTOTYPES
//****************************************************************************


//*****************************************************************************
//
//! \brief This function signals the application events
//!
//! \param[in]  None
//!
//! \return 0 on success, negative value otherwise
//!
//****************************************************************************
_i16 SignalProvisioningEvent(PrvnEvent event);

//*****************************************************************************
//
//! \brief This function gets the current provisioning state
//!
//! \param[in]  None
//!
//! \return provisioning state
//!
//****************************************************************************
PrvnState GetProvisioningState();

//*****************************************************************************
//
//! \brief The interrupt handler for the LED timer
//!
//! \param[in]  None
//!
//! \return None
//!
//****************************************************************************
void LedTimerIntHandler(sigval val);

//*****************************************************************************
//
//! \brief This function starts the led toggling timer
//!
//! \param[in]  None
//!
//! \return 0 on success, negative value otherwise
//!
//****************************************************************************
int32_t StartLedEvtTimer(uint32_t timeout);

//*****************************************************************************
//
//! \brief This function stops the led toggling timer
//!
//! \param[in]  None
//!
//! \return 0 on success, negative value otherwise
//!
//****************************************************************************
int32_t StopLedEvtTimer(void);

//*****************************************************************************
//
//! \brief This function stops provisioning process
//!
//! \param[in]  None
//!
//! \return SL_RET_CODE_PROVISIONING_IN_PROGRESS if provisioning was running, otherwise 0
//!
//****************************************************************************
int32_t provisioningStop(void);

//*****************************************************************************
//
//! \brief This is the main provisioning task
//!
//! \param[in]  None
//!
//! \return None
//!
//****************************************************************************
void * provisioningTask(void *pvParameters);


#endif
