/* 
 *  Copyright (c) 2012-2017 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 * 
 *  Contributors:
 *      Texas Instruments - initial implementation
 * 
 * */

var A15F;

/*
 *  ======== A15.getISAChain ========
 *  A15 implementation for ITarget.getISAChain()
 */
function getISAChain (isa)
{
    var myChain = ["v7A", this.isa];
    var isaIn = (isa == null ? this.isa : isa)

    /* Check if 'isa' belongs to v7A family */
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
    A15F = this;
}

/*
 *  ======== A15F.compile ========
 */
function compile(goal) {
    if (A15F.targetPkgPath == null) {
        A15F.targetPkgPath = this.$package.packageBase;
    }

    goal.opts.copts += " -I" + A15F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include/newlib-nano " +
        " -I" + A15F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include ";

    goal.opts.cfgcopts += " -I" + A15F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include/newlib-nano " +
        " -I" + A15F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include ";

    return (this.$super.compile(goal));
}

/*
 *  ======== A15F.link ========
 */
function link(goal)
{
    if (A15F.targetPkgPath == null) {
        A15F.targetPkgPath = this.$package.packageBase;
    }

    goal.opts += " -L" + A15F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/lib/hard ";

    return(this.$super.link(goal));
}
/*
 *  @(#) gnu.targets.arm; 1, 0, 0,1; 7-27-2017 11:46:57; /db/ztree/library/trees/xdctargets/xdctargets-o04/src/ xlibrary

 */

