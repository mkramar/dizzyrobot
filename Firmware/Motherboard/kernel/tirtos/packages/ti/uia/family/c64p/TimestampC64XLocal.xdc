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
 * ======== TimestampC64XLocal.xdc ========
 */
package ti.uia.family.c64p;

import xdc.runtime.Types;

/*!
 *  ======== TimestampC64XLocal.xdc ========
 *  Implementation of `{@link ITimestampProvider}` for the C64X ISA's internal timestamp.
 *
 *  Assigning an instance of this module to the ti.uia.runtime.LogSync
 *  module's CpuTimestampProxy provides a way for applications to notify
 *  System Analyzer about CPU frequency changes, so that multicore event
 *  correlation properly accounts for the change in CPU frequency.
 *  @p
 *  Whenever a SyncPoint event is logged, the LogSync module will use the information
 *  stored in this module's Module_state as the CPU clock frequency information.
 */
@ModuleStartup
module TimestampC64XLocal inherits ti.uia.runtime.IUIATimestampProvider {


    /*!
     * ======== maxTimerClockFreq =========
     * The highest timer clock frequency.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     * By default, this will be set to the CPU speed defined in the Platform.xdc
     * file that is part of the platform specified in the build settings.
     *
     * @a(Examples)
     * Example: The following is an example of the configuration script used
     * to configure the frequency for a value of 700 MHz:
     * @p(code)
     * var TimestampC64XLocal = xdc.useModule('ti.uia.family.c64p.TimestampC64XLocal');
     * TimestampC64XLocal.maxTimerClockFreq = {lo:700000000,hi:0};
     * @p
     *
     */
    override config Types.FreqHz maxTimerClockFreq;


    /*!
     * ======== maxBusClockFreq =========
     * The highest bus clock frequency used to drive the timer.
     *
     * The default ticks per second rate of the timer is calculated by dividing
     * the timer's bus clock frequency by the cyclesPerTick config parameter.
     * By default, this will be set to the CPU speed defined in the Platform.xdc
     * file that is part of the platform specified in the build settings.
     *
     * @a(Examples)
     * Example: The following is an example of the configuration script used
     * to configure the frequency for a value of 700 MHz:
     * @p(code)
     * var TimestampC64XLocal = xdc.useModule('ti.uia.family.c64p.TimestampC64XLocal');
     * TimestampC64XLocal.maxBusClockFreq = {lo:700000000,hi:0};
     * @p
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
    override metaonly config UInt32 cpuCyclesPerTick = 1;


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

    /*!
     *  ======== setFreq ========
     *  Set the timestamp timer's frequency (in Hz)
     *
     *  @param(freq)  pointer to a 64-bit input value
     *
     *      This parameter is a pointer to a structure representing a 64-bit
     *      wide frequency value where the timer's frequency (in Hz)
     *      is written; see `{@link xdc.runtime.Types#FreqHz}`.
     *      This function provides a way of updating the timestamp
     *      data that is logged with a sync point event.
     *
     *  @see #getFreq
     */
    @DirectCall
    Void setFreq(Types.FreqHz *freq);

instance:


internal:
    struct Module_State {
        Types.FreqHz freq;
    };
}
