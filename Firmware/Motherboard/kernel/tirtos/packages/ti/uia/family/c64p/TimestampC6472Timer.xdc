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
 * ======== TimestampC6472Timer.xdc ========
 */
package ti.uia.family.c64p;

import xdc.runtime.Types;

/*!
 *  ======== TimestampC6472Timer.xdc ========
 *  Implementation of `{@link ITimestampProvider}` using C6472 General purpose
 *    64b timer
 */
@ModuleStartup
module TimestampC6472Timer inherits ti.uia.runtime.IUIATimestampProvider {

    /*!
     * ======== TimerInstance ========
     * Enumeration that defines the base addresses for each timer instance
     *  of the TMS6472 device.
     */
    enum TimerInstance {
    TimerInstance_Timer0 = 0x025E0000,
    TimerInstance_Timer1 = 0x025F0000,
    TimerInstance_Timer2 = 0x02600000,
    TimerInstance_Timer3 = 0x02610000,
    TimerInstance_Timer4 = 0x02620000,
    TimerInstance_Timer5 = 0x02630000,
    TimerInstance_Timer6 = 0x02640000,
    TimerInstance_Timer7 = 0x02650000,
    TimerInstance_Timer8 = 0x02660000,
    TimerInstance_Timer9 = 0x02670000,
    TimerInstance_Timer10 = 0x02680000,
    TimerInstance_Timer11 = 0x02690000
    };

    /*!
     * ======== timerBaseAdrs ========
     * Base address of the timer to be used as the global timer that provides
     *  a common time reference for all CPUs.
     *
     * This timer will be used to enable multicore event correlation.
     */
    config TimerInstance timerBaseAdrs = TimerInstance_Timer11;

    /*!
     * ======== maxTimerClockFreq =========
     * The highest timer clock frequency.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     */
    override config Types.FreqHz maxTimerClockFreq;


    /*!
     * ======== maxBusClockFreq =========
     * The highest bus clock frequency used to drive the timer.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     */
    override config Types.FreqHz maxBusClockFreq;

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
    override metaonly config UInt32 cpuCyclesPerTick = 6;


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

instance:
}
