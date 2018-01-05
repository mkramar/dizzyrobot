/*
 * Copyright (c) 2015-2016, Texas Instruments Incorporated
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
 *  ======== TIRTOS.xs ========
 */

var driversConfig;
var mwConfig;
var TIRTOS;

/*
 *  ======== module$use ========
 */
function module$use()
{
    TIRTOS = xdc.module('ti.tirtos.TIRTOS');
    driversConfig = xdc.useModule('ti.drivers.Config');
    mwConfig = xdc.useModule('ti.mw.Config');

    TIRTOS.$logWarning("ti.tirtos.TIRTOS module is no longer required to " +
        "configure driver instrumentation.  Please use the ti.drivers.Config" +
        " and ti.mw.Config modules instead.",TIRTOS);

    deprecate();
}

/*
 *  ======== deprecate ========
 *  Give the user a warning if they done a useModule on the driver.
 */
function deprecate()
{
    if (TIRTOS.useEMAC == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useEMAC from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useGPIO == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useGPIO from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useI2C == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useI2C from the .cfg.", TIRTOS);
    }

    if (TIRTOS.usePower == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.usePower from the .cfg.", TIRTOS);
    }

    if (TIRTOS.usePWM == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.usePWM from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useSDSPI == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useSDSPI from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useSPI == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useSPI from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useUART == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useUART from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useUSBMSCHFatFs == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useUSBMSCHFatFs from the .cfg.", TIRTOS);
    }

    if (TIRTOS.useWatchdog == true) {
        TIRTOS.$logWarning("TI-RTOS driver modules have been deprecated and" +
            " replaced by the ti.drivers.Config module." +
            "  Please remove TIRTOS.useWatchdog from the .cfg.", TIRTOS);
    }
}
