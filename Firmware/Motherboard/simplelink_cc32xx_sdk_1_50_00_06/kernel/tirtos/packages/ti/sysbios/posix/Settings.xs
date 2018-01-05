/*
 * Copyright (c) 2015-2017, Texas Instruments Incorporated
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
 *  ======== Settings.xs ========
 *
 */


var BIOS = null;
var Build = null;
var Settings = null;

/*
 * ======== getCFiles ========
 * return the array of C language files associated
 * with targetName (ie Program.build.target.$name)
 */
function getCFiles(targetName)
{
    return (["pthread.c",
             "pthread_barrier.c",
             "pthread_cond.c",
             "pthread_key.c",
             "pthread_mutex.c",
             "pthread_rwlock.c",
             "pthread_util.c",
             "clock.c",
             "mqueue.c",
             "sched.c",
             "semaphore.c",
             "sleep.c",
             "timer.c"]);
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

    /* provide getCFiles() for Build.getCFiles() */
    this.$private.getCFiles = getCFiles;
}

/*
 *  ======== module$static$init ========
 */
function module$static$init(mod, params)
{
}

/*
 *  ======== module$use ========
 */
function module$use()
{
    Settings = this;
    BIOS = xdc.useModule('ti.sysbios.BIOS');

    xdc.useModule('xdc.runtime.Assert');
    xdc.useModule('xdc.runtime.Memory');

    xdc.useModule('ti.sysbios.hal.Seconds');
    xdc.useModule('ti.sysbios.knl.Clock');
    xdc.useModule('ti.sysbios.knl.Mailbox');
    xdc.useModule('ti.sysbios.knl.Queue');
    xdc.useModule('ti.sysbios.knl.Semaphore');
    xdc.useModule('ti.sysbios.knl.Task');

    Build = xdc.module('ti.sysbios.Build');

    var defs = " -Dti_sysbios_posix_Settings_debug__D=" +
            (Settings.debug ? "TRUE" : "FALSE") +
            " -Dti_sysbios_posix_Settings_supportsMutexPriority__D=" +
            (Settings.supportsMutexPriority ? "TRUE" : "FALSE");

    Build.ccArgs.$add(defs);
}
