/*
 * Copyright (c) 2015, Texas Instruments Incorporated
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
 *  ======== TIRTOS.xdc ========
 *  This module is used to tie together the xGConf pages for the various
 *  product components that make up the TI-RTOS.
 */

/*!
 *  ======== TIRTOS ========
 */

metaonly module TIRTOS {
    /*!
     *  ======== LibType ========
     *  TI-RTOS driver library selection options
     *
     *  You can select the library type by setting
     *  the {@link #libType TIRTOS.libType} configuration parameter.
     *
     *  @field(LibType_Instrumented) The library supplied is prebuilt with
     *  logging and assertions enabled.
     *  Diags_USER1 mask logs basic information
     *  Diags_USER2 mask logs more detailed information
     *
     *  @field(LibType_NonInstrumented) The library supplied is prebuilt
     *  with logging and assertions disabled.
     */
    enum LibType {
        LibType_Instrumented,           /*! instrumented (with asserts and logs)*/
        LibType_NonInstrumented         /*! non-instrumented */
    };

    /*!
     *  ======== libType ========
     *  TI-RTOS Driver Library type
     *
     *  The driver library is provided in the form of a library that is
     *  linked with your application.  Two forms of this library are
     *  provided with the TI-RTOS product. This configuration parameter
     *  allows you to select the form of the driver library to use.
     *
     *  The default value of libType is
     *  {@link #LibType_Instrumented TIRTOS_LibType_NonInstrumented}.  For a
     *  complete list of options and what they offer see {@link #LibType}.
     */
    metaonly config LibType libType = LibType_NonInstrumented;

    /*!
     *  ======== useCamera ========
     *  Using Camera driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in.
     *
     *  The default value is false.
     */
    metaonly config Bool useCamera = false;

    /*!
     *  ======== useEMAC ========
     *  Using EMAC driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useEMAC = false;

    /*!
     *  ======== useGPIO ========
     *  Using GPIO driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useGPIO = false;

    /*!
     *  ======== useI2C ========
     *  Using I2C driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useI2C = false;

    /*!
     *  ======== useI2S ========
     *  Using I2S driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in.
     *
     *  The default value is false.
     */
    metaonly config Bool useI2S = false;

    /*!
     *  ======== usePower ========
     *  Using Power driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are automatically pulled in.
     *
     *  The default value is false.
     */
    metaonly config Bool usePower = false;

    /*!
     *  ======== usePWM ========
     *  Using PWM driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool usePWM = false;

    /*!
     *  ======== useSDSPI ========
     *  Using SDSPI driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useSDSPI = false;

    /*!
     *  ======== useSPI ========
     *  Using SPI driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useSPI = false;

    /*!
     *  ======== useUART ========
     *  Using UART driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useUART = false;

    /*!
     *  ======== useUSBMSCHFatFs ========
     *  Using USBMSCHFatFs driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useUSBMSCHFatFs = false;

    /*!
     *  ======== useWatchdog ========
     *  Using Watchdog driver
     *
     *  This config option is deprecated, please use ti.drivers.Config instead.
     *  If set to true, any modules that this driver requires
     *  are  automatically pulled in. Also ROV support for the
     *  driver is enabled.
     *
     *  The default value is false.
     */
    metaonly config Bool useWatchdog = false;
}
