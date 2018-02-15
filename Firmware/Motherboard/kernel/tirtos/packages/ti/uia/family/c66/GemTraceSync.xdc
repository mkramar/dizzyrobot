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
 * ======== GemTraceSync.xdc ========
 */
package ti.uia.family.c66;
import ti.uia.runtime.IUIATraceSyncProvider;
import ti.uia.events.UIASync;

/*!
 *  ======== GemTraceSync.xdc ========
 *  C64X+ specific code for injecting sync point info into the GEM Trace stream
 *
 * The OVERLAY register (a.k.a. TSDR register) is an undocumented register
 * availble on C64X+ Full GEM targets.  Writes into this register are injected
 * into the trace stream.  The data that is written is used by the host to
 * determine what target-side context was active at the time the trace data
 * was recorded.
 *
 * The register only has 30 writable bits, so in order to inject a 32b value
 * into the trace stream  (e.g. the thread handle of the currently executing
 * thread), the 32b address needs to be split into two pieces and written into
 * the OVERLAY register in two successive write operations.  To make it possible
 * to use the OVERLAY register to inject different types of context info into
 * the trace stream, the following bit assignments need to be used when
 * writing data into the OVERLAY register:
 *
 * OVERLAY register bit assignments:
 * 2 LSBs fixed (011b)
 * 6 MSBs used to determine what type of data the OVERLAY register contains
 *
 * b31-b26  : a 6 bit ?type ID? that describes what context info the sync point
 *             contains
 * 000000b  : reserved
 * 000001b  : b25-b2 of OVERLAY register contains the 24 LSBs
 *             of the sequence number of the Sync Point event
 *             that contains correlation info.  Only 1 OVERLAY
 *             register write is required for this info.
 * 000010b  : b25-b2 of OVERLAY register contains the 24 LSBs
 *             of the sequence number of the Context Change event
 *             that contains context change info.  Only 1 OVERLAY
 *             register write is required for this info.
 *   . . .  : reserved
 * 000011b  : b25-b2 of OVERLAY register contains the 24 LSBs
 *             of the snapshot ID of the snapshot event
 *             that contains snapshot info.  Only 1 OVERLAY register
 *             write is required for this info.
 * 10XXXXb  : contains first word of a 2 word OVERLAY register sequence.
 * b25-b2   : the 24 MSBs of 32b context data.
 *
 * 11XXXXb:    contains second word of a 2 word OVERLAY register sequence.
 * b29-b10 contain the 20LSBs of the sequence number of an event that contains
 *             context info.
 * b9-b2 contain 8 LSBs of 32b context data.
 *
 * If the 2 word OVERLAY register protocol is being used and there is a sync
 * loss, then only the OVERLAY register data with b31-b30 = 11b will be
 * available since it was the last data written into the register.  Since this
 * contains a sequence number, it may be possible for the host to recover the
 * lost sync data by finding the context change event that has the same sequence
 * number.
 */

@Gated
module GemTraceSync inherits ti.uia.runtime.IUIATraceSyncProvider {

   /*!
     * ====== injectIntoTrace ======
     * Inject syncPoint info into GEM Trace
     *
     * This method logs a sync point event and injects
     * correlation info into the trace stream (if available)
     * to enable correlation between software events and hardware trace.
     *
     * @param(serialNumber) a sync point serial number to inject into the trace
     *    stream
     * @param(ctxType) the CtxChg_ContextType constant that describes what
     *    context info the 2 words contain
     */
    @DirectCall
    override Void injectIntoTrace(UInt32 serialNum,
               IUIATraceSyncProvider.ContextType ctxType);

}
