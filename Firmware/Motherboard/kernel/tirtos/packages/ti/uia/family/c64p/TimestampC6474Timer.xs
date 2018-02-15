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
 *  ======== TimestampC6474Timer.xs ========
 */
var isEnableDebugPrintf = false;

/*
 *  ======== module$use ========
 */
function module$use() {
    xdc.useModule('ti.uia.runtime.IUIATimestampProvider');
    xdc.useModule('xdc.runtime.ITimestampClient');
    xdc.useModule('xdc.runtime.ITimestampProvider');
}

/*
 *  ======== instance$static$init ========
 */
function module$static$init( obj, params) {

    var mod = xdc.module('ti.uia.family.c64p.TimestampC6474Timer');
    if (params.maxBusClockFreq.lo === undefined) {
        mod.maxBusClockFreq.lo = 1000000000;
        mod.maxBusClockFreq.hi = 0;
    } else {
        mod.maxBusClockFreq.lo = params.maxBusClockFreq.lo;
        mod.maxBusClockFreq.hi = params.maxBusClockFreq.hi;
    }
    if (isEnableDebugPrintf)
        print("UIA: TimestampC6474Timer mod.maxBusClockFreq.lo = "+mod.maxBusClockFreq.lo);

    if (params.cpuCyclesPerTick === undefined) {
     } else {
        mod.$unseal('cpuCyclesPerTick');
                mod.cpuCyclesPerTick = params.cpuCyclesPerTick;
                mod.$seal('cpuCyclesPerTick');
    }
    if (isEnableDebugPrintf)
        print("UIA: TimestampC6474Timer mod.cpuCyclesPerTick = "+mod.cpuCyclesPerTick);

    if (params.maxTimerClockFreq.lo === undefined) {
        mod.maxTimerClockFreq.lo = mod.maxBusClockFreq.lo/mod.cpuCyclesPerTick;
        mod.maxTimerClockFreq.hi = 0;
    } else {
        mod.maxTimerClockFreq.lo = params.maxTimerClockFreq.lo;
        mod.maxTimerClockFreq.hi = params.maxTimerClockFreq.hi;
    }
    if (isEnableDebugPrintf)
        print("UIA: TimestampC6474Timer mod.maxTimerClockFreq.lo = "+mod.maxTimerClockFreq.lo);
}
