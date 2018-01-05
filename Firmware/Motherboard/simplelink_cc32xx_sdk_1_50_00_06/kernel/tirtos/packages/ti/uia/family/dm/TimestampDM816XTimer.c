/*
 * Copyright (c) 2012-2015, Texas Instruments Incorporated
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
 *  ======== TimestampC64X.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Error.h>
#include <xdc/runtime/Types.h>
#include <xdc/runtime/Startup.h>
#include <xdc/runtime/Gate.h>

#include <ti/sysbios/hal/Hwi.h>

#include <ti/sysbios/timers/dmtimer/Timer.h>

#include "package/internal/TimestampDM816XTimer.xdc.h"

#define TIMER_TCLR_START_ONESHOT        0x1
#define TIMER_TCLR_START_CONTINUOUS     0x3
#define TIMER_TCLR_STOP_MASK            0xfffffffe
#define TIMER_TWPS_W_PEND_TMAR          0x10
#define TIMER_TWPS_W_PEND_TLDR          0x4
#define TIMER_TWPS_W_PEND_TCRR          0x2
#define TIMER_TWPS_W_PEND_TCLR          0x1
#define TIMER_TMAR_MATCH_VALUE          0x0

typedef volatile struct TimerRegs {
    UInt32 tidr;
    UInt32 empty[3];
    UInt32 tiocpCfg;
    UInt32 empty1[3];
    UInt32 irq_eoi;
    UInt32 irqstat_raw;
    UInt32 tisr;  /* irqstat */
    UInt32 tier;  /* irqen_set */
    UInt32 irqen_clr;
    UInt32 twer;  /* irqwaken; */
    UInt32 tclr;
    UInt32 tcrr;
    UInt32 tldr;
    UInt32 ttgr;
    UInt32 twps;
    UInt32 tmar;
    UInt32 tcar1;
    UInt32 tsicr;
    UInt32 tcar2;
} TimerRegs;

static Void myIsr(UArg arg);


/*
 *  ======== TimestampDM816XTimer_Module_startup ========
 */
Int TimestampDM816XTimer_Module_startup(Int status)
{
    Int  timerId;
    Timer_Params params;

    module->timerMSW = 0;
    module->timerBaseAdrs = NULL;

    if (TimestampDM816XTimer_timerBaseAdrs == NULL){
#ifdef xdc_target__isaCompatible_64P
        switch(TimestampDM816XTimer_timerNumber){
            case TimestampDM816XTimer_TimerInstance_Timer4:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_C6000_Timer4;
                timerId = 0;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer5:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_C6000_Timer5;
                timerId = 1;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer6:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_C6000_Timer6;
                timerId = 2;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer7:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_C6000_Timer7;
                timerId = 3;
                break;
            default:
                // error
                break;
        }
#else
        /* CortexA8 and CortexM3 have the same base addresses for the timers */
        switch(TimestampDM816XTimer_timerNumber) {
            case TimestampDM816XTimer_TimerInstance_Timer4:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_ARM_Timer4;
                timerId = 2;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer5:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_ARM_Timer5;
                timerId = 3;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer6:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_ARM_Timer6;
                timerId = 4;
                break;
            case TimestampDM816XTimer_TimerInstance_Timer7:
                module->timerBaseAdrs =
                    (Ptr)TimestampDM816XTimer_BaseAdrs_ARM_Timer7;
                timerId = 5; // Removed from ti.sysbios.timers.dmtimer Timer.xs
                break;
            default:
                break;
        }
#endif

    } else {
        module->timerBaseAdrs = TimestampDM816XTimer_timerBaseAdrs;
        // TODO: Set timerId
    }

    if ((TimestampDM816XTimer_autoStart) && (module->timerBaseAdrs != NULL)) {
        /*
         *  Create a BIOS dm timer configured with the maximum period and a
         *  function to call when the timer rolls over. Only the processor
         *  with autostart configured to TRUE will create this timer. Other
         *  processors will read the timer registers to get the 64 bit time
         *  stamp from tcrr and tmar.
         */
        Timer_Params_init(&params);

        params.period = Timer_MAX_PERIOD;
        params.periodType = Timer_PeriodType_COUNTS;
        params.runMode = Timer_RunMode_CONTINUOUS;

        /* OCP config register (defaults are same as BIOS) */
        params.tiocpCfg.softreset = TimestampDM816XTimer_tiocpCfg.softreset;
        params.tiocpCfg.emufree = TimestampDM816XTimer_tiocpCfg.emufree;
        params.tiocpCfg.idlemode = TimestampDM816XTimer_tiocpCfg.idlemode;

        /*
         *  Timer Match Register (TMAR). Initialize to 0.  We will use this
         *  register to hold the number of times the timer counter has
         *  wrapped.  By setting the period to 0xffffffff, tmar will hold the
         *  upper 32 bits of the 64 bit timestamp.
         */
        params.tmar = 0;

        /* Wakeup enable register (defaults same as BIOS) */
        params.twer.mat_wup_ena = TimestampDM816XTimer_twer.mat_wup_ena;
        params.twer.ovf_wup_ena = TimestampDM816XTimer_twer.ovf_wup_ena;
        params.twer.tcar_wup_ena = TimestampDM816XTimer_twer.tcar_wup_ena;

        /* IRQ enable register (defaults same as BIOS) */
        params.tier.mat_it_ena = TimestampDM816XTimer_tier.mat_it_ena;
        params.tier.ovf_it_ena = TimestampDM816XTimer_tier.ovf_it_ena;
        params.tier.tcar_it_ena = TimestampDM816XTimer_tier.tcar_it_ena;

        /* Timer control register (defaults same as BIOS) */
        params.tclr.ptv = TimestampDM816XTimer_tclr.ptv;
        params.tclr.pre = TimestampDM816XTimer_tclr.pre;
        params.tclr.ce = 0;  /* Disable match so we can use tmar */
        params.tclr.scpwm = TimestampDM816XTimer_tclr.scpwm;
        params.tclr.tcm = TimestampDM816XTimer_tclr.tcm;
        params.tclr.trg = TimestampDM816XTimer_tclr.trg;
        params.tclr.pt = TimestampDM816XTimer_tclr.pt;
        params.tclr.captmode = TimestampDM816XTimer_tclr.captmode;
        params.tclr.gpocfg = TimestampDM816XTimer_tclr.gpocfg;

        params.arg = (UArg)module->timerBaseAdrs;

        module->timer = (Ptr)Timer_create(timerId, myIsr, &params, NULL);
        if (module->timer == NULL) {
            return (Startup_NOTDONE);
        }

        TimestampDM816XTimer_start();
    }

    return (Startup_DONE);
}

/*
 *  ======== TimestampDM816XTimer_start ========
 */
Void TimestampDM816XTimer_start()
{
    if (TimestampDM816XTimer_autoStart) {
        Timer_start((Timer_Object *)module->timer);
    }
}

/*
 *  ======== TimestampDM816XTimer_stop ========
 *  1. stop timer
 *  2. disable timer interrupt
 */
Void TimestampDM816XTimer_stop()
{
    if (TimestampDM816XTimer_autoStart) {
        Timer_stop((Timer_Object *)module->timer);
    }
}

/*
 *  ======== TimestampDM816XTimer_get32 ========
 */
Bits32 TimestampDM816XTimer_get32()
{
    if (module->timerBaseAdrs != NULL){
        return ((Bits32)((TimerRegs *)module->timerBaseAdrs)->tcrr);
    } else {
        return (0);
    }
}

/*
 *  ======== TimestampDM816XTimer_get64 ========
 *  Reads the timer's timestamp register and returns the 64b result.
 *
 *  NOTE: There is a remote chance that the timer counter register (tcrr),
 *  will have wrapped before the tmar register has been incremented. For a
 *  27MHz timer, the wrapping occurs about every 2.5 minutes.
 */
Void TimestampDM816XTimer_get64(Types_Timestamp64 *result)
{
    UInt32 tmar;
    UInt32 tcrr;
    UInt32 key;

    if (module->timerBaseAdrs != NULL){
        /*
         *  Disable interrupts so there will not be a long gap between
         *  reading the tcrr and tmar registers.
         */
        key = Hwi_disable();

        tcrr = ((TimerRegs *)(module->timerBaseAdrs))->tcrr;
        tmar = ((TimerRegs *)(module->timerBaseAdrs))->tmar;

        Hwi_restore(key);

        result->lo = (Bits32)tcrr;
        result->hi = (Bits32)tmar;
    } else {
        result->lo = 0;
        result->hi = 0;
    }
}

/*
 *  ======== TimestampDM816XTimer_getFreq ========
 */
Void TimestampDM816XTimer_getFreq(Types_FreqHz *freq)
{
    freq->lo = TimestampDM816XTimer_maxTimerClockFreq.lo;
    freq->hi = TimestampDM816XTimer_maxTimerClockFreq.hi;
}

/*
 * ======== TimestampDM816XTimer_setMSW ========
 * Sets the value to be returned in result->hi by the get64 API
 */
Void TimerstampDM816XTimer_setMSW(Int value)
{
    module->timerMSW = value;
}

/*
 *  ======== myIsr ========
 *  Called when timer counter wraps.
 */
static Void myIsr(UArg arg)
{
    UInt       key;
    TimerRegs *timer = (TimerRegs *)arg;

    key = Hwi_disable();

    timer->tmar = timer->tmar + 1;
    while (timer->twps & TIMER_TWPS_W_PEND_TMAR)
        ;

    Hwi_restore(key);
}
