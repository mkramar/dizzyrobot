/* 
 *  Copyright (c) 2014-2017 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 * 
 *  Contributors:
 *      Texas Instruments - initial implementation
 * 
 * */

var M4F;

/*
 *  ======== module$meta$init ========
 */
function module$meta$init()
{
    M4F = this;
}

/*
 *  ======== M4F.compile ========
 */
function compile(goal) {
    if (M4F.targetPkgPath == null) {
        M4F.targetPkgPath = this.$package.packageBase;
    }

    goal.opts.copts += " -I" + M4F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include/newlib-nano " +
        " -I" + M4F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include ";

    goal.opts.cfgcopts += " -I" + M4F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include/newlib-nano " +
        " -I" + M4F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/include ";

    return (this.$super.compile(goal));
}

/*
 *  ======== M4F.link ========
 */
function link(goal)
{
    if (M4F.targetPkgPath == null) {
        M4F.targetPkgPath = this.$package.packageBase;
    }

    goal.opts += " -L" + M4F.targetPkgPath +
        "/libs/install-native/$(GCCTARG)/lib/thumb/v7e-m/fpv4-sp/hard ";

    return(this.$super.link(goal));
}
/*
 *  @(#) gnu.targets.arm; 1, 0, 0,1; 7-27-2017 11:46:58; /db/ztree/library/trees/xdctargets/xdctargets-o04/src/ xlibrary

 */

