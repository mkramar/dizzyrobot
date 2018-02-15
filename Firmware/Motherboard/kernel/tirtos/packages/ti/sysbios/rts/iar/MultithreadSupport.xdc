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
 *  ======== MultithreadSupport.xdc ========
 */

package ti.sysbios.rts.iar;

import xdc.runtime.Error;
import xdc.runtime.Assert;

import ti.sysbios.knl.Task;

/*!
 *  ======== MultithreadSupport ========
 *  This Multithread support module uses Hook Functions, Hook Context
 *  and an overloaded implementation of the library's lock and thread
 *  local storage access functions to make C runtime library calls re-entrant.
 *
 *  Multithread support will be enabled when IAR linker option "--threaded_lib"
 *  is passed as the target's linker options prefix. This can be done in one
 *  of the following ways:
 *     - When building an application in IAR Embedded Workbench, under
 *       Project -> Options -> General Options -> Library Configuration,
 *       check the "Enable thread support in Library" box.
 *     - When building an application through makefile using configuro, pass
 *       the linker options on configuro command line using "--linkOptions"
 *       option.
 *     - When building an application through XDC build system using config.bld,
 *       pass the linker options through the XDC target linkOpts.prefix in
 *       config.bld.
 *
 *  Note: Calling C runtime functions from SWI and HWI threads
 *        is not supported and will generate an exception if
 *        multithread support is enabled.
 *
 */

module MultithreadSupport
{
    /*!
     *  ======== enableMultithreadSupport ========
     *  Enable/Disable multithread support
     *
     *  @_nodoc
     */
    config Bool enableMultithreadSupport = false;

    /*!
     *  ======== A_badThreadType ========
     *  Asserted in MultithreadSupport_perThreadAccess()
     *
     *  @_nodoc
     */
    config Assert.Id A_badThreadType = {
        msg: "A_badThreadType: Cannot call a C runtime library API from a Hwi or Swi thread."
    };

    /*!
     *  ======== A_badLockRelease ========
     *  Asserted in MultithreadSupport_releaseLock()
     *
     *  @_nodoc
     */
    config Assert.Id A_badLockRelease = {
        msg: "A_badLockRelease: Trying to release a lock not owned by this thread."
    };

internal:   /* not for client use */

    /*!
     *  ======== perThreadAccess ========
     *  Returns a pointer the symbol in the current task's TLS memory
     *
     *  Calculates the symbol address based on the input symbol pointer
     *  in main task's TLS memory and returns the address to the symbol
     *  in the current task's TLS memory.
     *
     *  @param(symbp) Pointer to symbol in the main task's TLS memory.
     *
     */
    Void *perThreadAccess(Void *symbp);

    /*!
     *  ======== getTlsPtr ========
     *  Returns a pointer to the current task's TLS memory
     */
    Void *getTlsPtr();

    /*!
     *  ======== initLock ========
     *  Initializes a system lock
     *
     *  Creates a system lock and assigns it to the pointer passed as input.
     *
     *  @param(ptr) Pointer to a lock struct pointer.
     *
     */
    Void initLock(Void **ptr);

    /*!
     *  ======== destroyLock ========
     *  Destroy a system lock
     *
     *  Deletes the semaphore in the lock and frees the lock.
     *
     *  @param(ptr) Pointer to a lock struct pointer.
     *
     */
    Void destroyLock(Void **ptr);

    /*!
     *  ======== acquireLock ========
     *  Acquire a system lock
     *
     *  Blocks the task if lock is not available. Supports nested calls.
     *
     *  @param(ptr) Pointer to a lock struct pointer.
     *
     */
    Void acquireLock(Void **ptr);

    /*!
     *  ======== releaseLock ========
     *  Release a system lock
     *
     *  Releases the lock to other waiting task if any. Supports nested calls.
     *
     *  @param(ptr) Pointer to a lock struct pointer.
     *
     */
    Void releaseLock(Void **ptr);

    /*!
     *  ======== taskCreateHook ========
     *  Create task hook function
     *
     *  It is used to create and initialize all task's hook context.
     *
     *  @param(task) Handle of the Task to initialize.
     *  @param(eb) Error block.
     *
     */
    Void taskCreateHook(Task.Handle task, Error.Block *eb);

    /*!
     *  ======== taskDeleteHook ========
     *  Delete hook function used to remove the task's hook context.
     *
     *  @param(task) Handle of the Task to delete.
     *
     */
    Void taskDeleteHook(Task.Handle task);

    /*!
     *  ======== taskRegHook ========
     *  Registration function for the module's hook
     *
     *  @param(id) The id of the hook for use in load.
     *
     */
    Void taskRegHook(Int id);

    /* -------- Internal Module Types -------- */

    struct Module_State {
        Int taskHId;             /* Task Hook Context Id for this module */
    };
}
