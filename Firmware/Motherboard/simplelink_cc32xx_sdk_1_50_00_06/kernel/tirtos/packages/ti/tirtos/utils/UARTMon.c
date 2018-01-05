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
 *  ======== UARTMON.c ========
 */

#include <xdc/std.h>
#include <xdc/runtime/Log.h>
#include <ti/sysbios/knl/Task.h>
#include <ti/drivers/UART.h>
#include <string.h>
#include <stdint.h>

#define CMDSIZE 5

#define ERRORSTATUS 0xFF
#define READCMD 0xC0
#define WRITECMD 0x80
#define BYTE      1

/*
 *  ======== UARTMon_taskFxn ========
 *
 *  arg0 - Board UART index
 *  arg1 - UART baudrate
 *
 */

Void UARTMon_taskFxn(UArg arg0, UArg arg1)
{
    UART_Handle uart;
    UART_Params uartParams;
    uint8_t input[CMDSIZE];
    uint8_t cmd;
    uint8_t length;
    volatile unsigned int address;

    /* Initialize and open UART */
    UART_Params_init(&uartParams);
    uartParams.writeDataMode = UART_DATA_BINARY;
    uartParams.readDataMode = UART_DATA_BINARY;
    uartParams.readReturnMode = UART_RETURN_FULL;
    uartParams.readEcho = UART_ECHO_OFF;
    uartParams.baudRate = (uint32_t)arg1;
    uart = UART_open((unsigned int)arg0, (UART_Params *) &uartParams);
    if (uart == NULL) {
        Log_error0("UARTMon: UART open failed!");
        Task_exit();
    }

    while (UART_read(uart, input, sizeof(input)) > 0) {
        /* first byte is the command (2-bits) and length (6-bits) */
        cmd = input[0] & 0xC0;
        length = input[0] & 0x3f;

        /* last 4 bytes are a 32-bit big-endian address */
        address =                input[1];
        address = address << 8 | input[2];
        address = address << 8 | input[3];
        address = address << 8 | input[4];

        switch (cmd) {
            case READCMD:
            /* send the cmd + length byte back as status */
            if (!UART_write(uart, input, BYTE)) {
                Log_error0("UARTMon: UART write failed");
            }

            /*
             * write the data to the host by using requested
             * address as I/O buffer
             */
            if (!UART_write(uart, (void *)address, length)) {
                Log_error0("UARTMon: UART write failed");
            }
            break;

            case WRITECMD:
            /* write the data from host to the memory directly */
            if (!UART_read(uart, (void *)address, length)) {
                Log_error0("UARTMon: UART read failed");
            }

            /* send the cmd + length byte back as status */
            if (!UART_write(uart, input, BYTE)) {
                Log_error0("UARTMon: UART write failed");
            }
            break;

            default:
            Log_error1("Unrecognized command: %d\n", cmd);
            input[0] = ERRORSTATUS;
            if (!UART_write(uart, input, BYTE)) {
                Log_error0("UARTMon: UART write failed");
            }
            break;
        }
    }
}
