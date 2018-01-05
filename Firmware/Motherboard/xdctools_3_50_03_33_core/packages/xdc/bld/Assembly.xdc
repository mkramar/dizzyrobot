/* 
 *  Copyright (c) 2008 Texas Instruments and others.
 *  All rights reserved. This program and the accompanying materials
 *  are made available under the terms of the Eclipse Public License v1.0
 *  which accompanies this distribution, and is available at
 *  http://www.eclipse.org/legal/epl-v10.html
 * 
 *  Contributors:
 *      Texas Instruments - initial implementation
 * 
 * */
/*!
 *  ======== Assembly ========
 *  Partially linked assembly of modules
 *  @_nodoc
 */
metaonly module Assembly {

instance:

    /*!
     *  ======== create ========
     *  @_nodoc
     *  Assemblies should only be created via PackageContents.addAssembly()
     */
    create();

    config String name;
    config String platform;
    config ITarget.Module target;
    config Executable.Attrs attrs;
}
/*
 *  @(#) xdc.bld; 1, 0, 2,0; 8-8-2017 17:29:40; /db/ztree/library/trees/xdc/xdc-D20/src/packages/
 */

