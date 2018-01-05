/*
 * Copyright (c) 2014, Texas Instruments Incorporated
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
 *  ======== UARTMon.xdc ========
 */
import xdc.rov.ViewInfo;

/*!
 *  ======== UARTMon ========
 *  UART Monitor
 *
 *  The UARTMon module (ti.tirtos.utils.UARTMon) enables host communication with
 *  a target device using the target's UART. The target device can respond to
 *  requests to read and write memory at specified addresses. CCS includes
 *  features that allow you to leverage this utility to monitor the target
 *  device with the Debug view or with GUI Composer.
 *
 *  See the TI-RTOS User's Guide for more information.
 */

@NoRuntime
@HeaderName("")

module UARTMon {
    /*!
     *  Board UART index.
     *
     *  Consult Board.h to find the index of the UART
     *  peripherals available for your board.
     *  By default UART0 is used.
     */
    metaonly config Int index = 0;

    /*!
     *  UART baudrate.
     *
     *  Baudrate for uart peripheral used by the monitor.
     *  Default is 9600.
     */
    metaonly config UInt32 baudRate = 9600;

    /*!
     *  Monitor task priority.
     *
     *  This is the priority of the uart monitor task. To
     *  prevent monitor from running at BIOS startup, set
     *  priority to -1 and call Task_setPri(monitorTask, 1)
     *  in your target code to activate the monitor.
     *  Default is 1.
     */
    metaonly config UInt priority = 1;

    /*!
     *  Monitor stack size.
     *
     *  This is the stack size of the monitor task.
     *  Default value is 0, which means that default stack
     *  size of that target family is used.
     */
    metaonly config SizeT stackSize = 0;

    /*!
     *  @_nodoc
     *  ======== BasicView ========
     */
    metaonly struct BasicView {
        String              uartIndex;
        String              baudRate;
        String              taskHandle;
    };

    /*!
     *  @_nodoc
     *  ========= rovViewInfo =======
     *
     */
     @Facet
     metaonly config ViewInfo.Instance rovViewInfo =
         ViewInfo.create({
             viewMap: [
                 ['Basic',
                     {
                          type: ViewInfo.MODULE_DATA,
                          viewInitFxn: 'viewInitBasic',
                          structName:  'BasicView'
                     }
                 ],
              ]
         });
}
