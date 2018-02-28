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
 * ======== TimestampDM816XTimer.xdc ========
 */
package ti.uia.family.dm;

import xdc.runtime.Types;

/*!
 *  ======== TimestampDM8168Timer.xdc ========
 *  Implementation of `{@link ITimestampProvider}` using DM General purpose
 *  32b timer.  NOTE: for ARM devices, address values should be virtual
 *  addresses as seen by the CPU.
 */
@ModuleStartup
@Gated
module TimestampDM816XTimer inherits ti.uia.runtime.IUIATimestampProvider {

    /*!
     * ======== TimerInstance ========
     * Enumeration that defines the base addresses for each timer instance
     *  of the DM8168 device.
     */
    enum BaseAdrs {
        /* Timer 0-2 are reserved for Linux.  Timer 3 reserved for DSP */
        /* Both CortexM3 and CortexA8 have the same base addresses for the timers */
        BaseAdrs_ARM_Timer4 = 0x48044000,
        BaseAdrs_ARM_Timer5 = 0x48046000,
        BaseAdrs_ARM_Timer6 = 0x48048000,
        BaseAdrs_ARM_Timer7 = 0x4804A000,
        BaseAdrs_C6000_Timer4 = 0x08044000,
        BaseAdrs_C6000_Timer5 = 0x08046000,
        BaseAdrs_C6000_Timer6 = 0x08048000,
        BaseAdrs_C6000_Timer7 = 0x0804A000
    };

    enum TimerInstance {
        TimerInstance_UserConfigured = 0,
        TimerInstance_Timer4 = 4,
        TimerInstance_Timer5 = 5,
        TimerInstance_Timer6 = 6,
        TimerInstance_Timer7 = 7
    };

    /*!
     * ======== PrcmClkMuxBaseAdrs ========
     * PRCM CM_TIMERX_CLKSEL Timer clock mux select line
     *
     * The following enum provides the physical
     * addresses of the PRCM Clock Mux register
     * used for Timers 4,5,6 and 7.
     * If the virtual address of the register
     * is not the same as the physical address,
     * AND the autostart config option is true,
     * the prcmClkMuxBaseAdrs must be configured
     * with the virtual address of the register.
     */
    enum PrcmClkMuxBaseAdrs {
        PrcmClkMuxBaseAdrs_Timer4 = 0x4818039C,
        PrcmClkMuxBaseAdrs_Timer5 = 0x481803A0,
        PrcmClkMuxBaseAdrs_Timer6 = 0x481803A4,
        PrcmClkMuxBaseAdrs_Timer7 = 0x481803A8
    }

    /*! Timer OCP Configuration Register (TIOCP_CFG) - L4 interface Configuration. */
    struct TiocpCfg {
        Bits8 idlemode;  /*! 0=force-idle;1=no-idle;2=Smart-idle;3=Smart-idle */
        Bits8 emufree;   /*! 0=counter frozen; 1=counter free-running */
        Bits8 softreset; /*! 0=normal mode; 1=soft reset */
    };

    /*! Timer IRQENABLE CLR (IRQENABLE_CLR) */
    struct Tier {
        Bits8 mat_it_ena;  /*! Enable match interrupt */
        Bits8 ovf_it_ena;  /*! Enable overflow interrupt */
        Bits8 tcar_it_ena; /*! Enable capture interrupt */
    };

    /*! Timer IRQ WAKEUP ENABLE (IRQWAKEEN) */
    struct Twer {
        Bits8 mat_wup_ena;  /*! Enable match wake-up */
        Bits8 ovf_wup_ena;  /*! Enable overflow wake-up */
        Bits8 tcar_wup_ena; /*! Enable capture wake-up */
    };

    /*! Timer Control Register (TCLR). */
    struct Tclr {
        /*  b0: ST (1=start timer, 0=stop timer) set by internal #define.*/
        /*  b1: AR (1=auto-reload timer, 0=one shot timer) set by internal #define */
        Bits32 ptv; /*! Trigger output mode */
        Bits8 pre;  /*! Prescalar enable */
        Bits8 ce;   /*! Compare enable */
        Bits8 scpwm;/*! Pulse-width modulation */
        Bits16 tcm; /*! Transition capture mode */
        Bits16 trg; /*! Trigger output mode */
        Bits8 pt;   /*! Pulse or toggle select bit */
        Bits8 captmode; /*! Capture mode select bit */
        Bits8 gpocfg; /*! PWM output/event detection input pin */
    };

    /*! L4 Interface Synchronization Control Register (TSICR). */
    struct Tsicr {
        Bits8 sft;    /*! Reset software functional registers */
        Bits8 posted; /*! Posted mode selection */
    };

    /*!
     * ======= timerNumber ========
     * Number of the timer to use as the global timer
     *
     * The global timer provides a common time reference for all CPUs.
     * This configuration parameter specifies which timer to use
     * as the global timer.  All CPUs on the device must be
     * configured to use the same timer as the global timer.
     * Must be a value of TimerInstance_Timer4,5,6,7 or
     *  TimerInstance_UserConfigured.
     * If configured as TimerInstance_UserConfigured, then
     *  the module's timerBaseAdrs must be configured with
     *  the timer's virtual address and the module's
     *  prcmClkMuxBaseAdrs must be configured with the
     *  PRCM clock mux register's virtual address.
     * Note: Timers 0-2 are reserved for Linux.
     *       Timer 3 is reserved for the DSP.
     */
    config TimerInstance timerNumber = TimerInstance_Timer7;

    /*!
     * ======== timerBaseAdrs ========
     * Base address of the timer to be used as the global timer
     *
     * If the virtual address of the timer is not the same as the
     * physical address, AND the autostart config option is true,
     * the timerBaseAdrs must be configured with the virtual
     * address of the timer.  Otherwise set to null to allow
     * module to automatically use the physical address for the
     * specified timer.
     */
    config Ptr timerBaseAdrs = null;

    /*!
     * ======== prcmClkMuxBaseAdrs ========
     * Base address of the PRCM register used to select the timer clock source
     *
     * If the virtual address of the register is not the same as the
     * physical address, AND the autostart config option is true,
     * the prcmClkMuxBaseAdrs must be configured with the virtual
     * address of the register.  Otherwise set to null to allow
     * module to automatically use the physical address for the
     * specified timer.
     */
    config Ptr prcmClkMuxBaseAdrs = null;

    /*!
     * ======== prcmClkMuxInitValue =========
     * Value to write into the prcmClkMux register in order to configure timer clock
     *
     * If autoStart is TRUE and prcmClkMuxBaseAdrs is not null
     * OR timerNumber is set to a value other than UserConfigured
     * the module will writh the prcmClkMuxInitValue into the
     * PRCM clock mux register upon startup.
     *
     * By default, the value written, sets CLKSEL to SYS_CLK (b24 = 0) and sets
     * MODULEMODE to 2 (Module is enabled).
     */
    config Int prcmClkMuxInitValue = 0x0000002;

    /*!
     * ======== autoStart ========
     * Controls whether the module initializes the timer or not
     *
     * Must be set to true for one and only one CPU in the device
     */
    config Bool autoStart = false;

    /*!
     * ======== maxTimerClockFreq =========
     * The highest timer clock frequency.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     */
    override config Types.FreqHz maxTimerClockFreq = {lo:27000000,hi:0};


    /*!
     * ======== maxBusClockFreq =========
     * The highest bus clock frequency used to drive the timer.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     */
    override config Types.FreqHz maxBusClockFreq = {lo:27000000,hi:0};

    /*!
     *  ======== tiocpCfg ========
     */
    config TiocpCfg tiocpCfg = {idlemode: 0, emufree: 0, softreset: 1};

    /*!
     *  ======== tier ========
     */
    config Tier tier = {mat_it_ena: 0, ovf_it_ena: 1, tcar_it_ena: 0};

    /*!
     *  ======== twer ========
     */
    config Twer twer = {mat_wup_ena: 0, ovf_wup_ena: 0, tcar_wup_ena: 0};

    /*!
     *  ======== tclr ========
     */
    config Tclr tclr = {ptv: 0, pre: 0, ce: 0, scpwm: 0, tcm: 0, trg: 0,
        pt: 0, captmode: 0, gpocfg: 0};

    /*!
     *  ======== tsicr ========
     *  Default value of tsicr to use when configuring the timer
     *
     *  Only used if autoStart is true
     */
    config Tsicr tsicr = {sft: 0, posted: 1};


    /*!
     * ======== canFrequencyBeChanged =========
     * Indicates whether the timer frequency can be changed or not
     *
     * @a(returns) true if the timer's clock frequency can be changed
     */
    override metaonly config Bool canFrequencyBeChanged = false;

    /*!
     * ======== cpuCyclesPerTick =========
     * The number of CPU cycles each tick of the timestamp corresponds to
     *
     * A value of 0 indicates that no conversion between the timer's tick count
     * and CPU cycles is possible.
     */
    override metaonly config UInt32 cpuCyclesPerTick = 0;


    /*!
     * ======== canCpuCyclesPerTickBeChanged =========
     * Indicates whether the timer's cycles per tick divide down ratio can be
     *    changed or not
     *
     * @a(returns) true if the timer's CPU cycles per tick can be changed
     */
    override metaonly config Bool canCpuCyclesPerTickBeChanged = false;
    /*!
     *  ======== get32 ========
     *  Return a 32-bit timestamp
     *
     *  @a(returns)
     *  Returns a 32-bit timestamp value.
     *  Use `{@link #getFreq}` to convert this value into units of real time.
     *
     *  @see #get64
     */
    @DirectCall
    override Bits32 get32();

    /*!
     *  ======== get64 ========
     *  Return a 64-bit timestamp
     *
     *  @param(result)  pointer to 64-bit result
     *
     *      This parameter is a pointer to a structure representing a 64-bit
     *      wide timestamp value where the current timestamp is written.
     *
     *      If the underlying hardware does not support 64-bit resolution, the
     *      `hi` field of `result` is always set to 0; see
     *      `{@link xdc.runtime.Types#Timestamp64}`.  So, it is possible for
     *      the `lo` field to wrap around without any change to the `hi` field.
     *      Use `{@link #getFreq}` to convert this value into units of real
     *      time.
     *
     *  @see #get32
     */
    @DirectCall
    override Void get64(Types.Timestamp64 *result);

    /*!
     *  ======== getFreq ========
     *  Get the timestamp timer's frequency (in Hz)
     *
     *  @param(freq)  pointer to a 64-bit result
     *
     *      This parameter is a pointer to a structure representing a 64-bit
     *      wide frequency value where the timer's frequency (in Hz)
     *      is written; see `{@link xdc.runtime.Types#FreqHz}`.
     *      This function provides a way of converting timestamp
     *      values into units of real time.
     *
     *  @see #get32
     *  @see #get64
     */
    @DirectCall
    override Void getFreq(Types.FreqHz *freq);


    /*
     * ======== setMSW ========
     * Sets the value to be returned in result->hi by the get64() API
     *
     * @param(value)  32b value to be returned in result->hi by the get64() API
     */
    @DirectCall
    Void setMSW(Int value);
internal:
    /*
     *  ======== start ========
     *  1. Hwi_disable();
     *  2. Clear the counters
     *  3. Clear IFR
     *  4. Enable timer interrupt
     *  5. Start timer
     *  6. Hwi_restore()
     */
    Void start();

    /*
     *  ======== stop ========
     *  1. stop timer
     *  2. disable timer interrupt
     */
    Void stop();

    struct Module_State {
        Int timerMSW;
        Ptr timerBaseAdrs;
        Ptr timer;
    };
}
