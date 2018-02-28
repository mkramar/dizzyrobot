/*
 * Copyright (c) 2012, Texas Instruments Incorporated
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
 * */

/*
 *  ======== GemTraceSync.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Types.h>
#include <xdc/runtime/Timestamp.h>
#include <xdc/runtime/Gate.h>
#include <ti/uia/events/UIASync.h>
#include <ti/uia/runtime/IUIATraceSyncProvider.h>
#include <c6x.h> /* bring in references to OVERLAY register */

#include "package/internal/GemTraceSync.xdc.h"

/*! ======== getSyncWord ========
 * Returns a single 32b word of the sync point data to be written into the
 *    OVERLAY register
 *
 * Use this macro with ContextType values 0-3.
 */
#define getSyncWord(serialNum, ctxType) \
        (((ctxType & 0x0F)<<26) | ((serialNum << 2)& 0x03FFFFFC))

/*!
 * ======== getSyncWord1 ========
 * Returns the first word of a 2 word sync point to be written into the
 *    OVERLAY register
 *
 * @see getSyncWord1
 */
#define getSyncWord1(serialNum,ctxType,ctxData)\
        (0x80000000 | ((ctxType & 0x0F)<<26) | ((ctxData >> 10)& 0x03FFFFFC))

/*! ======== getSyncWord2 ========
 * Returns the second word of a 2 word sync point to be written into the
 *    OVERLAY register
 *
 */
#define getSyncWord2(serialNum,ctxType,ctxData)\
        ((0xC0000000 | (0x3FFFFC & serialNum)) | ((ctxData & 0x0FF) << 2))
/*
 * ====== injectIntoTrace ======
 * Inject syncPoint info into GEM Trace
 * This method logs a sync point event and injects
 * correlation info into the trace stream (if available)
 * to enable correlation between software events and hardware trace.
 *
 */
Void GemTraceSync_injectIntoTrace(UInt32 serialNumber,
        IUIATraceSyncProvider_ContextType ctxType){
    volatile UInt32 syncWord;
    IArg key = Gate_enterSystem();

    /* build word to inject into overlay register without using the OVERLAY
     * register as scratchpad */
    syncWord= getSyncWord(serialNumber,ctxType);

    OVERLAY = syncWord;
    Gate_leaveSystem(key);
}
/*
 * ====== injectCtxDataIntoTrace ======
 * Inject syncPoint info into GEM Trace
 * This method logs a sync point event and injects
 * correlation info into the trace stream (if available)
 * to enable correlation between software events and hardware trace.
 *
 */
Void GemTraceSync_injectCtxDataIntoTrace(UInt32 serialNumber,
        IUIATraceSyncProvider_ContextType ctxType, UInt32 ctxData){
    volatile UInt32 syncWord1;
    volatile UInt32 syncWord2;
    IArg key;

    switch(ctxType){
    /* Sync Point event sequence number */
    case IUIATraceSyncProvider_ContextType_SyncPoint:
    /* Context Change event sequence number */
    case IUIATraceSyncProvider_ContextType_ContextChange:
    /* Snapshot event Snapshot ID  */
    case IUIATraceSyncProvider_ContextType_Snapshot:
        key = Gate_enterSystem();

        /* build word to inject into overlay register without using the
         * OVERLAY register as scratchpad */
        syncWord1= getSyncWord(ctxType,serialNumber);

        OVERLAY = syncWord1;

        Gate_leaveSystem(key);
        break;
    default:
        key = Gate_enterSystem();

        /* build the two words to inject into overlay register without using
         * the OVERLAY register as scratchpad */
        syncWord1= getSyncWord1(ctxType,ctxData,serialNumber);
        syncWord2= getSyncWord2(ctxType,ctxData,serialNumber);

        OVERLAY = syncWord1;
        OVERLAY = syncWord2;

        Gate_leaveSystem(key);

    }
}
