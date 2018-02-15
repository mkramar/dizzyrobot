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

public class ti_tirtos
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
        Global.callFxn("loadPackage", xdcO, "ti.sysbios");
        Global.callFxn("loadPackage", xdcO, "xdc");
        Global.callFxn("loadPackage", xdcO, "xdc.corevers");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.tirtos.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.tirtos", new Value.Obj("ti.tirtos", pkgP));
    }

    void TIRTOS$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.tirtos.TIRTOS.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.tirtos.TIRTOS", new Value.Obj("ti.tirtos.TIRTOS", po));
        pkgV.bind("TIRTOS", vo);
        // decls 
        om.bind("ti.tirtos.TIRTOS.LibType", new Proto.Enm("ti.tirtos.TIRTOS.LibType"));
    }

    void TIRTOS$$CONSTS()
    {
        // module TIRTOS
        om.bind("ti.tirtos.TIRTOS.LibType_Instrumented", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.tirtos.TIRTOS.LibType", "ti.tirtos"), "ti.tirtos.TIRTOS.LibType_Instrumented", 0));
        om.bind("ti.tirtos.TIRTOS.LibType_NonInstrumented", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.tirtos.TIRTOS.LibType", "ti.tirtos"), "ti.tirtos.TIRTOS.LibType_NonInstrumented", 1));
    }

    void TIRTOS$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void TIRTOS$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TIRTOS$$SIZES()
    {
    }

    void TIRTOS$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/tirtos/TIRTOS.xs");
        om.bind("ti.tirtos.TIRTOS$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.tirtos.TIRTOS.Module", "ti.tirtos");
        po.init("ti.tirtos.TIRTOS.Module", $$Module);
                po.addFld("$hostonly", $$T_Num, 1, "r");
        po.addFld("libType", (Proto)om.findStrict("ti.tirtos.TIRTOS.LibType", "ti.tirtos"), om.find("ti.tirtos.TIRTOS.LibType_NonInstrumented"), "wh");
        po.addFld("useCamera", $$T_Bool, false, "wh");
        po.addFld("useEMAC", $$T_Bool, false, "wh");
        po.addFld("useGPIO", $$T_Bool, false, "wh");
        po.addFld("useI2C", $$T_Bool, false, "wh");
        po.addFld("useI2S", $$T_Bool, false, "wh");
        po.addFld("usePower", $$T_Bool, false, "wh");
        po.addFld("usePWM", $$T_Bool, false, "wh");
        po.addFld("useSDSPI", $$T_Bool, false, "wh");
        po.addFld("useSPI", $$T_Bool, false, "wh");
        po.addFld("useUART", $$T_Bool, false, "wh");
        po.addFld("useUSBMSCHFatFs", $$T_Bool, false, "wh");
        po.addFld("useWatchdog", $$T_Bool, false, "wh");
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.tirtos.TIRTOS$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.tirtos.TIRTOS$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.tirtos.TIRTOS$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
    }

    void TIRTOS$$ROV()
    {
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.tirtos.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.tirtos"));
        Scriptable cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/tirtos/package.xs");
        om.bind("xdc.IPackage$$capsule", cap);
        Object fxn;
                fxn = Global.get(cap, "init");
                if (fxn != null) pkgP.addFxn("init", (Proto.Fxn)om.findStrict("xdc.IPackage$$init", "ti.tirtos"), fxn);
                fxn = Global.get(cap, "close");
                if (fxn != null) pkgP.addFxn("close", (Proto.Fxn)om.findStrict("xdc.IPackage$$close", "ti.tirtos"), fxn);
                fxn = Global.get(cap, "validate");
                if (fxn != null) pkgP.addFxn("validate", (Proto.Fxn)om.findStrict("xdc.IPackage$$validate", "ti.tirtos"), fxn);
                fxn = Global.get(cap, "exit");
                if (fxn != null) pkgP.addFxn("exit", (Proto.Fxn)om.findStrict("xdc.IPackage$$exit", "ti.tirtos"), fxn);
                fxn = Global.get(cap, "getLibs");
                if (fxn != null) pkgP.addFxn("getLibs", (Proto.Fxn)om.findStrict("xdc.IPackage$$getLibs", "ti.tirtos"), fxn);
                fxn = Global.get(cap, "getSects");
                if (fxn != null) pkgP.addFxn("getSects", (Proto.Fxn)om.findStrict("xdc.IPackage$$getSects", "ti.tirtos"), fxn);
        pkgP.bind("$capsule", cap);
        pkgV.init2(pkgP, "ti.tirtos", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.tirtos");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.tirtos.");
        pkgV.bind("$vers", Global.newArray(1, 0, 0));
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        imports.add(Global.newArray("ti.sysbios", Global.newArray()));
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.tirtos'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("if ('ti.tirtos$$stat$base' in xdc.om) {\n");
            sb.append("pkg.packageBase = xdc.om['ti.tirtos$$stat$base'];\n");
            sb.append("pkg.packageRepository = xdc.om['ti.tirtos$$stat$root'];\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
        sb.append("];\n");
        Global.eval(sb.toString());
    }

    void TIRTOS$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.tirtos.TIRTOS", "ti.tirtos");
        po = (Proto.Obj)om.findStrict("ti.tirtos.TIRTOS.Module", "ti.tirtos");
        vo.init2(po, "ti.tirtos.TIRTOS", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.tirtos.TIRTOS$$capsule", "ti.tirtos"));
        vo.bind("$package", om.findStrict("ti.tirtos", "ti.tirtos"));
        tdefs.clear();
        proxies.clear();
        mcfgs.clear();
        icfgs.clear();
        inherits.clear();
        vo.bind("LibType", om.findStrict("ti.tirtos.TIRTOS.LibType", "ti.tirtos"));
        vo.bind("LibType_Instrumented", om.findStrict("ti.tirtos.TIRTOS.LibType_Instrumented", "ti.tirtos"));
        vo.bind("LibType_NonInstrumented", om.findStrict("ti.tirtos.TIRTOS.LibType_NonInstrumented", "ti.tirtos"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        vo.bind("$$icfgs", Global.newArray(icfgs.toArray()));
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.tirtos")).add(vo);
        vo.bind("$$instflag", 0);
        vo.bind("$$iobjflag", 1);
        vo.bind("$$sizeflag", 1);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 0);
        vo.bind("$$romcfgs", "|");
        vo.bind("$$nortsflag", 0);
        Proto.Str ps = (Proto.Str)vo.find("Module_State");
        if (ps != null) vo.bind("$object", ps.newInstance());
        vo.bind("$$meta_iobj", om.has("ti.tirtos.TIRTOS$$instance$static$init", null) ? 1 : 0);
        vo.bind("$$fxntab", Global.newArray());
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.seal("length");
        pkgV.bind("TIRTOS", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TIRTOS");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.tirtos.TIRTOS", "ti.tirtos"));
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.tirtos.TIRTOS")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.tirtos")).add(pkgV);
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
        TIRTOS$$OBJECTS();
        TIRTOS$$CONSTS();
        TIRTOS$$CREATES();
        TIRTOS$$FUNCTIONS();
        TIRTOS$$SIZES();
        TIRTOS$$TYPES();
        if (isROV) {
            TIRTOS$$ROV();
        }//isROV
        $$SINGLETONS();
        TIRTOS$$SINGLETONS();
        $$INITIALIZATION();
    }
}
