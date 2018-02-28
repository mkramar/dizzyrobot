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
 *  ======== semaphore.c ========
 */

#include <xdc/std.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Clock.h>
#include <ti/sysbios/knl/Semaphore.h>

#include "pthread_util.h"
#include "errno.h"
#include "semaphore.h"

/*
 *  ======== sem_destroy ========
 */
int sem_destroy(sem_t *semaphore)
{
    Semaphore_destruct(&(semaphore->sem));

    return (0);
}

/*
 *  ======== sem_getvalue ========
 */
int sem_getvalue(sem_t *semaphore, int *value)
{
    int count;

    count = Semaphore_getCount(Semaphore_handle(&(semaphore->sem)));

    *value = count;
    return (0);
}

/*
 *  ======== sem_init ========
 */
int sem_init(sem_t *semaphore, int pshared, unsigned value)
{
    int count = (int)value;

    if (count < 0) {
        /* value to large */
        return (EINVAL);
    }

    /* Default Semaphore mode is Semaphore_Mode_COUNTING */
    Semaphore_construct(&(semaphore->sem), count, NULL);
    return (0);
}

/*
 *  ======== sem_post ========
 */
int sem_post(sem_t *semaphore)
{
    Semaphore_post(Semaphore_handle(&(semaphore->sem)));
    return (0);
}

/*
 *  ======== sem_timedwait ========
 */
int sem_timedwait(sem_t *semaphore, const struct timespec *abstime)
{
    Bool               retVal;
    UInt32             timeout;

    if (_pthread_abstime2ticks(CLOCK_REALTIME, abstime, &timeout) != 0) {
        /* EINVAL */
        return (-1);
    }

    retVal = Semaphore_pend(Semaphore_handle(&(semaphore->sem)), timeout);

    if (!retVal) {
        /* ETIMEDOUT */
        return (-1);
    }

    return (0);
}

/*
 *  ======== sem_trywait ========
 */
int sem_trywait(sem_t *semaphore)
{
    Bool        retVal;

    /* Returns EAGAIN if the semaphore is already locked */
    retVal = Semaphore_pend(Semaphore_handle(&(semaphore->sem)), 0);

    if (!retVal) {
        /* EAGAIN */
        return (-1);
    }

    return (0);
}

/*
 *  ======== sem_wait ========
 */
int sem_wait(sem_t *semaphore)
{
    Semaphore_pend(Semaphore_handle(&(semaphore->sem)),
            BIOS_WAIT_FOREVER);

    return (0);
}
