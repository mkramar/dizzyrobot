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

public class ti_tirtos_productview
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
        Global.callFxn("loadPackage", xdcO, "xdc");
        Global.callFxn("loadPackage", xdcO, "xdc.corevers");
        Global.callFxn("loadPackage", xdcO, "xdc.tools.product");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.tirtos.productview.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.tirtos.productview", new Value.Obj("ti.tirtos.productview", pkgP));
    }

    void TIRTOSProductView$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.tirtos.productview.TIRTOSProductView.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.tirtos.productview.TIRTOSProductView", new Value.Obj("ti.tirtos.productview.TIRTOSProductView", po));
        pkgV.bind("TIRTOSProductView", vo);
        // decls 
        om.bind("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", om.findStrict("xdc.tools.product.IProductView.ProductElemDesc", "ti.tirtos.productview"));
    }

    void TIRTOSProductView$$CONSTS()
    {
        // module TIRTOSProductView
    }

    void TIRTOSProductView$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void TIRTOSProductView$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TIRTOSProductView$$SIZES()
    {
    }

    void TIRTOSProductView$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/tirtos/productview/TIRTOSProductView.xs");
        om.bind("ti.tirtos.productview.TIRTOSProductView$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.tirtos.productview.TIRTOSProductView.Module", "ti.tirtos.productview");
        po.init("ti.tirtos.productview.TIRTOSProductView.Module", om.findStrict("xdc.tools.product.IProductView.Module", "ti.tirtos.productview"));
                po.addFld("$hostonly", $$T_Num, 1, "r");
        po.addFld("homeModule", $$T_Str, "ti.tirtos.TIRTOS", "wh");
        po.addFld("linksToArray", new Proto.Arr($$T_Str, false), Global.newArray(new Object[]{"com.ti.rtsc.SYSBIOS", "com.ti.rtsc.NDK", "com.ti.uia"}), "wh");
        po.addFld("ti_tirtos_TIRTOS", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("ti_tirtos_utils_UARTMon", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("ti_drivers_Config", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("ti_uia", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("ti_bios", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("ti_ndk", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("driverGroup", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("systemProvidersGroup", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("monitors", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("productGroup", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        po.addFld("tirtosProduct", (Proto)om.findStrict("ti.tirtos.productview.TIRTOSProductView.ProductElemDesc", "ti.tirtos.productview"), $$DEFAULT, "wh");
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.tirtos.productview.TIRTOSProductView$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.tirtos.productview.TIRTOSProductView$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.tirtos.productview.TIRTOSProductView$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
                fxn = Global.get(cap, "getProductDescriptor");
                if (fxn != null) po.addFxn("getProductDescriptor", (Proto.Fxn)om.findStrict("xdc.tools.product.IProductView$$getProductDescriptor", "ti.tirtos.productview"), fxn);
    }

    void TIRTOSProductView$$ROV()
    {
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.tirtos.productview.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.tirtos.productview"));
        pkgP.bind("$capsule", $$UNDEF);
        pkgV.init2(pkgP, "ti.tirtos.productview", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.tirtos.productview");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.tirtos.productview.");
        pkgV.bind("$vers", Global.newArray());
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.tirtos.productview'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("if ('ti.tirtos.productview$$stat$base' in xdc.om) {\n");
            sb.append("pkg.packageBase = xdc.om['ti.tirtos.productview$$stat$base'];\n");
            sb.append("pkg.packageRepository = xdc.om['ti.tirtos.productview$$stat$root'];\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
        sb.append("];\n");
        Global.eval(sb.toString());
    }

    void TIRTOSProductView$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.tirtos.productview.TIRTOSProductView", "ti.tirtos.productview");
        po = (Proto.Obj)om.findStrict("ti.tirtos.productview.TIRTOSProductView.Module", "ti.tirtos.productview");
        vo.init2(po, "ti.tirtos.productview.TIRTOSProductView", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.tirtos.productview.TIRTOSProductView$$capsule", "ti.tirtos.productview"));
        vo.bind("$package", om.findStrict("ti.tirtos.productview", "ti.tirtos.productview"));
        tdefs.clear();
        proxies.clear();
        mcfgs.clear();
        icfgs.clear();
        inherits.clear();
        vo.bind("ProductElemDesc", om.findStrict("xdc.tools.product.IProductView.ProductElemDesc", "ti.tirtos.productview"));
        tdefs.add(om.findStrict("xdc.tools.product.IProductView.ProductElemDesc", "ti.tirtos.productview"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        vo.bind("$$icfgs", Global.newArray(icfgs.toArray()));
        inherits.add("xdc.tools.product");
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.tirtos.productview")).add(vo);
        vo.bind("$$instflag", 0);
        vo.bind("$$iobjflag", 1);
        vo.bind("$$sizeflag", 1);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 1);
        vo.bind("$$romcfgs", "|");
        vo.bind("$$nortsflag", 0);
        Proto.Str ps = (Proto.Str)vo.find("Module_State");
        if (ps != null) vo.bind("$object", ps.newInstance());
        vo.bind("$$meta_iobj", om.has("ti.tirtos.productview.TIRTOSProductView$$instance$static$init", null) ? 1 : 0);
        vo.bind("$$fxntab", Global.newArray());
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.seal("length");
        pkgV.bind("TIRTOSProductView", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TIRTOSProductView");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.tirtos.productview.TIRTOSProductView", "ti.tirtos.productview"));
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.tirtos.productview.TIRTOSProductView")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.tirtos.productview")).add(pkgV);
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
        TIRTOSProductView$$OBJECTS();
        TIRTOSProductView$$CONSTS();
        TIRTOSProductView$$CREATES();
        TIRTOSProductView$$FUNCTIONS();
        TIRTOSProductView$$SIZES();
        TIRTOSProductView$$TYPES();
        if (isROV) {
            TIRTOSProductView$$ROV();
        }//isROV
        $$SINGLETONS();
        TIRTOSProductView$$SINGLETONS();
        $$INITIALIZATION();
    }
}
