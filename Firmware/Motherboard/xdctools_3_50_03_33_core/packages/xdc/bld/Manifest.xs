/*
 *  ======== getAllFiles ========
 */
function getAllFiles(excludeDirs)
{
    if (xdc.om.$name != "rel") {
        throw new Error(
            "Manifest.getAllFiles can only be called from within a release script");
    }

    /* clear current files list */
    this.files = [];

    /* re-populate based on excludeDirs */
    /* rcl is alredy loaded by the release model initialization rcl.js */
    rcl.getFiles(this.files, excludeDirs);
}
/*
 *  @(#) xdc.bld; 1, 0, 2,0; 8-8-2017 17:29:41; /db/ztree/library/trees/xdc/xdc-D20/src/packages/
 */

