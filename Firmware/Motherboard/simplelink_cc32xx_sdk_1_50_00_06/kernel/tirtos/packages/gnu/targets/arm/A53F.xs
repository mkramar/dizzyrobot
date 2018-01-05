/*
 *  Copyright 2017 by Texas Instruments Incorporated.
 *
 */

/*
 * Copyright (c) 2016, Texas Instruments Incorporated
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

var A53F;

/*
 *  ======== A53F.getISAChain ========
 *  A53F implementation for ITarget.getISAChain()
 */
function getISAChain (isa)
{
    var myChain = ["v8A", this.isa];
    var isaIn = (isa == null ? this.isa : isa)

    /* Check if 'isa' belongs to v8A family */
    for (var i = 0; i < myChain.length; i++) {
        if (myChain[i] == isaIn) {
            break;
        }
    }

    if (i == myChain.length) {
        return (null);
    }
    else {
        return (myChain.slice(0, i + 1));
    }
}

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    A53F = this;
}

/*
 *  ======== A53F.compile ========
 */
function compile(goal) {
    if (A53F.targetPkgPath == null) {
        A53F.targetPkgPath = this.$package.packageBase;
    }

//    var ccOpts = A15F.ccOpts.prefix + " " + A15F.cc.opts + " " +
//                 A15F.ccOpts.suffix;

//    if (!ccOpts.match(/--specs=nano\.specs/)) {
//        goal.opts.copts += " --specs=nano.specs ";
//    }

//    goal.opts.copts += " -I" + A53F.targetPkgPath +
//        "/libs/install-native/$(GCCTARG)/include ";

//    goal.opts.cfgcopts += " -I" + A53F.targetPkgPath +
//        "/libs/install-native/$(GCCTARG)/include ";

    return (this.$super.compile(goal));
}

/*
 *  ======== A15F.link ========
 */
function link(goal)
{
    if (A53F.targetPkgPath == null) {
        A53F.targetPkgPath = this.$package.packageBase;
    }

//    goal.opts += " -L" + A53F.targetPkgPath +
//        "/libs/install-native/$(GCCTARG)/lib/fpu ";

    return(this.$super.link(goal));
}
/*
 *  @(#) gnu.targets.arm; 1, 0, 0,1; 7-27-2017 11:46:57; /db/ztree/library/trees/xdctargets/xdctargets-o04/src/ xlibrary

 */

