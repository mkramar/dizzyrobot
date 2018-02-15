/*
 * Copyright (c) 2016-2017, Texas Instruments Incorporated
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
 *  ======== mqueue.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Assert.h>
#include <xdc/runtime/Error.h>
#include <xdc/runtime/Memory.h>

#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include <ti/sysbios/BIOS.h>
#include <ti/sysbios/knl/Clock.h>
#include <ti/sysbios/knl/Task.h>
#include <ti/sysbios/knl/Mailbox.h>

#include "pthread.h"
#include "mqueue.h"
#include "errno.h"
#include "pthread_util.h"

/*
 *  ======== MQueueObj ========
 *  The message queue object, created the first time the message queue is
 *  opened.
 */
typedef struct MQueueObj {
    struct MQueueObj  *next;
    struct MQueueObj  *prev;
    Mailbox_Handle     mailbox;
    mq_attr            attrs;
    int                refCount;
    char              *name;
} MQueueObj;

/*
 *  ======== MQueueDesc ========
 *  Threads that call mq_open() get a descriptor handle.  This allows
 *  passing of different flags to mq_open().
 */
typedef struct MQueueDesc {
    MQueueObj *msgQueue;  /* The actual message queue object */
    long       flags;
} MQueueDesc;

static MQueueObj *findInList(const char *name);

static MQueueObj *mqList = NULL;

/*
 *  ======== mq_close ========
 */
int mq_close(mqd_t mqdes)
{
    MQueueDesc *mqd = (MQueueDesc *)mqdes;
    MQueueObj  *msgQueue = mqd->msgQueue;
    UInt key;

    Memory_free(Task_Object_heap(), mqd, sizeof(MQueueDesc));

    key = Task_disable();
    msgQueue->refCount--;
    Task_restore(key);

    return (0);
}

/*
 *  ======== mq_getattr ========
 */
int mq_getattr(mqd_t mqdes, struct mq_attr *mqstat)
{
    MQueueDesc *mqd = (MQueueDesc *)mqdes;
    MQueueObj  *msgQueue = mqd->msgQueue;

    msgQueue->attrs.mq_curmsgs = Mailbox_getNumPendingMsgs(msgQueue->mailbox);

    *mqstat = msgQueue->attrs;
    mqstat->mq_flags = mqd->flags;

    return (0);
}

/*
 *  ======== mq_open ========
 */
mqd_t mq_open(const char *name, int oflags, ...)
{
    va_list           va;
    mode_t            mode;
    mq_attr          *attrs = NULL;
    MQueueObj        *msgQueue;
    MQueueDesc       *msgQueueDesc = NULL;
    MQueueDesc       *mqd = (MQueueDesc *)(-1);
    Error_Block       eb;
    UInt              key;
    Bool              failedStatus = FALSE;

    va_start(va, oflags);

    if (oflags & O_CREAT) {
        mode = va_arg(va, mode_t);
        attrs = va_arg(va, mq_attr*);
    }

    va_end(va);

    if (name == NULL) {
        return ((mqd_t)(-1));
    }

    Error_init(&eb);

    key = Task_disable();
    msgQueue = findInList(name);
    Task_restore(key);

    if ((msgQueue != NULL) && (oflags & O_CREAT) && (oflags & O_EXCL)) {
        /* Error: Message queue has alreadey been opened and O_EXCL is set */
        return ((mqd_t)(-1));
    }

    if ((msgQueue == NULL) && (!(oflags & O_CREAT) ||
                (attrs == NULL) || (attrs->mq_maxmsg <= 0))) {
        /*
         *  Error: Message has not been opened and O_CREAT is not set or
         *  attrs are bad.
         */
        return ((mqd_t)(-1));
    }

    msgQueueDesc = (MQueueDesc *)Memory_alloc(Task_Object_heap(),
            sizeof(MQueueDesc), 0, &eb);
    if (msgQueueDesc == NULL) {
        return ((mqd_t)(-1));
    }

    if (msgQueue == NULL) {
        /* Allocate the MQueueObj */
        msgQueue = (MQueueObj *)Memory_alloc(Task_Object_heap(),
                sizeof(MQueueObj), 0, &eb);
        if (msgQueue == NULL) {
            failedStatus = TRUE;
            goto done;
        }

        msgQueue->refCount = 1;
        msgQueue->attrs = *attrs;

        msgQueue->name = (char *)Memory_alloc(Task_Object_heap(),
                strlen(name) + 1, 0, &eb);

        if (msgQueue->name == NULL) {
            failedStatus = TRUE;
            goto done;
        }

        strcpy(msgQueue->name, name);

        msgQueue->mailbox = Mailbox_create(attrs->mq_msgsize,
                attrs->mq_maxmsg, NULL, &eb);

        if (msgQueue->mailbox == NULL) {
            failedStatus = TRUE;
            goto done;
        }

        /*
         *  Add the message queue to the list now
         */
        msgQueue->prev = NULL;

        key = Task_disable();

        if (mqList != NULL) {
            mqList->prev = msgQueue;
        }

        msgQueue->next = mqList;
        mqList = msgQueue;
    }
    else {
        key = Task_disable();
        msgQueue->refCount++;
    }

    Task_restore(key);

    msgQueueDesc->msgQueue = msgQueue;

    msgQueueDesc->flags = (oflags & O_NONBLOCK) ? O_NONBLOCK : 0;

done:
    if (failedStatus) {
        /*
         *  We only get here if we attempted to allocate msgQueue (i.e., it
         *  was not already in the list), so we're ok to free it.
         */
        if (msgQueue != NULL) {
            if (msgQueue->name != NULL) {
                Memory_free(Task_Object_heap(), msgQueue->name,
                    strlen(name) + 1);
            }
            Memory_free(Task_Object_heap(), msgQueue, sizeof(MQueueObj));
        }

        if (msgQueueDesc != NULL) {
            Memory_free(Task_Object_heap(), msgQueueDesc, sizeof(MQueueDesc));
        }
    }
    else {
        mqd = msgQueueDesc;
    }

    (void)mode;

    return ((mqd_t)mqd);
}

/*
 *  ======== mq_receive ========
 */
ssize_t mq_receive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
        unsigned int *msg_prio)
{
    MQueueDesc *mqd = (MQueueDesc *)mqdes;
    MQueueObj  *msgQueue = mqd->msgQueue;
    UInt32      timeout;
    int         retVal = -1;

    /*
     *  If msg_len is less than the message size attribute of the message
     *  queue, return an error.
     */
    if (msg_len < (size_t)((msgQueue->attrs).mq_msgsize)) {
        return (-1);
    }

    if (mqd->flags & O_NONBLOCK) {
        timeout = BIOS_NO_WAIT;
    }
    else {
        timeout = BIOS_WAIT_FOREVER;
    }

    /* Receive a message */
    if (Mailbox_pend(msgQueue->mailbox, (Ptr)msg_ptr, timeout)) {
        retVal = (msgQueue->attrs).mq_msgsize;
    }

    return (retVal);
}

/*
 *  ======== mq_send ========
 */
int mq_send(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
        unsigned int msg_prio)
{
    MQueueDesc *mqd = (MQueueDesc *)mqdes;
    MQueueObj  *msgQueue = mqd->msgQueue;
    UInt32 timeout;

    if (mqd->flags & O_NONBLOCK) {
        timeout = BIOS_NO_WAIT;
    }
    else {
        timeout = BIOS_WAIT_FOREVER;
    }

    /* Send a message */
    if (!Mailbox_post(msgQueue->mailbox, (Ptr)msg_ptr, timeout)) {
        return (-1);
    }

    return (0);
}

/*
 *  ======== mq_setattr ========
 */
int mq_setattr(mqd_t mqdes, const struct mq_attr *mqstat,
        struct mq_attr *omqstat)
{
    MQueueDesc *mqd = (MQueueDesc *)mqdes;
    MQueueObj  *msgQueue = mqd->msgQueue;
    UInt        key;

    Assert_isTrue((mqstat->mq_flags == 0) || (mqstat->mq_flags == O_NONBLOCK),
        0);

    /*
     *  The message queue attributes corresponding to the following
     *  members defined in the mq_attr structure shall be set to the
     *  specified values upon successful completion of mq_setattr():
     *  mq_flags
     *        The value of this member is the bitwise-logical OR of
     *        zero or more of O_NONBLOCK and any implementation-defined flags.
     *
     *  The values of the mq_maxmsg, mq_msgsize, and mq_curmsgs members of
     *  the mq_attr structure shall be ignored by mq_setattr().
    */
    key = Task_disable();

    if (omqstat != NULL) {
        *omqstat = msgQueue->attrs;
        omqstat->mq_flags = mqd->flags;
    }

    mqd->flags = mqstat->mq_flags;

    Task_restore(key);

    return (0);
}

/*
 *  ======== mq_timedreceive ========
 */
ssize_t mq_timedreceive(mqd_t mqdes, char *msg_ptr, size_t msg_len,
        unsigned int *msg_prio, const struct timespec *abstime)
{
    MQueueDesc         *mqd = (MQueueDesc *)mqdes;
    MQueueObj          *msgQueue = mqd->msgQueue;
    UInt32              timeout;
    int                 retVal = -1;

    /*
     *  If msg_len is less than the message size attribute of the message
     *  queue, return an error.
     */
    if (msg_len < (size_t)((msgQueue->attrs).mq_msgsize)) {
        return (-1);
    }

    if (mqd->flags & O_NONBLOCK) {
        timeout = BIOS_NO_WAIT;
    }
    else {
        if (_pthread_abstime2ticks(CLOCK_REALTIME, abstime, &timeout) != 0) {
            return (-1);
        }
    }

    /* Wait forever to receive a message */
    if (Mailbox_pend(msgQueue->mailbox, (Ptr)msg_ptr, timeout)) {
        retVal = (msgQueue->attrs).mq_msgsize;
    }

    return (retVal);
}

/*
 *  ======== mq_timedsend ========
 */
int mq_timedsend(mqd_t mqdes, const char *msg_ptr, size_t msg_len,
        unsigned int msg_prio, const struct timespec *abstime)
{
    MQueueDesc         *mqd = (MQueueDesc *)mqdes;
    MQueueObj          *msgQueue = mqd->msgQueue;
    UInt32              timeout;
    int                 retVal = 0;

    if (mqd->flags & O_NONBLOCK) {
        timeout = BIOS_NO_WAIT;
    }
    else {
        if (_pthread_abstime2ticks(CLOCK_REALTIME, abstime, &timeout) != 0) {
            return (-1);
        }
    }

    /* Wait for timeout to send a message */
    if (!Mailbox_post(msgQueue->mailbox, (Ptr)msg_ptr, timeout)) {
        retVal = -1;
    }

    return (retVal);
}

/*
 *  ======== mq_unlink ========
 */
int mq_unlink(const char *name)
{
    MQueueObj  *msgQueue;
    MQueueObj  *nextMQ, *prevMQ;
    UInt        key;

    key = Task_disable();

    msgQueue = findInList(name);

    if ((msgQueue != NULL) && (msgQueue->refCount == 0)) {
        /* If the message queue is in the list, remove it. */
        if (mqList == msgQueue) {
            mqList = msgQueue->next;
        }
        else {
            prevMQ = msgQueue->prev;
            nextMQ = msgQueue->next;

            if (prevMQ) {
                prevMQ->next = nextMQ;
            }
            if (nextMQ) {
                nextMQ->prev = prevMQ;
            }
        }

        msgQueue->next = msgQueue->prev = NULL;

        Task_restore(key);

        if (msgQueue->mailbox != NULL) {
            Mailbox_delete(&msgQueue->mailbox);
        }

        if (msgQueue->name != NULL) {
            Memory_free(Task_Object_heap(), msgQueue->name,
                    strlen(msgQueue->name) + 1);
        }

        Memory_free(Task_Object_heap(), msgQueue, sizeof(MQueueObj));

        return (0);
    }

    Task_restore(key);

    return (-1);
}

/*
 *************************************************************************
 *                      Internal functions
 *************************************************************************
 */

/*
 *  ======== findInList ========
 */
static MQueueObj *findInList(const char *name)
{
    MQueueObj *mq;

    mq = mqList;

    while (mq != NULL) {
        if (strcmp(mq->name, name) == 0) {
            return (mq);
        }
        mq = mq->next;
    }

    return (NULL);
}
