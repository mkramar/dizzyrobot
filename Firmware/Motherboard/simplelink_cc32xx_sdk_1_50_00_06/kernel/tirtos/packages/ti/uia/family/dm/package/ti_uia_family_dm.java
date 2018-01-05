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

public class ti_uia_family_dm
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
        Global.callFxn("loadPackage", xdcO, "xdc.runtime");
        Global.callFxn("loadPackage", xdcO, "ti.uia.runtime");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.uia.family.dm.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.uia.family.dm", new Value.Obj("ti.uia.family.dm", pkgP));
    }

    void TimestampDM816XTimer$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer", new Value.Obj("ti.uia.family.dm.TimestampDM816XTimer", po));
        pkgV.bind("TimestampDM816XTimer", vo);
        // decls 
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", new Proto.Enm("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs"));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", new Proto.Enm("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance"));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", new Proto.Enm("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs"));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$TiocpCfg", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$Tier", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.Tier", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$Twer", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.Twer", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$Tclr", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.Tclr", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$Tsicr", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer$$Module_State", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.Module_State", new Proto.Str(spo, false));
    }

    void TimestampDM816XTimer_Module_GateProxy$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", new Value.Obj("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", po));
        pkgV.bind("TimestampDM816XTimer_Module_GateProxy", vo);
        // decls 
        // insts 
        Object insP = om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", new Proto.Obj());
        po = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Object", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Object", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Params", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Params", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance_State", new Proto.Str(po, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Handle", insP);
        if (isROV) {
            om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Object", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance_State", "ti.uia.family.dm"));
        }//isROV
    }

    void TimestampDM816XTimer$$CONSTS()
    {
        // module TimestampDM816XTimer
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer4", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer4", xdc.services.intern.xsr.Enum.intValue(0x48044000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer5", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer5", xdc.services.intern.xsr.Enum.intValue(0x48046000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer6", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer6", xdc.services.intern.xsr.Enum.intValue(0x48048000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer7", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer7", xdc.services.intern.xsr.Enum.intValue(0x4804A000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer4", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer4", xdc.services.intern.xsr.Enum.intValue(0x08044000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer5", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer5", xdc.services.intern.xsr.Enum.intValue(0x08046000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer6", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer6", xdc.services.intern.xsr.Enum.intValue(0x08048000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer7", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer7", xdc.services.intern.xsr.Enum.intValue(0x0804A000L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_UserConfigured", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_UserConfigured", xdc.services.intern.xsr.Enum.intValue(0L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer4", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer4", xdc.services.intern.xsr.Enum.intValue(4L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer5", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer5", xdc.services.intern.xsr.Enum.intValue(5L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer6", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer6", xdc.services.intern.xsr.Enum.intValue(6L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer7", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer7", xdc.services.intern.xsr.Enum.intValue(7L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer4", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer4", xdc.services.intern.xsr.Enum.intValue(0x4818039CL)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer5", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer5", xdc.services.intern.xsr.Enum.intValue(0x481803A0L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer6", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer6", xdc.services.intern.xsr.Enum.intValue(0x481803A4L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer7", xdc.services.intern.xsr.Enum.make((Proto.Enm)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", "ti.uia.family.dm"), "ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer7", xdc.services.intern.xsr.Enum.intValue(0x481803A8L)+0));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.get32", new Extern("ti_uia_family_dm_TimestampDM816XTimer_get32__E", "xdc_Bits32(*)(xdc_Void)", true, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.get64", new Extern("ti_uia_family_dm_TimestampDM816XTimer_get64__E", "xdc_Void(*)(xdc_runtime_Types_Timestamp64*)", true, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.getFreq", new Extern("ti_uia_family_dm_TimestampDM816XTimer_getFreq__E", "xdc_Void(*)(xdc_runtime_Types_FreqHz*)", true, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.setMSW", new Extern("ti_uia_family_dm_TimestampDM816XTimer_setMSW__E", "xdc_Void(*)(xdc_Int)", true, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.start", new Extern("ti_uia_family_dm_TimestampDM816XTimer_start__I", "xdc_Void(*)(xdc_Void)", true, false));
        om.bind("ti.uia.family.dm.TimestampDM816XTimer.stop", new Extern("ti_uia_family_dm_TimestampDM816XTimer_stop__I", "xdc_Void(*)(xdc_Void)", true, false));
    }

    void TimestampDM816XTimer_Module_GateProxy$$CONSTS()
    {
        // module TimestampDM816XTimer_Module_GateProxy
        om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.query", new Extern("ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_query__E", "xdc_Bool(*)(xdc_Int)", true, false));
    }

    void TimestampDM816XTimer$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void TimestampDM816XTimer_Module_GateProxy$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

        if (isCFG) {
            sb = new StringBuilder();
            sb.append("ti$uia$family$dm$TimestampDM816XTimer_Module_GateProxy$$__initObject = function( inst ) {\n");
                sb.append("if (!this.$used) {\n");
                    sb.append("throw new Error(\"Function ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.create() called before xdc.useModule('ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy')\");\n");
                sb.append("}\n");
            sb.append("};\n");
            Global.eval(sb.toString());
            fxn = (Proto.Fxn)om.bind("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$create", new Proto.Fxn(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Module", "ti.uia.family.dm"), om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", "ti.uia.family.dm"), 1, 0, false));
                        fxn.addArg(0, "__params", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Params", "ti.uia.family.dm"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$dm$TimestampDM816XTimer_Module_GateProxy$$create = function( __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy'];\n");
                sb.append("var __inst = xdc.om['ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance'].$$make();\n");
                sb.append("__inst.$$bind('$package', xdc.om['ti.uia.family.dm']);\n");
                sb.append("__inst.$$bind('$index', __mod.$instances.length);\n");
                sb.append("__inst.$$bind('$category', 'Instance');\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$instances.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', new xdc.om['ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy'].Instance_State);\n");
                sb.append("if (!__mod.delegate$) {\n");
                    sb.append("throw new Error(\"Unbound proxy module: ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy\");\n");
                sb.append("}\n");
                sb.append("var __dmod = __mod.delegate$.$orig;\n");
                sb.append("var __dinst = __dmod.create(__params);\n");
                sb.append("__inst.$$bind('delegate$', __dinst);\n");
                sb.append("var save = xdc.om.$curpkg;\n");
                sb.append("xdc.om.$$bind('$curpkg', __mod.$package.$name);\n");
                sb.append("__mod.instance$meta$init.$fxn.apply(__inst, []);\n");
                sb.append("xdc.om.$$bind('$curpkg', save);\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return __inst;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
    }

    void TimestampDM816XTimer$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TimestampDM816XTimer_Module_GateProxy$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TimestampDM816XTimer$$SIZES()
    {
        Proto.Str so;
        Object fxn;

        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("idlemode", "UInt8"));
        sizes.add(Global.newArray("emufree", "UInt8"));
        sizes.add(Global.newArray("softreset", "UInt8"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tier", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("mat_it_ena", "UInt8"));
        sizes.add(Global.newArray("ovf_it_ena", "UInt8"));
        sizes.add(Global.newArray("tcar_it_ena", "UInt8"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tier']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tier']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tier'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Twer", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("mat_wup_ena", "UInt8"));
        sizes.add(Global.newArray("ovf_wup_ena", "UInt8"));
        sizes.add(Global.newArray("tcar_wup_ena", "UInt8"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Twer']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Twer']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Twer'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tclr", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("ptv", "UInt32"));
        sizes.add(Global.newArray("pre", "UInt8"));
        sizes.add(Global.newArray("ce", "UInt8"));
        sizes.add(Global.newArray("scpwm", "UInt8"));
        sizes.add(Global.newArray("tcm", "UInt16"));
        sizes.add(Global.newArray("trg", "UInt16"));
        sizes.add(Global.newArray("pt", "UInt8"));
        sizes.add(Global.newArray("captmode", "UInt8"));
        sizes.add(Global.newArray("gpocfg", "UInt8"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tclr']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tclr']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tclr'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("sft", "UInt8"));
        sizes.add(Global.newArray("posted", "UInt8"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tsicr']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tsicr']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Tsicr'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Module_State", "ti.uia.family.dm");
        sizes.clear();
        sizes.add(Global.newArray("timerMSW", "TInt"));
        sizes.add(Global.newArray("timerBaseAdrs", "UPtr"));
        sizes.add(Global.newArray("timer", "UPtr"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Module_State']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Module_State']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.dm.TimestampDM816XTimer.Module_State'], fld); }");
        so.bind("$offsetof", fxn);
    }

    void TimestampDM816XTimer_Module_GateProxy$$SIZES()
    {
        Proto.Str so;
        Object fxn;

    }

    void TimestampDM816XTimer$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/dm/TimestampDM816XTimer.xs");
        om.bind("ti.uia.family.dm.TimestampDM816XTimer$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Module", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Module", om.findStrict("ti.uia.runtime.IUIATimestampProvider.Module", "ti.uia.family.dm"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
            po.addFld("timerNumber", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"), om.find("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer7"), "w");
            po.addFld("timerBaseAdrs", new Proto.Adr("xdc_Ptr", "Pv"), null, "w");
            po.addFld("prcmClkMuxBaseAdrs", new Proto.Adr("xdc_Ptr", "Pv"), null, "w");
            po.addFld("prcmClkMuxInitValue", Proto.Elm.newCNum("(xdc_Int)"), 0x0000002L, "w");
            po.addFld("autoStart", $$T_Bool, false, "w");
            po.addFld("maxTimerClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.dm"), Global.newObject("lo", 27000000L, "hi", 0L), "w");
            po.addFld("maxBusClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.dm"), Global.newObject("lo", 27000000L, "hi", 0L), "w");
            po.addFld("tiocpCfg", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", "ti.uia.family.dm"), Global.newObject("idlemode", 0L, "emufree", 0L, "softreset", 1L), "w");
            po.addFld("tier", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tier", "ti.uia.family.dm"), Global.newObject("mat_it_ena", 0L, "ovf_it_ena", 1L, "tcar_it_ena", 0L), "w");
            po.addFld("twer", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Twer", "ti.uia.family.dm"), Global.newObject("mat_wup_ena", 0L, "ovf_wup_ena", 0L, "tcar_wup_ena", 0L), "w");
            po.addFld("tclr", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tclr", "ti.uia.family.dm"), Global.newObject("ptv", 0L, "pre", 0L, "ce", 0L, "scpwm", 0L, "tcm", 0L, "trg", 0L, "pt", 0L, "captmode", 0L, "gpocfg", 0L), "w");
            po.addFld("tsicr", (Proto)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", "ti.uia.family.dm"), Global.newObject("sft", 0L, "posted", 1L), "w");
            po.addFld("canFrequencyBeChanged", $$T_Bool, false, "wh");
            po.addFld("cpuCyclesPerTick", Proto.Elm.newCNum("(xdc_UInt32)"), 0L, "wh");
            po.addFld("canCpuCyclesPerTickBeChanged", $$T_Bool, false, "wh");
            po.addFldV("Module_GateProxy", (Proto)om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.dm"), null, "wh", $$delegGet, $$delegSet);
        }//isCFG
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.uia.family.dm.TimestampDM816XTimer$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.uia.family.dm.TimestampDM816XTimer$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$static$init");
        if (fxn != null) om.bind("ti.uia.family.dm.TimestampDM816XTimer$$module$static$init", true);
        if (fxn != null) po.addFxn("module$static$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.uia.family.dm.TimestampDM816XTimer$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
        // struct TimestampDM816XTimer.TiocpCfg
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$TiocpCfg", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("idlemode", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("emufree", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("softreset", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
        // struct TimestampDM816XTimer.Tier
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tier", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Tier", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("mat_it_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("ovf_it_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("tcar_it_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
        // struct TimestampDM816XTimer.Twer
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Twer", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Twer", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("mat_wup_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("ovf_wup_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("tcar_wup_ena", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
        // struct TimestampDM816XTimer.Tclr
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tclr", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Tclr", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("ptv", Proto.Elm.newCNum("(xdc_Bits32)"), $$UNDEF, "w");
                po.addFld("pre", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("ce", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("scpwm", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("tcm", Proto.Elm.newCNum("(xdc_Bits16)"), $$UNDEF, "w");
                po.addFld("trg", Proto.Elm.newCNum("(xdc_Bits16)"), $$UNDEF, "w");
                po.addFld("pt", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("captmode", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("gpocfg", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
        // struct TimestampDM816XTimer.Tsicr
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tsicr", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("sft", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
                po.addFld("posted", Proto.Elm.newCNum("(xdc_Bits8)"), $$UNDEF, "w");
        // struct TimestampDM816XTimer.Module_State
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Module_State", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer.Module_State", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("timerMSW", Proto.Elm.newCNum("(xdc_Int)"), $$UNDEF, "w");
                po.addFld("timerBaseAdrs", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
                po.addFld("timer", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
    }

    void TimestampDM816XTimer_Module_GateProxy$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Module", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Module", om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.dm"));
                po.addFld("delegate$", (Proto)om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.dm"), null, "wh");
                po.addFld("abstractInstances$", $$T_Bool, false, "wh");
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
        }//isCFG
        if (isCFG) {
                        po.addFxn("create", (Proto.Fxn)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$create", "ti.uia.family.dm"), Global.get("ti$uia$family$dm$TimestampDM816XTimer_Module_GateProxy$$create"));
        }//isCFG
                po.addFxn("queryMeta", (Proto.Fxn)om.findStrict("xdc.runtime.IGateProvider$$queryMeta", "ti.uia.family.dm"), $$UNDEF);
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", om.findStrict("xdc.runtime.IGateProvider.Instance", "ti.uia.family.dm"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.dm"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Params", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Params", om.findStrict("xdc.runtime.IGateProvider$$Params", "ti.uia.family.dm"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.dm"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Object", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Object", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", "ti.uia.family.dm"));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Instance_State", "ti.uia.family.dm");
        po.init("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance_State", null);
        po.addFld("$hostonly", $$T_Num, 0, "r");
    }

    void TimestampDM816XTimer$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer", "ti.uia.family.dm");
        vo.bind("TiocpCfg$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$TiocpCfg", "ti.uia.family.dm");
        vo.bind("Tier$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.Tier", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tier", "ti.uia.family.dm");
        vo.bind("Twer$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.Twer", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Twer", "ti.uia.family.dm");
        vo.bind("Tclr$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.Tclr", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tclr", "ti.uia.family.dm");
        vo.bind("Tsicr$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.Tsicr", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Tsicr", "ti.uia.family.dm");
        vo.bind("Module_State$fetchDesc", Global.newObject("type", "ti.uia.family.dm.TimestampDM816XTimer.Module_State", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$Module_State", "ti.uia.family.dm");
    }

    void TimestampDM816XTimer_Module_GateProxy$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", "ti.uia.family.dm");
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy$$Instance_State", "ti.uia.family.dm");
        po.addFld("__fxns", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.uia.family.dm.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.uia.family.dm"));
        Scriptable cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/dm/package.xs");
        om.bind("xdc.IPackage$$capsule", cap);
        Object fxn;
                fxn = Global.get(cap, "init");
                if (fxn != null) pkgP.addFxn("init", (Proto.Fxn)om.findStrict("xdc.IPackage$$init", "ti.uia.family.dm"), fxn);
                fxn = Global.get(cap, "close");
                if (fxn != null) pkgP.addFxn("close", (Proto.Fxn)om.findStrict("xdc.IPackage$$close", "ti.uia.family.dm"), fxn);
                fxn = Global.get(cap, "validate");
                if (fxn != null) pkgP.addFxn("validate", (Proto.Fxn)om.findStrict("xdc.IPackage$$validate", "ti.uia.family.dm"), fxn);
                fxn = Global.get(cap, "exit");
                if (fxn != null) pkgP.addFxn("exit", (Proto.Fxn)om.findStrict("xdc.IPackage$$exit", "ti.uia.family.dm"), fxn);
                fxn = Global.get(cap, "getLibs");
                if (fxn != null) pkgP.addFxn("getLibs", (Proto.Fxn)om.findStrict("xdc.IPackage$$getLibs", "ti.uia.family.dm"), fxn);
                fxn = Global.get(cap, "getSects");
                if (fxn != null) pkgP.addFxn("getSects", (Proto.Fxn)om.findStrict("xdc.IPackage$$getSects", "ti.uia.family.dm"), fxn);
        pkgP.bind("$capsule", cap);
        pkgV.init2(pkgP, "ti.uia.family.dm", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.uia.family.dm");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.uia.family.dm.");
        pkgV.bind("$vers", Global.newArray(1, 0, 0, 0));
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.uia.family.dm'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("if ('ti.uia.family.dm$$stat$base' in xdc.om) {\n");
            sb.append("pkg.packageBase = xdc.om['ti.uia.family.dm$$stat$base'];\n");
            sb.append("pkg.packageRepository = xdc.om['ti.uia.family.dm$$stat$root'];\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
        sb.append("];\n");
        Global.eval(sb.toString());
    }

    void TimestampDM816XTimer$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer", "ti.uia.family.dm");
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Module", "ti.uia.family.dm");
        vo.init2(po, "ti.uia.family.dm.TimestampDM816XTimer", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer$$capsule", "ti.uia.family.dm"));
        vo.bind("$package", om.findStrict("ti.uia.family.dm", "ti.uia.family.dm"));
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
        mcfgs.add("maxTimerClockFreq");
        mcfgs.add("maxBusClockFreq");
        vo.bind("BaseAdrs", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs", "ti.uia.family.dm"));
        vo.bind("TimerInstance", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance", "ti.uia.family.dm"));
        vo.bind("PrcmClkMuxBaseAdrs", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs", "ti.uia.family.dm"));
        vo.bind("TiocpCfg", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TiocpCfg", "ti.uia.family.dm"));
        vo.bind("Tier", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tier", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tier", "ti.uia.family.dm"));
        vo.bind("Twer", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Twer", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Twer", "ti.uia.family.dm"));
        vo.bind("Tclr", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tclr", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tclr", "ti.uia.family.dm"));
        vo.bind("Tsicr", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Tsicr", "ti.uia.family.dm"));
        mcfgs.add("timerNumber");
        mcfgs.add("timerBaseAdrs");
        mcfgs.add("prcmClkMuxBaseAdrs");
        mcfgs.add("prcmClkMuxInitValue");
        mcfgs.add("autoStart");
        mcfgs.add("tiocpCfg");
        mcfgs.add("tier");
        mcfgs.add("twer");
        mcfgs.add("tclr");
        mcfgs.add("tsicr");
        vo.bind("Module_State", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Module_State", "ti.uia.family.dm"));
        tdefs.add(om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.Module_State", "ti.uia.family.dm"));
        vo.bind("Module_GateProxy$proxy", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", "ti.uia.family.dm"));
        proxies.add("Module_GateProxy");
        vo.bind("BaseAdrs_ARM_Timer4", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer4", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_ARM_Timer5", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer5", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_ARM_Timer6", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer6", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_ARM_Timer7", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_ARM_Timer7", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_C6000_Timer4", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer4", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_C6000_Timer5", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer5", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_C6000_Timer6", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer6", "ti.uia.family.dm"));
        vo.bind("BaseAdrs_C6000_Timer7", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.BaseAdrs_C6000_Timer7", "ti.uia.family.dm"));
        vo.bind("TimerInstance_UserConfigured", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_UserConfigured", "ti.uia.family.dm"));
        vo.bind("TimerInstance_Timer4", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer4", "ti.uia.family.dm"));
        vo.bind("TimerInstance_Timer5", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer5", "ti.uia.family.dm"));
        vo.bind("TimerInstance_Timer6", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer6", "ti.uia.family.dm"));
        vo.bind("TimerInstance_Timer7", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.TimerInstance_Timer7", "ti.uia.family.dm"));
        vo.bind("PrcmClkMuxBaseAdrs_Timer4", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer4", "ti.uia.family.dm"));
        vo.bind("PrcmClkMuxBaseAdrs_Timer5", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer5", "ti.uia.family.dm"));
        vo.bind("PrcmClkMuxBaseAdrs_Timer6", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer6", "ti.uia.family.dm"));
        vo.bind("PrcmClkMuxBaseAdrs_Timer7", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.PrcmClkMuxBaseAdrs_Timer7", "ti.uia.family.dm"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        vo.bind("$$icfgs", Global.newArray(icfgs.toArray()));
        inherits.add("ti.uia.runtime");
        inherits.add("xdc.runtime");
        inherits.add("xdc.runtime");
        inherits.add("xdc.runtime");
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.dm")).add(vo);
        vo.bind("$$instflag", 0);
        vo.bind("$$iobjflag", 0);
        vo.bind("$$sizeflag", 1);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 1);
        vo.bind("$$romcfgs", "|");
        vo.bind("$$nortsflag", 0);
        if (isCFG) {
            Proto.Str ps = (Proto.Str)vo.find("Module_State");
            if (ps != null) vo.bind("$object", ps.newInstance());
            vo.bind("$$meta_iobj", 1);
        }//isCFG
        vo.bind("get32", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.get32", "ti.uia.family.dm"));
        vo.bind("get64", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.get64", "ti.uia.family.dm"));
        vo.bind("getFreq", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.getFreq", "ti.uia.family.dm"));
        vo.bind("setMSW", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.setMSW", "ti.uia.family.dm"));
        vo.bind("start", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.start", "ti.uia.family.dm"));
        vo.bind("stop", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer.stop", "ti.uia.family.dm"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_dm_TimestampDM816XTimer_Module__startupDone__E", "ti_uia_family_dm_TimestampDM816XTimer_get32__E", "ti_uia_family_dm_TimestampDM816XTimer_get64__E", "ti_uia_family_dm_TimestampDM816XTimer_getFreq__E", "ti_uia_family_dm_TimestampDM816XTimer_setMSW__E"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.setElem("", true);
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("MODULE_STARTUP$", 1);
        vo.bind("PROXY$", 0);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("TimestampDM816XTimer", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TimestampDM816XTimer");
    }

    void TimestampDM816XTimer_Module_GateProxy$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", "ti.uia.family.dm");
        po = (Proto.Obj)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Module", "ti.uia.family.dm");
        vo.init2(po, "ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", $$UNDEF);
        vo.bind("Instance", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance", "ti.uia.family.dm"));
        vo.bind("Params", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Params", "ti.uia.family.dm"));
        vo.bind("PARAMS", ((Proto.Str)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Params", "ti.uia.family.dm")).newInstance());
        vo.bind("Handle", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Handle", "ti.uia.family.dm"));
        vo.bind("$package", om.findStrict("ti.uia.family.dm", "ti.uia.family.dm"));
        tdefs.clear();
        proxies.clear();
        proxies.add("delegate$");
        inherits.clear();
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        inherits.add("xdc.runtime");
        inherits.add("xdc.runtime");
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.dm")).add(vo);
        vo.bind("$$instflag", 1);
        vo.bind("$$iobjflag", 0);
        vo.bind("$$sizeflag", 0);
        vo.bind("$$dlgflag", 0);
        vo.bind("$$iflag", 1);
        vo.bind("$$romcfgs", "|");
        vo.bind("$$nortsflag", 0);
        if (isCFG) {
            Proto.Str ps = (Proto.Str)vo.find("Module_State");
            if (ps != null) vo.bind("$object", ps.newInstance());
            vo.bind("$$meta_iobj", 1);
            vo.bind("__initObject", Global.get("ti$uia$family$dm$TimestampDM816XTimer_Module_GateProxy$$__initObject"));
        }//isCFG
        vo.bind("query", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.query", "ti.uia.family.dm"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Handle__label", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Module__startupDone", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Object__create", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Object__delete", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Object__get", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Object__first", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Object__next", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Params__init", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Proxy__abstract", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__Proxy__delegate", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__queryMeta", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__query", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__enter", "ti_uia_family_dm_TimestampDM816XTimer_Module_GateProxy_DELEGATE__leave"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("Object", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Object", "ti.uia.family.dm"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy.Instance_State", "ti.uia.family.dm"));
        vo.bind("MODULE_STARTUP$", 0);
        vo.bind("PROXY$", 1);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("TimestampDM816XTimer_Module_GateProxy", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TimestampDM816XTimer_Module_GateProxy");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
            Object srcP = ((XScriptO)om.findStrict("xdc.runtime.IInstance", "ti.uia.family.dm")).findStrict("PARAMS", "ti.uia.family.dm");
            Scriptable dstP;

            dstP = (Scriptable)((XScriptO)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", "ti.uia.family.dm")).findStrict("PARAMS", "ti.uia.family.dm");
            Global.put(dstP, "instance", srcP);
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer", "ti.uia.family.dm"));
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy", "ti.uia.family.dm"));
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.uia.family.dm.TimestampDM816XTimer")).bless();
        ((Value.Obj)om.getv("ti.uia.family.dm.TimestampDM816XTimer_Module_GateProxy")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.uia.family.dm")).add(pkgV);
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
        TimestampDM816XTimer$$OBJECTS();
        TimestampDM816XTimer_Module_GateProxy$$OBJECTS();
        TimestampDM816XTimer$$CONSTS();
        TimestampDM816XTimer_Module_GateProxy$$CONSTS();
        TimestampDM816XTimer$$CREATES();
        TimestampDM816XTimer_Module_GateProxy$$CREATES();
        TimestampDM816XTimer$$FUNCTIONS();
        TimestampDM816XTimer_Module_GateProxy$$FUNCTIONS();
        TimestampDM816XTimer$$SIZES();
        TimestampDM816XTimer_Module_GateProxy$$SIZES();
        TimestampDM816XTimer$$TYPES();
        TimestampDM816XTimer_Module_GateProxy$$TYPES();
        if (isROV) {
            TimestampDM816XTimer$$ROV();
            TimestampDM816XTimer_Module_GateProxy$$ROV();
        }//isROV
        $$SINGLETONS();
        TimestampDM816XTimer$$SINGLETONS();
        TimestampDM816XTimer_Module_GateProxy$$SINGLETONS();
        $$INITIALIZATION();
    }
}
