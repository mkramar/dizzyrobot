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

public class ti_uia_family_c66
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
        Global.callFxn("loadPackage", xdcO, "ti.uia.runtime");
        Global.callFxn("loadPackage", xdcO, "ti.uia.events");
        Global.callFxn("loadPackage", xdcO, "xdc.runtime");
    }

    void $$OBJECTS()
    {
        pkgP = (Proto.Obj)om.bind("ti.uia.family.c66.Package", new Proto.Obj());
        pkgV = (Value.Obj)om.bind("ti.uia.family.c66", new Value.Obj("ti.uia.family.c66", pkgP));
    }

    void GemTraceSync$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.c66.GemTraceSync.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.c66.GemTraceSync", new Value.Obj("ti.uia.family.c66.GemTraceSync", po));
        pkgV.bind("GemTraceSync", vo);
        // decls 
        om.bind("ti.uia.family.c66.GemTraceSync.ContextType", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType", "ti.uia.family.c66"));
    }

    void TimestampC66XGlobal$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal", new Value.Obj("ti.uia.family.c66.TimestampC66XGlobal", po));
        pkgV.bind("TimestampC66XGlobal", vo);
        // decls 
        spo = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$Module_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Module_State", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", new Proto.Str(spo, false));
        // insts 
        Object insP = om.bind("ti.uia.family.c66.TimestampC66XGlobal.Instance", new Proto.Obj());
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$Object", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Object", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$Params", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Params", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", new Proto.Str(po, false));
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.Handle", insP);
        if (isROV) {
            om.bind("ti.uia.family.c66.TimestampC66XGlobal.Object", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "ti.uia.family.c66"));
        }//isROV
    }

    void TimestampC66XLocal$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal", new Value.Obj("ti.uia.family.c66.TimestampC66XLocal", po));
        pkgV.bind("TimestampC66XLocal", vo);
        // decls 
        spo = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal$$Module_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Module_State", new Proto.Str(spo, false));
        spo = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Instance_State", new Proto.Str(spo, false));
        // insts 
        Object insP = om.bind("ti.uia.family.c66.TimestampC66XLocal.Instance", new Proto.Obj());
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal$$Object", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Object", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal$$Params", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Params", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Instance_State", new Proto.Str(po, false));
        om.bind("ti.uia.family.c66.TimestampC66XLocal.Handle", insP);
        if (isROV) {
            om.bind("ti.uia.family.c66.TimestampC66XLocal.Object", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance_State", "ti.uia.family.c66"));
        }//isROV
    }

    void GemTraceSync_Module_GateProxy$$OBJECTS()
    {
        Proto.Obj po, spo;
        Value.Obj vo;

        po = (Proto.Obj)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Module", new Proto.Obj());
        vo = (Value.Obj)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy", new Value.Obj("ti.uia.family.c66.GemTraceSync_Module_GateProxy", po));
        pkgV.bind("GemTraceSync_Module_GateProxy", vo);
        // decls 
        // insts 
        Object insP = om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", new Proto.Obj());
        po = (Proto.Obj)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Object", new Proto.Obj());
        om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Object", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Params", new Proto.Obj());
        om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Params", new Proto.Str(po, false));
        po = (Proto.Obj)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Instance_State", new Proto.Obj());
        om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance_State", new Proto.Str(po, false));
        om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Handle", insP);
        if (isROV) {
            om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Object", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance_State", "ti.uia.family.c66"));
        }//isROV
    }

    void GemTraceSync$$CONSTS()
    {
        // module GemTraceSync
        om.bind("ti.uia.family.c66.GemTraceSync.injectIntoTrace", new Extern("ti_uia_family_c66_GemTraceSync_injectIntoTrace__E", "xdc_Void(*)(xdc_UInt32,ti_uia_runtime_IUIATraceSyncProvider_ContextType)", true, false));
    }

    void TimestampC66XGlobal$$CONSTS()
    {
        // module TimestampC66XGlobal
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.get32", new Extern("ti_uia_family_c66_TimestampC66XGlobal_get32__E", "xdc_Bits32(*)(xdc_Void)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.get64", new Extern("ti_uia_family_c66_TimestampC66XGlobal_get64__E", "xdc_Void(*)(xdc_runtime_Types_Timestamp64*)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.getFreq", new Extern("ti_uia_family_c66_TimestampC66XGlobal_getFreq__E", "xdc_Void(*)(xdc_runtime_Types_FreqHz*)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XGlobal.setFreq", new Extern("ti_uia_family_c66_TimestampC66XGlobal_setFreq__E", "xdc_Void(*)(xdc_runtime_Types_FreqHz*)", true, false));
    }

    void TimestampC66XLocal$$CONSTS()
    {
        // module TimestampC66XLocal
        om.bind("ti.uia.family.c66.TimestampC66XLocal.get32", new Extern("ti_uia_family_c66_TimestampC66XLocal_get32__E", "xdc_Bits32(*)(xdc_Void)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XLocal.get64", new Extern("ti_uia_family_c66_TimestampC66XLocal_get64__E", "xdc_Void(*)(xdc_runtime_Types_Timestamp64*)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XLocal.getFreq", new Extern("ti_uia_family_c66_TimestampC66XLocal_getFreq__E", "xdc_Void(*)(xdc_runtime_Types_FreqHz*)", true, false));
        om.bind("ti.uia.family.c66.TimestampC66XLocal.setFreq", new Extern("ti_uia_family_c66_TimestampC66XLocal_setFreq__E", "xdc_Void(*)(xdc_runtime_Types_FreqHz*)", true, false));
    }

    void GemTraceSync_Module_GateProxy$$CONSTS()
    {
        // module GemTraceSync_Module_GateProxy
        om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy.query", new Extern("ti_uia_family_c66_GemTraceSync_Module_GateProxy_query__E", "xdc_Bool(*)(xdc_Int)", true, false));
    }

    void GemTraceSync$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

    }

    void TimestampC66XGlobal$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

        if (isCFG) {
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XGlobal$$__initObject = function( inst ) {\n");
                sb.append("if (!this.$used) {\n");
                    sb.append("throw new Error(\"Function ti.uia.family.c66.TimestampC66XGlobal.create() called before xdc.useModule('ti.uia.family.c66.TimestampC66XGlobal')\");\n");
                sb.append("}\n");
                sb.append("var name = xdc.module('xdc.runtime.Text').defineRopeCord(inst.instance.name);\n");
                sb.append("inst.$object.$$bind('__name', name);\n");
                sb.append("this.instance$static$init.$fxn.apply(inst, [inst.$object, inst, inst.$module]);\n");
                sb.append("inst.$seal();\n");
            sb.append("};\n");
            Global.eval(sb.toString());
            fxn = (Proto.Fxn)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$create", new Proto.Fxn(om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module", "ti.uia.family.c66"), om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance", "ti.uia.family.c66"), 1, 0, false));
                        fxn.addArg(0, "__params", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Params", "ti.uia.family.c66"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XGlobal$$create = function( __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.c66.TimestampC66XGlobal'];\n");
                sb.append("var __inst = xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Instance'].$$make();\n");
                sb.append("__inst.$$bind('$package', xdc.om['ti.uia.family.c66']);\n");
                sb.append("__inst.$$bind('$index', __mod.$instances.length);\n");
                sb.append("__inst.$$bind('$category', 'Instance');\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$instances.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', new xdc.om['ti.uia.family.c66.TimestampC66XGlobal'].Instance_State);\n");
                sb.append("for (var __p in __params) __inst[__p] = __params[__p];\n");
                sb.append("var save = xdc.om.$curpkg;\n");
                sb.append("xdc.om.$$bind('$curpkg', __mod.$package.$name);\n");
                sb.append("__mod.instance$meta$init.$fxn.apply(__inst, []);\n");
                sb.append("xdc.om.$$bind('$curpkg', save);\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.c66.TimestampC66XGlobal'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return __inst;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
        if (isCFG) {
            fxn = (Proto.Fxn)om.bind("ti.uia.family.c66.TimestampC66XGlobal$$construct", new Proto.Fxn(om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module", "ti.uia.family.c66"), null, 2, 0, false));
                        fxn.addArg(0, "__obj", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Object", "ti.uia.family.c66"), null);
                        fxn.addArg(1, "__params", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Params", "ti.uia.family.c66"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XGlobal$$construct = function( __obj, __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.c66.TimestampC66XGlobal'];\n");
                sb.append("var __inst = __obj;\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$objects.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', xdc.om['ti.uia.family.c66.TimestampC66XGlobal'].Instance_State.$$make(__inst.$$parent, __inst.$name));\n");
                sb.append("for (var __p in __params) __inst[__p] = __params[__p];\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.c66.TimestampC66XGlobal'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return null;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
    }

    void TimestampC66XLocal$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

        if (isCFG) {
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XLocal$$__initObject = function( inst ) {\n");
                sb.append("if (!this.$used) {\n");
                    sb.append("throw new Error(\"Function ti.uia.family.c66.TimestampC66XLocal.create() called before xdc.useModule('ti.uia.family.c66.TimestampC66XLocal')\");\n");
                sb.append("}\n");
                sb.append("var name = xdc.module('xdc.runtime.Text').defineRopeCord(inst.instance.name);\n");
                sb.append("inst.$object.$$bind('__name', name);\n");
                sb.append("this.instance$static$init.$fxn.apply(inst, [inst.$object, inst, inst.$module]);\n");
                sb.append("inst.$seal();\n");
            sb.append("};\n");
            Global.eval(sb.toString());
            fxn = (Proto.Fxn)om.bind("ti.uia.family.c66.TimestampC66XLocal$$create", new Proto.Fxn(om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module", "ti.uia.family.c66"), om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance", "ti.uia.family.c66"), 1, 0, false));
                        fxn.addArg(0, "__params", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Params", "ti.uia.family.c66"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XLocal$$create = function( __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.c66.TimestampC66XLocal'];\n");
                sb.append("var __inst = xdc.om['ti.uia.family.c66.TimestampC66XLocal.Instance'].$$make();\n");
                sb.append("__inst.$$bind('$package', xdc.om['ti.uia.family.c66']);\n");
                sb.append("__inst.$$bind('$index', __mod.$instances.length);\n");
                sb.append("__inst.$$bind('$category', 'Instance');\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$instances.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', new xdc.om['ti.uia.family.c66.TimestampC66XLocal'].Instance_State);\n");
                sb.append("for (var __p in __params) __inst[__p] = __params[__p];\n");
                sb.append("var save = xdc.om.$curpkg;\n");
                sb.append("xdc.om.$$bind('$curpkg', __mod.$package.$name);\n");
                sb.append("__mod.instance$meta$init.$fxn.apply(__inst, []);\n");
                sb.append("xdc.om.$$bind('$curpkg', save);\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.c66.TimestampC66XLocal'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return __inst;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
        if (isCFG) {
            fxn = (Proto.Fxn)om.bind("ti.uia.family.c66.TimestampC66XLocal$$construct", new Proto.Fxn(om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module", "ti.uia.family.c66"), null, 2, 0, false));
                        fxn.addArg(0, "__obj", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Object", "ti.uia.family.c66"), null);
                        fxn.addArg(1, "__params", (Proto)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Params", "ti.uia.family.c66"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$TimestampC66XLocal$$construct = function( __obj, __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.c66.TimestampC66XLocal'];\n");
                sb.append("var __inst = __obj;\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$objects.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', xdc.om['ti.uia.family.c66.TimestampC66XLocal'].Instance_State.$$make(__inst.$$parent, __inst.$name));\n");
                sb.append("for (var __p in __params) __inst[__p] = __params[__p];\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.c66.TimestampC66XLocal'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return null;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
    }

    void GemTraceSync_Module_GateProxy$$CREATES()
    {
        Proto.Fxn fxn;
        StringBuilder sb;

        if (isCFG) {
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$GemTraceSync_Module_GateProxy$$__initObject = function( inst ) {\n");
                sb.append("if (!this.$used) {\n");
                    sb.append("throw new Error(\"Function ti.uia.family.c66.GemTraceSync_Module_GateProxy.create() called before xdc.useModule('ti.uia.family.c66.GemTraceSync_Module_GateProxy')\");\n");
                sb.append("}\n");
            sb.append("};\n");
            Global.eval(sb.toString());
            fxn = (Proto.Fxn)om.bind("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$create", new Proto.Fxn(om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Module", "ti.uia.family.c66"), om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", "ti.uia.family.c66"), 1, 0, false));
                        fxn.addArg(0, "__params", (Proto)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Params", "ti.uia.family.c66"), Global.newObject());
            sb = new StringBuilder();
            sb.append("ti$uia$family$c66$GemTraceSync_Module_GateProxy$$create = function( __params ) {\n");
                sb.append("var __mod = xdc.om['ti.uia.family.c66.GemTraceSync_Module_GateProxy'];\n");
                sb.append("var __inst = xdc.om['ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance'].$$make();\n");
                sb.append("__inst.$$bind('$package', xdc.om['ti.uia.family.c66']);\n");
                sb.append("__inst.$$bind('$index', __mod.$instances.length);\n");
                sb.append("__inst.$$bind('$category', 'Instance');\n");
                sb.append("__inst.$$bind('$args', {});\n");
                sb.append("__inst.$$bind('$module', __mod);\n");
                sb.append("__mod.$instances.$add(__inst);\n");
                sb.append("__inst.$$bind('$object', new xdc.om['ti.uia.family.c66.GemTraceSync_Module_GateProxy'].Instance_State);\n");
                sb.append("if (!__mod.delegate$) {\n");
                    sb.append("throw new Error(\"Unbound proxy module: ti.uia.family.c66.GemTraceSync_Module_GateProxy\");\n");
                sb.append("}\n");
                sb.append("var __dmod = __mod.delegate$.$orig;\n");
                sb.append("var __dinst = __dmod.create(__params);\n");
                sb.append("__inst.$$bind('delegate$', __dinst);\n");
                sb.append("var save = xdc.om.$curpkg;\n");
                sb.append("xdc.om.$$bind('$curpkg', __mod.$package.$name);\n");
                sb.append("__mod.instance$meta$init.$fxn.apply(__inst, []);\n");
                sb.append("xdc.om.$$bind('$curpkg', save);\n");
                sb.append("__inst.$$bless();\n");
                sb.append("if (xdc.om.$$phase >= 5) xdc.om['ti.uia.family.c66.GemTraceSync_Module_GateProxy'].__initObject(__inst);\n");
                sb.append("__inst.$$bind('$$phase', xdc.om.$$phase);\n");
                sb.append("return __inst;\n");
            sb.append("}\n");
            Global.eval(sb.toString());
        }//isCFG
    }

    void GemTraceSync$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TimestampC66XGlobal$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void TimestampC66XLocal$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void GemTraceSync_Module_GateProxy$$FUNCTIONS()
    {
        Proto.Fxn fxn;

    }

    void GemTraceSync$$SIZES()
    {
        Proto.Str so;
        Object fxn;

    }

    void TimestampC66XGlobal$$SIZES()
    {
        Proto.Str so;
        Object fxn;

        so = (Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module_State", "ti.uia.family.c66");
        sizes.clear();
        sizes.add(Global.newArray("freq", "Sxdc.runtime.Types;FreqHz"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Module_State']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Module_State']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Module_State'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "ti.uia.family.c66");
        sizes.clear();
        sizes.add(Global.newArray("__fxns", "UPtr"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Instance_State']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Instance_State']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.c66.TimestampC66XGlobal.Instance_State'], fld); }");
        so.bind("$offsetof", fxn);
    }

    void TimestampC66XLocal$$SIZES()
    {
        Proto.Str so;
        Object fxn;

        so = (Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module_State", "ti.uia.family.c66");
        sizes.clear();
        sizes.add(Global.newArray("freq", "Sxdc.runtime.Types;FreqHz"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Module_State']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Module_State']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Module_State'], fld); }");
        so.bind("$offsetof", fxn);
        so = (Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance_State", "ti.uia.family.c66");
        sizes.clear();
        sizes.add(Global.newArray("__fxns", "UPtr"));
        so.bind("$$sizes", Global.newArray(sizes.toArray()));
        fxn = Global.eval("function() { return $$sizeof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Instance_State']); }");
        so.bind("$sizeof", fxn);
        fxn = Global.eval("function() { return $$alignof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Instance_State']); }");
        so.bind("$alignof", fxn);
        fxn = Global.eval("function(fld) { return $$offsetof(xdc.om['ti.uia.family.c66.TimestampC66XLocal.Instance_State'], fld); }");
        so.bind("$offsetof", fxn);
    }

    void GemTraceSync_Module_GateProxy$$SIZES()
    {
        Proto.Str so;
        Object fxn;

    }

    void GemTraceSync$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/c66/GemTraceSync.xs");
        om.bind("ti.uia.family.c66.GemTraceSync$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync.Module", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync.Module", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.Module", "ti.uia.family.c66"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
            po.addFldV("Module_GateProxy", (Proto)om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.c66"), null, "wh", $$delegGet, $$delegSet);
        }//isCFG
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.uia.family.c66.GemTraceSync$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.uia.family.c66.GemTraceSync$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$static$init");
        if (fxn != null) om.bind("ti.uia.family.c66.GemTraceSync$$module$static$init", true);
        if (fxn != null) po.addFxn("module$static$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.uia.family.c66.GemTraceSync$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
                fxn = Global.get(cap, "writeUIAMetaData");
                if (fxn != null) po.addFxn("writeUIAMetaData", (Proto.Fxn)om.findStrict("ti.uia.events.IUIAMetaProvider$$writeUIAMetaData", "ti.uia.family.c66"), fxn);
    }

    void TimestampC66XGlobal$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/c66/TimestampC66XGlobal.xs");
        om.bind("ti.uia.family.c66.TimestampC66XGlobal$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Module", om.findStrict("ti.uia.runtime.IUIATimestampProvider.Module", "ti.uia.family.c66"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
            po.addFld("timerBaseAdrs", Proto.Elm.newCNum("(xdc_UInt32)"), 0x023101F0L, "w");
            po.addFld("maxTimerClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
            po.addFld("maxBusClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
            po.addFld("canFrequencyBeChanged", $$T_Bool, false, "wh");
            po.addFld("cpuCyclesPerTick", Proto.Elm.newCNum("(xdc_UInt32)"), 4L, "wh");
            po.addFld("canCpuCyclesPerTickBeChanged", $$T_Bool, false, "wh");
        }//isCFG
        if (isCFG) {
                        po.addFxn("create", (Proto.Fxn)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$create", "ti.uia.family.c66"), Global.get("ti$uia$family$c66$TimestampC66XGlobal$$create"));
                        po.addFxn("construct", (Proto.Fxn)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$construct", "ti.uia.family.c66"), Global.get("ti$uia$family$c66$TimestampC66XGlobal$$construct"));
        }//isCFG
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "instance$meta$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$instance$meta$init", true);
        if (fxn != null) po.addFxn("instance$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$static$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$module$static$init", true);
        if (fxn != null) po.addFxn("module$static$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
        fxn = Global.get(cap, "instance$static$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XGlobal$$instance$static$init", true);
        if (fxn != null) po.addFxn("instance$static$init", $$T_Met, fxn);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Instance", $$Instance);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Params", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Params", $$Params);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Object", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Object", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance", "ti.uia.family.c66"));
        // struct TimestampC66XGlobal.Module_State
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Module_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Module_State", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("freq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
        // struct TimestampC66XGlobal.Instance_State
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", null);
        po.addFld("$hostonly", $$T_Num, 0, "r");
    }

    void TimestampC66XLocal$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/c66/TimestampC66XLocal.xs");
        om.bind("ti.uia.family.c66.TimestampC66XLocal$$capsule", cap);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Module", om.findStrict("ti.uia.runtime.IUIATimestampProvider.Module", "ti.uia.family.c66"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
            po.addFld("maxTimerClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
            po.addFld("maxBusClockFreq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
            po.addFld("canFrequencyBeChanged", $$T_Bool, false, "wh");
            po.addFld("cpuCyclesPerTick", Proto.Elm.newCNum("(xdc_UInt32)"), 1L, "wh");
            po.addFld("canCpuCyclesPerTickBeChanged", $$T_Bool, false, "wh");
        }//isCFG
        if (isCFG) {
                        po.addFxn("create", (Proto.Fxn)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$create", "ti.uia.family.c66"), Global.get("ti$uia$family$c66$TimestampC66XLocal$$create"));
                        po.addFxn("construct", (Proto.Fxn)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$construct", "ti.uia.family.c66"), Global.get("ti$uia$family$c66$TimestampC66XLocal$$construct"));
        }//isCFG
        fxn = Global.get(cap, "module$use");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$module$use", true);
        if (fxn != null) po.addFxn("module$use", $$T_Met, fxn);
        fxn = Global.get(cap, "module$meta$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$module$meta$init", true);
        if (fxn != null) po.addFxn("module$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "instance$meta$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$instance$meta$init", true);
        if (fxn != null) po.addFxn("instance$meta$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$static$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$module$static$init", true);
        if (fxn != null) po.addFxn("module$static$init", $$T_Met, fxn);
        fxn = Global.get(cap, "module$validate");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$module$validate", true);
        if (fxn != null) po.addFxn("module$validate", $$T_Met, fxn);
        fxn = Global.get(cap, "instance$static$init");
        if (fxn != null) om.bind("ti.uia.family.c66.TimestampC66XLocal$$instance$static$init", true);
        if (fxn != null) po.addFxn("instance$static$init", $$T_Met, fxn);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Instance", $$Instance);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Params", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Params", $$Params);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Object", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Object", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance", "ti.uia.family.c66"));
        // struct TimestampC66XLocal.Module_State
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Module_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Module_State", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("freq", (Proto)om.findStrict("xdc.runtime.Types.FreqHz", "ti.uia.family.c66"), $$DEFAULT, "w");
        // struct TimestampC66XLocal.Instance_State
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Instance_State", null);
                po.addFld("$hostonly", $$T_Num, 0, "r");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.TimestampC66XLocal.Instance_State", null);
        po.addFld("$hostonly", $$T_Num, 0, "r");
    }

    void GemTraceSync_Module_GateProxy$$TYPES()
    {
        Scriptable cap;
        Proto.Obj po;
        Proto.Str ps;
        Proto.Typedef pt;
        Object fxn;

        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Module", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Module", om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.c66"));
                po.addFld("delegate$", (Proto)om.findStrict("xdc.runtime.IGateProvider.Module", "ti.uia.family.c66"), null, "wh");
                po.addFld("abstractInstances$", $$T_Bool, false, "wh");
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
        }//isCFG
        if (isCFG) {
                        po.addFxn("create", (Proto.Fxn)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$create", "ti.uia.family.c66"), Global.get("ti$uia$family$c66$GemTraceSync_Module_GateProxy$$create"));
        }//isCFG
                po.addFxn("queryMeta", (Proto.Fxn)om.findStrict("xdc.runtime.IGateProvider$$queryMeta", "ti.uia.family.c66"), $$UNDEF);
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", om.findStrict("xdc.runtime.IGateProvider.Instance", "ti.uia.family.c66"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Params", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Params", om.findStrict("xdc.runtime.IGateProvider$$Params", "ti.uia.family.c66"));
                po.addFld("$hostonly", $$T_Num, 0, "r");
                po.addFld("Q_BLOCKING", Proto.Elm.newCNum("(xdc_Int)"), 1L, "rh");
                po.addFld("Q_PREEMPTING", Proto.Elm.newCNum("(xdc_Int)"), 2L, "rh");
        if (isCFG) {
                        po.addFld("instance", (Proto)om.findStrict("xdc.runtime.IInstance.Params", "ti.uia.family.c66"), $$UNDEF, "w");
        }//isCFG
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Object", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Object", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", "ti.uia.family.c66"));
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Instance_State", "ti.uia.family.c66");
        po.init("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance_State", null);
        po.addFld("$hostonly", $$T_Num, 0, "r");
    }

    void GemTraceSync$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync", "ti.uia.family.c66");
    }

    void TimestampC66XGlobal$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", "ti.uia.family.c66");
        po.addFld("__fxns", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
        vo.bind("Module_State$fetchDesc", Global.newObject("type", "ti.uia.family.c66.TimestampC66XGlobal.Module_State", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Module_State", "ti.uia.family.c66");
        vo.bind("Instance_State$fetchDesc", Global.newObject("type", "ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$Instance_State", "ti.uia.family.c66");
    }

    void TimestampC66XLocal$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", "ti.uia.family.c66");
        po.addFld("__fxns", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
        vo.bind("Module_State$fetchDesc", Global.newObject("type", "ti.uia.family.c66.TimestampC66XLocal.Module_State", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Module_State", "ti.uia.family.c66");
        vo.bind("Instance_State$fetchDesc", Global.newObject("type", "ti.uia.family.c66.TimestampC66XLocal.Instance_State", "isScalar", false));
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$Instance_State", "ti.uia.family.c66");
    }

    void GemTraceSync_Module_GateProxy$$ROV()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy$$Instance_State", "ti.uia.family.c66");
        po.addFld("__fxns", new Proto.Adr("xdc_Ptr", "Pv"), $$UNDEF, "w");
    }

    void $$SINGLETONS()
    {
        pkgP.init("ti.uia.family.c66.Package", (Proto.Obj)om.findStrict("xdc.IPackage.Module", "ti.uia.family.c66"));
        Scriptable cap = (Scriptable)Global.callFxn("loadCapsule", xdcO, "ti/uia/family/c66/package.xs");
        om.bind("xdc.IPackage$$capsule", cap);
        Object fxn;
                fxn = Global.get(cap, "init");
                if (fxn != null) pkgP.addFxn("init", (Proto.Fxn)om.findStrict("xdc.IPackage$$init", "ti.uia.family.c66"), fxn);
                fxn = Global.get(cap, "close");
                if (fxn != null) pkgP.addFxn("close", (Proto.Fxn)om.findStrict("xdc.IPackage$$close", "ti.uia.family.c66"), fxn);
                fxn = Global.get(cap, "validate");
                if (fxn != null) pkgP.addFxn("validate", (Proto.Fxn)om.findStrict("xdc.IPackage$$validate", "ti.uia.family.c66"), fxn);
                fxn = Global.get(cap, "exit");
                if (fxn != null) pkgP.addFxn("exit", (Proto.Fxn)om.findStrict("xdc.IPackage$$exit", "ti.uia.family.c66"), fxn);
                fxn = Global.get(cap, "getLibs");
                if (fxn != null) pkgP.addFxn("getLibs", (Proto.Fxn)om.findStrict("xdc.IPackage$$getLibs", "ti.uia.family.c66"), fxn);
                fxn = Global.get(cap, "getSects");
                if (fxn != null) pkgP.addFxn("getSects", (Proto.Fxn)om.findStrict("xdc.IPackage$$getSects", "ti.uia.family.c66"), fxn);
        pkgP.bind("$capsule", cap);
        pkgV.init2(pkgP, "ti.uia.family.c66", Value.DEFAULT, false);
        pkgV.bind("$name", "ti.uia.family.c66");
        pkgV.bind("$category", "Package");
        pkgV.bind("$$qn", "ti.uia.family.c66.");
        pkgV.bind("$vers", Global.newArray(1, 0, 0, 0));
        Value.Map atmap = (Value.Map)pkgV.getv("$attr");
        atmap.seal("length");
        imports.clear();
        pkgV.bind("$imports", imports);
        StringBuilder sb = new StringBuilder();
        sb.append("var pkg = xdc.om['ti.uia.family.c66'];\n");
        sb.append("if (pkg.$vers.length >= 3) {\n");
            sb.append("pkg.$vers.push(Packages.xdc.services.global.Vers.getDate(xdc.csd() + '/..'));\n");
        sb.append("}\n");
        sb.append("if ('ti.uia.family.c66$$stat$base' in xdc.om) {\n");
            sb.append("pkg.packageBase = xdc.om['ti.uia.family.c66$$stat$base'];\n");
            sb.append("pkg.packageRepository = xdc.om['ti.uia.family.c66$$stat$root'];\n");
        sb.append("}\n");
        sb.append("pkg.build.libraries = [\n");
        sb.append("];\n");
        sb.append("pkg.build.libDesc = [\n");
        sb.append("];\n");
        Global.eval(sb.toString());
    }

    void GemTraceSync$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync.Module", "ti.uia.family.c66");
        vo.init2(po, "ti.uia.family.c66.GemTraceSync", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.uia.family.c66.GemTraceSync$$capsule", "ti.uia.family.c66"));
        vo.bind("$package", om.findStrict("ti.uia.family.c66", "ti.uia.family.c66"));
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
        vo.bind("ContextType", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType", "ti.uia.family.c66"));
        vo.bind("Module_GateProxy$proxy", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy", "ti.uia.family.c66"));
        proxies.add("Module_GateProxy");
        vo.bind("ContextType_Reserved0", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved0", "ti.uia.family.c66"));
        vo.bind("ContextType_SyncPoint", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_SyncPoint", "ti.uia.family.c66"));
        vo.bind("ContextType_ContextChange", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_ContextChange", "ti.uia.family.c66"));
        vo.bind("ContextType_Snapshot", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Snapshot", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved4", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved4", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved5", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved5", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved6", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved6", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved7", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved7", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved8", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved8", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved9", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved9", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved10", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved10", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved11", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved11", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved12", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved12", "ti.uia.family.c66"));
        vo.bind("ContextType_Reserved13", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Reserved13", "ti.uia.family.c66"));
        vo.bind("ContextType_Global32bTimestamp", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_Global32bTimestamp", "ti.uia.family.c66"));
        vo.bind("ContextType_User", om.findStrict("ti.uia.runtime.IUIATraceSyncProvider.ContextType_User", "ti.uia.family.c66"));
        vo.bind("$$tdefs", Global.newArray(tdefs.toArray()));
        vo.bind("$$proxies", Global.newArray(proxies.toArray()));
        vo.bind("$$mcfgs", Global.newArray(mcfgs.toArray()));
        vo.bind("$$icfgs", Global.newArray(icfgs.toArray()));
        inherits.add("ti.uia.runtime");
        inherits.add("ti.uia.events");
        inherits.add("xdc.runtime");
        vo.bind("$$inherits", Global.newArray(inherits.toArray()));
        ((Value.Arr)pkgV.getv("$modules")).add(vo);
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.c66")).add(vo);
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
        vo.bind("injectIntoTrace", om.findStrict("ti.uia.family.c66.GemTraceSync.injectIntoTrace", "ti.uia.family.c66"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_c66_GemTraceSync_Module__startupDone__E", "ti_uia_family_c66_GemTraceSync_injectIntoTrace__E"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("MODULE_STARTUP$", 0);
        vo.bind("PROXY$", 0);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("GemTraceSync", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("GemTraceSync");
    }

    void TimestampC66XGlobal$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module", "ti.uia.family.c66");
        vo.init2(po, "ti.uia.family.c66.TimestampC66XGlobal", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal$$capsule", "ti.uia.family.c66"));
        vo.bind("Instance", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance", "ti.uia.family.c66"));
        vo.bind("Params", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Params", "ti.uia.family.c66"));
        vo.bind("PARAMS", ((Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Params", "ti.uia.family.c66")).newInstance());
        vo.bind("Handle", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Handle", "ti.uia.family.c66"));
        vo.bind("$package", om.findStrict("ti.uia.family.c66", "ti.uia.family.c66"));
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
        mcfgs.add("timerBaseAdrs");
        vo.bind("Module_State", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module_State", "ti.uia.family.c66"));
        tdefs.add(om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Module_State", "ti.uia.family.c66"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "ti.uia.family.c66"));
        tdefs.add(om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "ti.uia.family.c66"));
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
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.c66")).add(vo);
        vo.bind("$$instflag", 1);
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
            vo.bind("__initObject", Global.get("ti$uia$family$c66$TimestampC66XGlobal$$__initObject"));
        }//isCFG
        vo.bind("get32", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.get32", "ti.uia.family.c66"));
        vo.bind("get64", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.get64", "ti.uia.family.c66"));
        vo.bind("getFreq", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.getFreq", "ti.uia.family.c66"));
        vo.bind("setFreq", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.setFreq", "ti.uia.family.c66"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_c66_TimestampC66XGlobal_Handle__label__E", "ti_uia_family_c66_TimestampC66XGlobal_Module__startupDone__E", "ti_uia_family_c66_TimestampC66XGlobal_Object__create__E", "ti_uia_family_c66_TimestampC66XGlobal_Object__delete__E", "ti_uia_family_c66_TimestampC66XGlobal_Object__get__E", "ti_uia_family_c66_TimestampC66XGlobal_Object__first__E", "ti_uia_family_c66_TimestampC66XGlobal_Object__next__E", "ti_uia_family_c66_TimestampC66XGlobal_Params__init__E", "ti_uia_family_c66_TimestampC66XGlobal_get32__E", "ti_uia_family_c66_TimestampC66XGlobal_get64__E", "ti_uia_family_c66_TimestampC66XGlobal_getFreq__E", "ti_uia_family_c66_TimestampC66XGlobal_setFreq__E"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("Object", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Object", "ti.uia.family.c66"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.c66.TimestampC66XGlobal.Instance_State", "ti.uia.family.c66"));
        vo.bind("MODULE_STARTUP$", 1);
        vo.bind("PROXY$", 0);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("TimestampC66XGlobal", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TimestampC66XGlobal");
    }

    void TimestampC66XLocal$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module", "ti.uia.family.c66");
        vo.init2(po, "ti.uia.family.c66.TimestampC66XLocal", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", om.findStrict("ti.uia.family.c66.TimestampC66XLocal$$capsule", "ti.uia.family.c66"));
        vo.bind("Instance", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance", "ti.uia.family.c66"));
        vo.bind("Params", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Params", "ti.uia.family.c66"));
        vo.bind("PARAMS", ((Proto.Str)om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Params", "ti.uia.family.c66")).newInstance());
        vo.bind("Handle", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Handle", "ti.uia.family.c66"));
        vo.bind("$package", om.findStrict("ti.uia.family.c66", "ti.uia.family.c66"));
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
        vo.bind("Module_State", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module_State", "ti.uia.family.c66"));
        tdefs.add(om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Module_State", "ti.uia.family.c66"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance_State", "ti.uia.family.c66"));
        tdefs.add(om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance_State", "ti.uia.family.c66"));
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
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.c66")).add(vo);
        vo.bind("$$instflag", 1);
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
            vo.bind("__initObject", Global.get("ti$uia$family$c66$TimestampC66XLocal$$__initObject"));
        }//isCFG
        vo.bind("get32", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.get32", "ti.uia.family.c66"));
        vo.bind("get64", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.get64", "ti.uia.family.c66"));
        vo.bind("getFreq", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.getFreq", "ti.uia.family.c66"));
        vo.bind("setFreq", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.setFreq", "ti.uia.family.c66"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_c66_TimestampC66XLocal_Handle__label__E", "ti_uia_family_c66_TimestampC66XLocal_Module__startupDone__E", "ti_uia_family_c66_TimestampC66XLocal_Object__create__E", "ti_uia_family_c66_TimestampC66XLocal_Object__delete__E", "ti_uia_family_c66_TimestampC66XLocal_Object__get__E", "ti_uia_family_c66_TimestampC66XLocal_Object__first__E", "ti_uia_family_c66_TimestampC66XLocal_Object__next__E", "ti_uia_family_c66_TimestampC66XLocal_Params__init__E", "ti_uia_family_c66_TimestampC66XLocal_get32__E", "ti_uia_family_c66_TimestampC66XLocal_get64__E", "ti_uia_family_c66_TimestampC66XLocal_getFreq__E", "ti_uia_family_c66_TimestampC66XLocal_setFreq__E"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("Object", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Object", "ti.uia.family.c66"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.c66.TimestampC66XLocal.Instance_State", "ti.uia.family.c66"));
        vo.bind("MODULE_STARTUP$", 1);
        vo.bind("PROXY$", 0);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("TimestampC66XLocal", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("TimestampC66XLocal");
    }

    void GemTraceSync_Module_GateProxy$$SINGLETONS()
    {
        Proto.Obj po;
        Value.Obj vo;

        vo = (Value.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy", "ti.uia.family.c66");
        po = (Proto.Obj)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Module", "ti.uia.family.c66");
        vo.init2(po, "ti.uia.family.c66.GemTraceSync_Module_GateProxy", $$DEFAULT, false);
        vo.bind("Module", po);
        vo.bind("$category", "Module");
        vo.bind("$capsule", $$UNDEF);
        vo.bind("Instance", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance", "ti.uia.family.c66"));
        vo.bind("Params", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Params", "ti.uia.family.c66"));
        vo.bind("PARAMS", ((Proto.Str)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Params", "ti.uia.family.c66")).newInstance());
        vo.bind("Handle", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Handle", "ti.uia.family.c66"));
        vo.bind("$package", om.findStrict("ti.uia.family.c66", "ti.uia.family.c66"));
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
        ((Value.Arr)om.findStrict("$modules", "ti.uia.family.c66")).add(vo);
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
            vo.bind("__initObject", Global.get("ti$uia$family$c66$GemTraceSync_Module_GateProxy$$__initObject"));
        }//isCFG
        vo.bind("query", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.query", "ti.uia.family.c66"));
        vo.bind("$$fxntab", Global.newArray("ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Handle__label", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Module__startupDone", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Object__create", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Object__delete", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Object__get", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Object__first", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Object__next", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Params__init", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Proxy__abstract", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__Proxy__delegate", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__queryMeta", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__query", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__enter", "ti_uia_family_c66_GemTraceSync_Module_GateProxy_DELEGATE__leave"));
        vo.bind("$$logEvtCfgs", Global.newArray());
        vo.bind("$$errorDescCfgs", Global.newArray());
        vo.bind("$$assertDescCfgs", Global.newArray());
        Value.Map atmap = (Value.Map)vo.getv("$attr");
        atmap.setElem("", true);
        atmap.seal("length");
        vo.bind("Object", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Object", "ti.uia.family.c66"));
        vo.bind("Instance_State", om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy.Instance_State", "ti.uia.family.c66"));
        vo.bind("MODULE_STARTUP$", 0);
        vo.bind("PROXY$", 1);
        loggables.clear();
        vo.bind("$$loggables", loggables.toArray());
        pkgV.bind("GemTraceSync_Module_GateProxy", vo);
        ((Value.Arr)pkgV.getv("$unitNames")).add("GemTraceSync_Module_GateProxy");
    }

    void $$INITIALIZATION()
    {
        Value.Obj vo;

        if (isCFG) {
            Object srcP = ((XScriptO)om.findStrict("xdc.runtime.IInstance", "ti.uia.family.c66")).findStrict("PARAMS", "ti.uia.family.c66");
            Scriptable dstP;

            dstP = (Scriptable)((XScriptO)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal", "ti.uia.family.c66")).findStrict("PARAMS", "ti.uia.family.c66");
            Global.put(dstP, "instance", srcP);
            dstP = (Scriptable)((XScriptO)om.findStrict("ti.uia.family.c66.TimestampC66XLocal", "ti.uia.family.c66")).findStrict("PARAMS", "ti.uia.family.c66");
            Global.put(dstP, "instance", srcP);
            dstP = (Scriptable)((XScriptO)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy", "ti.uia.family.c66")).findStrict("PARAMS", "ti.uia.family.c66");
            Global.put(dstP, "instance", srcP);
        }//isCFG
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.c66.GemTraceSync", "ti.uia.family.c66"));
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.c66.TimestampC66XGlobal", "ti.uia.family.c66"));
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.c66.TimestampC66XLocal", "ti.uia.family.c66"));
        Global.callFxn("module$meta$init", (Scriptable)om.findStrict("ti.uia.family.c66.GemTraceSync_Module_GateProxy", "ti.uia.family.c66"));
        Global.callFxn("init", pkgV);
        ((Value.Obj)om.getv("ti.uia.family.c66.GemTraceSync")).bless();
        ((Value.Obj)om.getv("ti.uia.family.c66.TimestampC66XGlobal")).bless();
        ((Value.Obj)om.getv("ti.uia.family.c66.TimestampC66XLocal")).bless();
        ((Value.Obj)om.getv("ti.uia.family.c66.GemTraceSync_Module_GateProxy")).bless();
        ((Value.Arr)om.findStrict("$packages", "ti.uia.family.c66")).add(pkgV);
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
        GemTraceSync$$OBJECTS();
        TimestampC66XGlobal$$OBJECTS();
        TimestampC66XLocal$$OBJECTS();
        GemTraceSync_Module_GateProxy$$OBJECTS();
        GemTraceSync$$CONSTS();
        TimestampC66XGlobal$$CONSTS();
        TimestampC66XLocal$$CONSTS();
        GemTraceSync_Module_GateProxy$$CONSTS();
        GemTraceSync$$CREATES();
        TimestampC66XGlobal$$CREATES();
        TimestampC66XLocal$$CREATES();
        GemTraceSync_Module_GateProxy$$CREATES();
        GemTraceSync$$FUNCTIONS();
        TimestampC66XGlobal$$FUNCTIONS();
        TimestampC66XLocal$$FUNCTIONS();
        GemTraceSync_Module_GateProxy$$FUNCTIONS();
        GemTraceSync$$SIZES();
        TimestampC66XGlobal$$SIZES();
        TimestampC66XLocal$$SIZES();
        GemTraceSync_Module_GateProxy$$SIZES();
        GemTraceSync$$TYPES();
        TimestampC66XGlobal$$TYPES();
        TimestampC66XLocal$$TYPES();
        GemTraceSync_Module_GateProxy$$TYPES();
        if (isROV) {
            GemTraceSync$$ROV();
            TimestampC66XGlobal$$ROV();
            TimestampC66XLocal$$ROV();
            GemTraceSync_Module_GateProxy$$ROV();
        }//isROV
        $$SINGLETONS();
        GemTraceSync$$SINGLETONS();
        TimestampC66XGlobal$$SINGLETONS();
        TimestampC66XLocal$$SINGLETONS();
        GemTraceSync_Module_GateProxy$$SINGLETONS();
        $$INITIALIZATION();
    }
}
