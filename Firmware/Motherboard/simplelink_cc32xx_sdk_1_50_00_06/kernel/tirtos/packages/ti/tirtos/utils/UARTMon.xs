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
 *  ======== UARTMon.xs ========
 */

function module$use()
{
    var Task = xdc.useModule('ti.sysbios.knl.Task');
    var UartMon = xdc.module('ti.tirtos.utils.UARTMon');

    var taskParams = new Task.Params();
    taskParams.instance.name = "UARTMonTask";
    taskParams.stackSize = UartMon.stackSize;
    taskParams.priority = UartMon.priority;
    taskParams.arg0 = UartMon.index;
    taskParams.arg1 = UartMon.baudRate;
    Program.global.UARTMon_taskHandle = Task.create("&UARTMon_taskFxn", taskParams);
}


/*
 *  ======== viewInitBasic ========
 */
function viewInitBasic(view)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var viewElem = Program.newViewStruct('ti.tirtos.utils.UARTMon', 'Basic');

    var taskView = Program.scanInstanceView('ti.sysbios.knl.Task', 'Basic');
    for(var elem in taskView) {
       if(taskView[elem].label == "UARTMonTask") {
           viewElem.uartIndex = Number(taskView[elem].arg0).toString(10);
           viewElem.baudRate = Number(taskView[elem].arg1).toString(10);
           viewElem.taskHandle = taskView[elem].address;
           break;
       }
    }

    var eventViews = new Array();
    eventViews[eventViews.length] = viewElem;

    view.elements = eventViews;

}
