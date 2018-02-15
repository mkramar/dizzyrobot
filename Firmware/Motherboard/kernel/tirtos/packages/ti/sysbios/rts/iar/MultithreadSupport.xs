/*
 * Copyright (c) 2013-2017, Texas Instruments Incorporated
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
/*
 *  ======== MultithreadSupport.xs ========
 */

var BIOS = null;
var Task = null;
var Startup = null;
var MultithreadSupport = null;

/*
 *  ======== module$use ========
 */
function module$use()
{
    MultithreadSupport = this;

    BIOS = xdc.module("ti.sysbios.BIOS");
    Startup = xdc.useModule('xdc.runtime.Startup');

    if (BIOS.taskEnabled == true) {
        Task = xdc.module("ti.sysbios.knl.Task");
    }
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
    if ((BIOS.taskEnabled == true)
        && (MultithreadSupport.enableMultithreadSupport == true)) {
        Task.addHookSet({
            registerFxn: MultithreadSupport.taskRegHook,
            createFxn: null,
            readyFxn:  null,
            switchFxn: null,
            exitFxn: null,
            deleteFxn: MultithreadSupport.taskDeleteHook
        });
    }

    if ((MultithreadSupport.enableMultithreadSupport == true) &&
        Program.build.target.isa.match(/v7M/)) {
        Startup.lastFxns.$add("&__iar_Initlocks");
    }

    mod.taskHId = 0;
}

/*
 *  ======== module$validate ========
 */
function module$validate()
{
    if (!Program.build.target.$name.match(/iar/)) {
        MultithreadSupport.$logError("This module does not support non-IAR"
            + "targets.", MultithreadSupport);
    }

    if ((MultithreadSupport.enableMultithreadSupport == true) &&
        (BIOS.taskEnabled == false)) {
        MultithreadSupport.$logWarning("Multithread support has been enabled "
            + "for library calls from Task threads, but BIOS.taskEnabled is "
            + "false.", MultithreadSupport, "enableMultithreadSupport");
    }
}
