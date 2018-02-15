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
 *  ======== TimestampC66XLocal.xs ========
 */
var isEnableDebugPrintf = false;

/*
 *  ======== module$use ========
 */
function module$use() {
    xdc.useModule('ti.uia.runtime.IUIATimestampProvider');
    xdc.useModule('xdc.runtime.ITimestampClient');
    xdc.useModule('xdc.runtime.ITimestampProvider');
    var mod = xdc.module('ti.uia.family.c66.TimestampC66XLocal');
    var device = Program.cpu.deviceName;
    var platform = Program.platform;
    var exeContext = platform.getExeContext(Program);
    if (mod.maxTimerClockFreq.lo === undefined){

        if (exeContext.clockRate < 4294.967295){
            mod.maxTimerClockFreq.lo = 1000000.0*exeContext.clockRate;
            mod.maxTimerClockFreq.hi = 0;
        } else {
            mod.maxTimerClockFreq.lo = 1000000.0*(exeContext.clockRate - 4294.967295);
            mod.maxTimerClockFreq.hi = 1;
        }
        if (isEnableDebugPrintf)
            print("UIA: TimestampC66XLocal module$use: mod.maxTimerClockFreq.lo = "+mod.maxTimerClockFreq.lo);
    }
    if (mod.maxBusClockFreq.lo === undefined){

        if (exeContext.clockRate < 4294.967295){
            mod.maxBusClockFreq.lo = 1000000.0*exeContext.clockRate;
            mod.maxBusClockFreq.hi = 0;
        } else {
            mod.maxBusClockFreq.lo = 1000000.0*(exeContext.clockRate - 4294.967295);
            mod.maxBusClockFreq.hi = 1;
        }
        if (isEnableDebugPrintf)
            print("UIA: TimestampC66XLocal module$use: mod.maxBusClockFreq.lo = "+mod.maxBusClockFreq.lo);
    }
}

/*
 *  ======== module$static$init ========
 */
function module$static$init( obj, params) {

    var mod = xdc.module('ti.uia.family.c66.TimestampC66XLocal');
    obj.freq.lo = params.maxTimerClockFreq.lo;
    obj.freq.hi = params.maxTimerClockFreq.hi;

    if (isEnableDebugPrintf)
        print("UIA: TimestampC66XLocal mod.maxTimerClockFreq.lo = "+params.maxTimerClockFreq.lo);
}
