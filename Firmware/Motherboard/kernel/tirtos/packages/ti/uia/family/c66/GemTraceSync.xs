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
 *  ======== GemTraceSync.xs ========
 */
var isEnableDebugPrintf = false;

/*
 *  ======== module$use ========
 */
function module$use() {
    xdc.useModule('ti.uia.family.c66.GemTraceSync');
    xdc.useModule('ti.uia.runtime.IUIATraceSyncProvider');
    xdc.useModule('ti.uia.runtime.IUIATraceSyncClient');
}

/*
 *  ======== module$validate ========
 */
function module$validate( obj, params) {
    var IUIATraceSyncClient = xdc.module('ti.uia.runtime.IUIATraceSyncClient');

    // scan through list of modules and automatically
    // hook into modules that implement IUIATraceSyncClient
    for each (var mod in Program.targetModules()) {
        if (mod instanceof IUIATraceSyncClient.Module){
           if (mod.isInjectIntoTraceEnabled) {
               if (isEnableDebugPrintf)
                   print("UIA: ti.uia.family.c66.GemTraceSync.xs hooking "+mod.$name);

                mod.$unseal('injectIntoTraceFxn');
                mod.injectIntoTraceFxn =
                  $externModFxn('ti_uia_family_c66_GemTraceSync_injectIntoTrace__E');
                mod.$seal('injectIntoTraceFxn');
            }
        }
    }
}
