/*
 * Copyright (c) 2012-2013, Texas Instruments Incorporated
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
 *  ======== TimestampDM8168Timer.xs ========
 */
var isEnableDebugPrintf = true;
var catalogName;
var deviceName;

/*
 *  ======== module$use ========
 */
function module$use() {
    xdc.useModule('ti.uia.runtime.IUIATimestampProvider');
    xdc.useModule('xdc.runtime.ITimestampClient');
    xdc.useModule('xdc.runtime.ITimestampProvider');
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    /* Only process during "cfg" phase */
    if (xdc.om.$name != "cfg") {
        return;
    }
    catalogName = Program.cpu.catalogName;
    deviceName = Program.cpu.deviceName;
}

/*
 *  ======== instance$static$init ========
 */
function module$static$init( obj, params) {
    obj.timerMSW = 0;
    obj.timerBaseAdrs = null;
    obj.timer = null;

    var mod = xdc.module('ti.uia.family.dm.TimestampDM816XTimer');

    if (params.maxBusClockFreq.lo === undefined) {
        mod.maxBusClockFreq.lo = 27000000;
        mod.maxBusClockFreq.hi = 0;
    } else {
        mod.maxBusClockFreq.lo = params.maxBusClockFreq.lo;
        mod.maxBusClockFreq.hi = params.maxBusClockFreq.hi;
    }
    if (isEnableDebugPrintf) {
        print("UIA: TimestampDM8168Timer mod.maxBusClockFreq.lo = " +
                mod.maxBusClockFreq.lo);
    }

    if (params.maxTimerClockFreq.lo === undefined) {
        mod.maxTimerClockFreq.lo = 27000000;
        mod.maxTimerClockFreq.hi = 0;
    } else {
        mod.maxTimerClockFreq.lo = params.maxTimerClockFreq.lo;
        mod.maxTimerClockFreq.hi = params.maxTimerClockFreq.hi;
    }
    if (isEnableDebugPrintf) {
        print("UIA: TimestampDM8168Timer mod.maxTimerClockFreq.lo = " +
                mod.maxTimerClockFreq.lo);
    }
}
