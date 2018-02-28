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
 *  ======== pthread_rwlock.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Assert.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Clock.h>
#include <ti/sysbios/knl/Semaphore.h>
#include <ti/sysbios/knl/Task.h>

#include "pthread.h"
#include "errno.h"
#include "pthread_util.h"

static int rdlockAcquire(pthread_rwlock_t *lock, UInt timeout);

/*
 *************************************************************************
 *                      pthread_rwlockattr
 *************************************************************************
 */
/*
 *  ======== pthread_rwlockattr_destroy ========
 */
int pthread_rwlockattr_destroy(pthread_rwlockattr_t *attr)
{
    return (0);
}

/*
 *  ======== pthread_rwlockattr_init ========
 */
int pthread_rwlockattr_init(pthread_rwlockattr_t * attr)
{
    return (0);
}

/*
 *************************************************************************
 *                      pthread_rwlock
 *************************************************************************
 */

/*
 *  ======== pthread_rwlock_destroy ========
 */
int pthread_rwlock_destroy(pthread_rwlock_t *rwlock)
{
    /* Return EBUSY if the lock is in use. */
    if (rwlock->owner != NULL) {
        return (EBUSY);
    }

    Semaphore_destruct(&(rwlock->sem));
    Semaphore_destruct(&(rwlock->readSem));

    return (0);
}

/*
 *  ======== pthread_rwlock_init ========
 */
int pthread_rwlock_init(pthread_rwlock_t *rwlock,
        const pthread_rwlockattr_t *attr)
{
    /*
     *  Default Semaphore mode is Semaphore_Mode_COUNTING.
     */
    Semaphore_construct(&(rwlock->sem), 1, NULL);
    Semaphore_construct(&(rwlock->readSem), 0, NULL);

    rwlock->activeReaderCnt = 0;
    rwlock->blockedReaderCnt = 0;

    rwlock->owner = NULL;

    return (0);
}

/*
 *  ======== pthread_rwlock_rdlock ========
 */
int pthread_rwlock_rdlock(pthread_rwlock_t *rwlock)
{
    return (rdlockAcquire(rwlock, BIOS_WAIT_FOREVER));
}

/*
 *  ======== pthread_rwlock_timedrdlock ========
 */
int pthread_rwlock_timedrdlock(pthread_rwlock_t *rwlock,
        const struct timespec *abstime)
{
    UInt32             timeout;

    if (_pthread_abstime2ticks(CLOCK_REALTIME, abstime, &timeout) != 0) {
        return (EINVAL);
    }

    return (rdlockAcquire(rwlock, timeout));

}

/*
 *  ======== pthread_rwlock_timedwrlock ========
 */
int pthread_rwlock_timedwrlock(pthread_rwlock_t *rwlock,
        const struct timespec *abstime)
{
    UInt32             timeout;

    if (_pthread_abstime2ticks(CLOCK_REALTIME, abstime, &timeout) != 0) {
        return (EINVAL);
    }

    if (Semaphore_pend(Semaphore_handle(&(rwlock->sem)), timeout)) {
        Assert_isTrue(rwlock->owner == NULL, 0);
        rwlock->owner = pthread_self();
        Assert_isTrue(rwlock->activeReaderCnt == 0, 0);

        return (0);
    }

    return (ETIMEDOUT);
}

/*
 *  ======== pthread_rwlock_tryrdlock ========
 */
int pthread_rwlock_tryrdlock(pthread_rwlock_t *rwlock)
{
    return (rdlockAcquire(rwlock, 0));
}

/*
 *  ======== pthread_rwlock_trywrlock ========
 */
int pthread_rwlock_trywrlock(pthread_rwlock_t *rwlock)
{
    if (Semaphore_pend(Semaphore_handle(&(rwlock->sem)), 0)) {
        Assert_isTrue(rwlock->owner == NULL, 0);
        rwlock->owner = pthread_self();
        Assert_isTrue(rwlock->activeReaderCnt == 0, 0);

        return (0);
    }

    return (EBUSY);
}

/*
 *  ======== pthread_rwlock_unlock ========
 */
int pthread_rwlock_unlock(pthread_rwlock_t *rwlock)
{
    UInt                key;
    int                 i;

    key = Task_disable();

    if (rwlock->activeReaderCnt) {
        Assert_isTrue(rwlock->blockedReaderCnt == 0, 0);
        /*
         *  Lock is held by a reader.  The last active reader
         *  releases the semaphore.
         */
        if (--rwlock->activeReaderCnt == 0) {
            rwlock->owner = NULL;
            Semaphore_post(Semaphore_handle(&(rwlock->sem)));
        }
    }
    else {
        /*
         *  Lock is held by a writer.  Release the semaphore and
         *  if there are any blocked readers, unblock all of them.
         *  By unblocking all readers, we ensure that the highest
         *  priority reader is unblocked.
         */
        Semaphore_post(Semaphore_handle(&(rwlock->sem)));

        /* Unblock all readers */
        for (i = 0; i < rwlock->blockedReaderCnt; i++) {
            Semaphore_post(Semaphore_handle(&(rwlock->readSem)));
        }

        Assert_isTrue(rwlock->owner == pthread_self(), 0);
        rwlock->owner = NULL;
        Assert_isTrue(rwlock->activeReaderCnt == 0, 0);
    }

    Task_restore(key);

    return (0);
}

/*
 *  ======== pthread_rwlock_wrlock ========
 */
int pthread_rwlock_wrlock(pthread_rwlock_t *rwlock)
{
    Semaphore_pend(Semaphore_handle(&(rwlock->sem)), BIOS_WAIT_FOREVER);

    Assert_isTrue(rwlock->owner == NULL, 0);
    rwlock->owner = pthread_self();
    Assert_isTrue(rwlock->activeReaderCnt == 0, 0);

    return (0);
}


/*
 *************************************************************************
 *                      internal functions
 *************************************************************************
 */

/*
 *  ======== rdlockAcquire ========
 */
static int rdlockAcquire(pthread_rwlock_t *rwlock, UInt timeout)
{
    UInt32              curTicks;
    UInt32              prevTicks;
    UInt32              deltaTicks;
    UInt                key;

    key = Task_disable();

    if (rwlock->activeReaderCnt > 0) {
        /* The semaphore is owned by a reader, no need to pend. */
        rwlock->activeReaderCnt++;
        Task_restore(key);

        return (0);
    }

    if (Semaphore_pend(Semaphore_handle(&(rwlock->sem)), 0)) {
        /* Got the semaphore */
        rwlock->activeReaderCnt++;
        Assert_isTrue(rwlock->activeReaderCnt == 1, 0);

        Assert_isTrue(rwlock->owner == NULL, 0);
        rwlock->owner = pthread_self();

        /*
         *  Either there are no blocked readers, or a writer has just
         *  unlocked rwlock->sem and posted all the blocked readers.
         */

        Task_restore(key);

        return (0);
    }

    if (timeout == 0) {
        Task_restore(key);
        return (EBUSY);
    }

    rwlock->blockedReaderCnt++;
    curTicks = Clock_getTicks();

    Task_restore(key);

    for (;;) {
        if (!Semaphore_pend(Semaphore_handle(&(rwlock->readSem)), timeout)) {
            key = Task_disable();
            rwlock->blockedReaderCnt--;
            Task_restore(key);

            return (ETIMEDOUT);
        }

        key = Task_disable();

        /*
         *  If another reader is active, the rwlock->sem is owned
         *  by a reader, so just increment the active reader count.
         */
        if (rwlock->activeReaderCnt > 0) {
            rwlock->blockedReaderCnt--;
            rwlock->activeReaderCnt++;
            Task_restore(key);

            return (0);
        }

        /*
         *  We have been unblocked by a writer.  Try again to take the
         *  rwlock->sem, since another writer or reader may have taken
         *  it in the meantime.
         */
        if (Semaphore_pend(Semaphore_handle(&(rwlock->sem)), 0)) {
            /* Got it */
            rwlock->blockedReaderCnt--;
            rwlock->activeReaderCnt++;

            Assert_isTrue(rwlock->activeReaderCnt == 1, 0);
            Assert_isTrue(rwlock->owner == NULL, 0);
            rwlock->owner = pthread_self();

            Task_restore(key);
            return (0);
        }

        if (timeout != BIOS_WAIT_FOREVER) {
            prevTicks = curTicks;
            curTicks = Clock_getTicks();
            deltaTicks = curTicks - prevTicks;

            if (deltaTicks >= timeout) {
                /* Timed out without acquiring the lock */
                rwlock->blockedReaderCnt--;
                Task_restore(key);
                break;
            }
            timeout -= deltaTicks;
        }

        Task_restore(key);
    }

    return (ETIMEDOUT);
}
