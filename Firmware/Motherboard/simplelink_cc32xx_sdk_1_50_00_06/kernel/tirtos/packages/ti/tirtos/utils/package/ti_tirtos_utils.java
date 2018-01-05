/*
 *  Do not modify this file; it is automatically 
 *  generated and any modifications will be overwritten.
 *
 * @(#) xdc-D20
 */
import java.util.*;
import org.mozilla.javascript.*;
import xdc.services.intern.xsr.*;
import xdc.services.spec.Session;

public class ti_tirtos_utils
{
    static final String VERS = "@(#) xdc-D20\n";

    static final Proto.Elm $$T_Bool = Proto.Elm.newBool();
    static final Proto.Elm $$T_Num = Proto.Elm.newNum();
    static final Proto.Elm $$T_Str = Proto.Elm.newStr();
    static final Proto.Elm $$T_Obj = Proto.Elm.newObj();

    static final Proto.Fxn $$T_Met = new Proto.Fxn(null, null, 0, -1, false);
    static final Proto.Map $$T_Map = new Proto.Map($$T_Obj);
    static final Proto.Arr $$T_Vec = new Proto.Arr($$T_Obj);

    static final XScriptO $$DEFAULT = Value.DEFAULT;
    static final Object $$UNDEF = Undefined.instance;

    static final Proto.Obj $$Package = (Proto.Obj)Global.get("$$Package");
    static final Proto.Obj $$Module = (Proto.Obj)Global.get("$$Module");
    static final Proto.Obj $$Instance = (Proto.Obj)Global.get("$$Instance");
    static final Proto.Obj $$Params = (Proto.Obj)Global.get("$$Params");

    static final Object $$objFldGet = Global.get("$$objFldGet");
    static final Object $$objFldSet = Global.get("$$objFldSet");
    static final Object $$proxyGet = Global.get("$$proxyGet");
    static final Object $$proxySet = Global.get("$$proxySet");
    static final Object $$delegGet = Global.get("$$delegGet");
    static final Object $$delegSet = Global.get("$$delegSet");

    Scriptable xdcO;
    Session ses;
    Value.Obj om;

    boolean isROV;
    boolean isCFG;

    Proto.Obj pkgP;
    Value.Obj pkgV;

    ArrayList<Object> imports = new ArrayList<Object>();
    ArrayList<Object> loggables = new ArrayList<Object>();
    ArrayList<Object> mcfgs = new ArrayList<Object>();
    ArrayList<Object> icfgs = new ArrayList<Object>();
    ArrayList<String> inherits = new ArrayList<String>();
    ArrayList<Object> proxies = new ArrayList<Object>();
    ArrayList<Object> sizes = new ArrayList<Object>();
    ArrayList<Object> tdefs = new ArrayList<Object>();

    void $$IMPORTS()
    {
        Global.callFxn("loadPackage", xdcO, "ti.drivers");
        Global.callFxn("loadPackage", xdcO, "xdc");
        Global.callFxn("loadPackage", xdcO, "xdc.corevers");
        Global.callFxn("loadPackage", xdcO, "xdc.rov");
        Global.callFxn("loadPackage", xdcO, "xdc.runtime");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.tirtos.utils.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.tirtos.utils", new Value.Obj("ti.tirtos.utils", pkgP));
    }

    void UARTMon$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.tirtos.utils.UARTMon.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.tirtos.utils.UARTMon", new Value.Obj("ti.tirtos.utils.UARTMon", po));
        pkgV.bind("UARTMon", vo);
        // decls 
        spo = (Proto.Obj)om.bind("ti.tirtos.utils.UARTMon$$BasicView", new Proto.Obj());
        om.bind("ti.tirtos.utils.UARTMon.BasicView", new Proto.Str(spo, false));
    }

    void UARTMon$$CONSTS()
    {
        // module UARTMon
    }

    void UARTMon$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void UARTMon$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void UARTMon$$SIZES()
    {
        Proto.Str so;
        Object fxn;

    }

    void UARTMon$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/tirtos/utils/UARTMon.xs");
        om.bind("ti.tirtos.utils.UARTMon$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.tirtos.utils.UARTMon.Module", "ti.tirtos.utils");
        po.init("ti.tirtos.utils.UARTMon.Module", om.findStrict("xdc.runtime.IModule.Module", "ti.tirtos.utils"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
            po.addFld("index", Proto.Elm.newCNum("(xdc_Int)"), 0L, "wh");
            po.addFld("baudRate", Proto.Elm.newCNum("(xdc_UInt32)"), 9600L, "wh");
            po.addFld("priority", Proto.Elm.newCNum("(xdc_UInt)"), 1L, "wh");
            po.addFld("stackSize", Proto.Elm.newCNum("(xdc_SizeT)"), 0L, "wh");
            po.addFld("rovViewInfo", (Proto)om.findStrict("xdc.rov.ViewInfo.Instance", "ti.tirtos.utils"), $$UNDEF, "wh");
        }//isCFG
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.tirtos.utils.UARTMon$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.tirtos.utils.UARTMon$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$static$init");
        if (fxn != null) om.bind("ti.tirtos.utils.UARTMon$$module$static$init", true);
        if (fxn != null) po.addFxn("module$static$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.tirtos.utils.UARTMon$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
        // struct UARTMon.BasicView
        po = (Proto.Obj)om.findStrict("ti.tirtos.utils.UARTMon$$BasicView", "ti.tirtos.utils");
        po.init("ti.tirtos.utils.UARTMon.BasicView", null);
                po.addFld("$hostonly", $$T_Num, 1, "r");
                po.addFld("uartIndex", $$T_Str, $$UNDEF, "w");
                po.addFld("baudRate", $$T_Str, $$UNDEF, "w");
                po.addFld("taskHandle", $$T_Str, $$UNDEF, "w");
    }

    void UARTMon$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.tirtos.utils.UARTMon", "ti.tirtos.utils");
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.tirtos.utils.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.tirtos.utils"));
        pkgP.bind("$capsule", $$UNDEF);
        pkgV.init2(pkgP, "ti.tirtos.utils", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.tirtos.utils");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.tirtos.utils.");
        pkgV.bind("$vers", Global.newArray());
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        imports.add(Global.newArray("ti.drivers", Global.newArray()));
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.tirtos.utils'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("if ('ti.tirtos.utils$$stat$base' in xdc.om) {\n");
            sb.append("pkg.packageBase = xdc.om['ti.tirtos.utils$$stat$base'];\n");
            sb.append("pkg.packageRepository = xdc.om['ti.tirtos.utils$$stat$root'];\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
            sb.append("'lib/release/ti.tirtos.utils.aem4',\n");
            sb.append("'lib/release/ti.tirtos.utils.am4g',\n");
            sb.append("'lib/release/ti.tirtos.utils.arm4',\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
            sb.append("['lib/release/ti.tirtos.utils.aem4', {target: 'ti.targets.arm.elf.M4', suffix: 'em4'}],\n");
            sb.append("['lib/release/ti.tirtos.utils.am4g', {target: 'gnu.targets.arm.M4', suffix: 'm4g'}],\n");
            sb.append("['lib/release/ti.tirtos.utils.arm4', {target: 'iar.targets.arm.M4', suffix: 'rm4'}],\n");
        sb.append("];\n");
        Global.eval(sb.toString());
    }

    void UARTMon$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.tirtos.utils.UARTMon", "ti.tirtos.utils");
        po = (Proto.Obj)om.findStrict("ti.tirtos.utils.UARTMon.Module", "ti.tirtos.utils");
        vo.init2(po, "ti.tirtos.utils.UARTMon", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.tirtos.utils.UARTMon$$capsule", "ti.tirtos.utils"));
        vo.bind("$package", om.findStrict("ti.tirtos.utils", "ti.tirtos.utils"));
        tdefs.clear();
        proxies.clear();
        mcfgs.clear();
        icfgs.clear();
        inherits.clear();
        mcfgs.add("Module__diagsEnabled");
        icfgs.add("Module__diagsEnabled");
        mcfgs.add("Module__diagsIncluded");
        icfgs.add("Module__diagsIncluded");
        mcfgs.add("Module__diagsMask");
        icfgs.add("Module__diagsMask");
        mcfgs.add("Module__gateObj");
        icfgs.add("Module__gateObj");
        mcfgs.add("Module__gatePrms");
        icfgs.add("Module__gatePrms");
        mcfgs.add("Module__id");
        icfgs.add("Module__id");
        mcfgs.add("Module__loggerDefined");
        icfgs.add("Module__loggerDefined");
        mcfgs.add("Module__loggerObj");
        icfgs.add("Module__loggerObj");
        mcfgs.add("Module__loggerFxn0");
        icfgs.add("Module__loggerFxn0");
        mcfgs.add("Module__loggerFxn1");
        icfgs.add("Module__loggerFxn1");
        mcfgs.add("Module__loggerFxn2");
        icfgs.add("Module__loggerFxn2");
        mcfgs.add("Module__loggerFxn4");
        icfgs.add("Module__loggerFxn4");
        mcfgs.add("Module__loggerFxn8");
        icfgs.add("Module__loggerFxn8");
        mcfgs.add("Object__count");
        icfgs.add("Object__count");
        mcfgs.add("Object__heap");
        icfgs.add("Object__heap");
        mcfgs.add("Object__sizeof");
        icfgs.add("Object__sizeof");
        mcfgs.add("Object__table");
        icfgs.add("Object__table");
        vo.bind("BasicView", om.findStrict("ti.tirtos.utils.UARTMon.BasicView", "ti.tirtos.utils"));
        tdefs.add(om.findStrict("ti.tirtos.utils.UARTMon.BasicView", "ti.tirtos.utils"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        vo.bind("$$icfgs", Global.newArray(icfgs.toArray()));
        inherits.add("xdc.runtime");
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.tirtos.utils")).add(vo);
        vo.bind("$$instflag", 0);
        vo.bind("$$iobjflag", 0);
        vo.bind("$$sizeflag", 1);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 0);
        vo.bind("$$romcfgs", "|");
        vo.bind("$$nortsflag", 1);
        if (isCFG) {
            Proto.Str ps = (Proto.Str)vo.find("Module_State");
            if (ps != null) vo.bind("$object", ps.newInstance());
            vo.bind("$$meta_iobj", 1);
        }//isCFG
        vo.bind("$$fxntab", Global.newArray("ti_tirtos_utils_UARTMon_Module__startupDone__E"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.setElem("", "");
        atmap.seal("length");
        if (isCFG) {
            vo.put("common$", vo, Global.get((Proto.Obj)om.find("xdc.runtime.Defaults.Module"), "noRuntimeCommon$"));
            ((Value.Obj)vo.geto("common$")).seal(null);
        }//isCFG
        vo.bind("MODULE_STARTUP$", 0);
        vo.bind("PROXY$", 0);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("UARTMon", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("UARTMon");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.tirtos.utils.UARTMon", "ti.tirtos.utils"));
        if (isCFG) {
            vo = (Value.Obj)om.findStrict("ti.tirtos.utils.UARTMon", "ti.tirtos.utils");
            Global.put(vo, "rovViewInfo", Global.callFxn("create", (Scriptable)om.find("xdc.rov.ViewInfo"), Global.newObject("viewMap", Global.newArray(new Object[]{Global.newArray(new Object[]{"Basic", Global.newObject("type", om.find("xdc.rov.ViewInfo.MODULE_DATA"), "viewInitFxn", "viewInitBasic", "structName", "BasicView")})}))));
        }//isCFG
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.tirtos.utils.UARTMon")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.tirtos.utils")).add(pkgV);
    }

    public void exec( Scriptable xdcO, Session ses )
    {
        this.xdcO = xdcO;
        this.ses = ses;
        om = (Value.Obj)xdcO.get("om", null);

        Object o = om.geto("$name");
        String s = o instanceof String ? (String)o : null;
        isCFG = s != null && s.equals("cfg");
        isROV = s != null && s.equals("rov");

        $$IMPORTS();
        $$OBJECTS();
        UARTMon$$OBJECTS();
        UARTMon$$CONSTS();
        UARTMon$$CREATES();
        UARTMon$$FUNCTIONS();
        UARTMon$$SIZES();
        UARTMon$$TYPES();
        if (isROV) {
            UARTMon$$ROV();
        }//isROV
        $$SINGLETONS();
        UARTMon$$SINGLETONS();
        $$INITIALIZATION();
    }
}
