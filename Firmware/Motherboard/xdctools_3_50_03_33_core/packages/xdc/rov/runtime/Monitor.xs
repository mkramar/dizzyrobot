/*
 *  ======== viewInitModule ========
 *  Initialize the Monitor 'Module' view.
 * 
 * Note: this function will not be called if there is no Monitor state
 *       structure defined; after all, there is no state to read from 
 *       the to initialize obj.
 */
function viewInitModule(view, obj, args)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var Monitor = xdc.useModule('xdc.rov.runtime.Monitor');

    /* find and read the monitor's state structure */
    var modCfg = Program.getModuleConfig('xdc.rov.runtime.Monitor');
    var addr = Program.getSymbolValue(String(modCfg.STATEADDR).substr(1));
    if (addr == -1) {
        throw new Error(Monitor.$name 
                        + ":can't find monitor state structure (STATEADDR) '" 
                        + modCfg.STATEADDR + "'");
        return;
    }
    var state = Program.fetchStruct(Monitor["MonState$fetchDesc"], addr);

    /* set address to the address we actually read; Note: we must use 
     * $$bind() because xdc.rov.Program used $$bind to add address (why?)
     */
    view.$$bind("address", addr); 
    
    /* lookup monitor's read/write functions */
    view.readFxn = Program.lookupFuncName(Number(state.read))[0];
    view.writeFxn = Program.lookupFuncName(Number(state.write))[0];

    /* read monitor's command buffer */
    var len = Number(modCfg.MAXCMDSIZE);
    var buffer = Program.fetchArray(Monitor["UCharBuffer$fetchDesc"],
                                         state.buffer, len);

    /* convert command bytes to character array ca[] */
    var ca = [];
    for (var i = 0; i < len; i++) {
        var code = buffer[i].elem;
        if (code == 0 || code == 10 || code == 13) {
            break;
        }
        ca.push(String.fromCharCode(code));
    }

    /* convert ca[] to string and return it in the module's view struct */
    view.command = ca.join("");
}

/*
 *  ======== viewInitUChar ========
 *  Initialize the Monitor 'UChar' view.
 */
function viewInitUChar(view, args)
{
    var type = {
        name: "UChar",
        cols: 8,
        maus: 1,
        heading: "byte"
    };

    _viewInitData(type, view, args);
}

/*
 *  ======== viewInitBits16 ========
 *  Initialize the Monitor Bits16 view.
 */
function viewInitBits16(view, args)
{
    var type = {
        name: "Bits16",
        cols: 8,
        maus: 2,
        heading: "word"
    };

    _viewInitData(type, view, args);
}

/*
 *  ======== viewInitBits32 ========
 *  Initialize the Monitor Bits32 view.
 */
function viewInitBits32(view, args)
{
    var type = {
        name: "Bits32",
        cols: 4,
        maus: 4,
        heading: "word"
    };

    _viewInitData(type, view, args);
}

/*
 *  ======== viewInitSections ========
 *  Initialize the Monitor 'Sections' view.
 */
function viewInitSections(view, args)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var Monitor = xdc.useModule('xdc.rov.runtime.Monitor');

    /* Retrieve the MemoryImage java object. */
    var Model = xdc.module("xdc.rov.Model");
    var memReader = Model.getMemoryImageInst();

    /* retrieve the sections list to get the current set of regions */
    var sections = memReader.getSections();
    var sectArray = sections.getSectionArray();

    /* ensure unique base addresses */
    var sectHash =  {};
    for (var i = 0; i < sectArray.length; i++) {
        var sect = sectArray[i];
        var max = sect.length;
        if (sectHash[sect.base] == null || sectHash[sect.base] < max) {
            sectHash[sect.base] = max;
        }
    }

    /* sort sections based on base address */
    sectArray = [];
    for (var b in sectHash) {
        sectArray.push({start: Number(b), len: Number(sectHash[b])});
    }
    sectArray.sort(function(a, b) {return (a.start - b.start);});
    
    /* create view elements from sorted section array */
    var count = 0;
    for (var i = 0; i < sectArray.length; i++) {
        var sect = sectArray[i];
        //var elem = new Monitor.SectionView(); /* breaks ROV classic: XDCTOOLS-186 */
        var elem = Program.newViewStruct(Monitor.$name, "Sections");
        elem.name = String(count++);
        elem.start = sect.start;
        elem.len = sect.len;

        elem.end = elem.start + elem.len - 1;
        view.elements.$add(elem);
    }
}

/*
 *  ======== viewInitSymbols ========
 *  Initialize the Monitor 'Symbols' view.
 */
function viewInitSymbols(view, args)
{
    var Program = xdc.useModule('xdc.rov.Program');
    var Monitor = xdc.useModule('xdc.rov.runtime.Monitor');

    /* compute start addr, radius, and type */
    var addr;
    var radius;
    var type;

    if (args == null) {
        return;
    }

    /* parse args for addr, radius, and type values */
    var tokens = args.split(/\s*,\s*/);

    var val = Number(tokens[0]);
    addr = isFinite(val) ? val : addr;

    val = Number(tokens[1] != null ? tokens[1] : 1);
    radius = isFinite(val) ? val : 1;

    val = tokens[2];
    type = 'a';
    if (val != null && val.length > 0) {
        type = val[0];
    }

    var symbolHash = {};
    var start = addr - radius;
    var end = start + 2 * radius;
    for (var test = start; test <= end; test++) {
        var sym;
        var kind = type;
        if (type == 'f') {
            sym = Program.lookupFuncName(test)[0];
        }
        else if (type == 'd') {
            sym = Program.lookupDataSymbol(test)[0];
        }
        else {
            kind = 'f';     /* function symbol */
            sym = Program.lookupFuncName(test)[0];
            var dsym = Program.lookupDataSymbol(test)[0];
            if (sym != null && dsym != null) {
                kind = 'a'; /* absolute symbol of unknown type */
            }
            else if (sym == null) {
                kind = 'd'; /* data symbol */
                sym = dsym;
            }
        }
        if (sym != null && sym != "") {
            symbolHash[test] = {type: kind, name: sym};
        }
    }

    /* sort symbols based on address */
    var symbolArray = [];
    for (var b in symbolHash) {
        var sym = symbolHash[b];
        symbolArray.push({addr: Number(b), name: sym.name, type: sym.type});
    }
    symbolArray.sort(function(a, b) {return (a.addr - b.addr);});
    
    /* create view elements from sorted symbol array */
    var count = 0;
    for (var i = 0; i < symbolArray.length; i++) {
        var symbol = symbolArray[i];
        //var elem = new Monitor.SymbolView(); /* breaks ROV classic: XDCTOOLS-186 */
        var elem = Program.newViewStruct(Monitor.$name, "Symbols");

        elem.name = symbol.name;
        elem.addr = symbol.addr;
        elem.type = symbol.type;

        view.elements.$add(elem);
    }
}

/*
 *  ======== _parseValue ========
 *  Return the numeric value for a string representation of number or symbol
 */
function _parseValue(token)
{
    var result;
    var val;

    /* if it's a number, define result to be its value */
    var digits = "0123456789";
    if (token == null || token.length == 0 || digits.indexOf(token[0]) != -1) {
        val = Number(token);
        if (isFinite(val)) {
            result = val;
        }
    }

    /* if it's not a number, try looking it up in the symbol table */
    if (result == null) {
        val = Program.getSymbolValue(token);
        if (val != -1) {
            result = val;
        }
    }

    /* return our best guess (or undefined) */
    return (result);
}

/*
 *  ======== _viewInitData ========
 *  Initialize the Monitor 'Data' view.
 */
function _viewInitData(type, view, args)
{
    var addr;
    var len;
    var check = true;

    /* compute start addr and len (number of MAUs to display) */
    if (args == null) {
        return;
    }
    else {
        /* parse args for addr, len, and address check values */
        var tokens = args.split(/\s*,\s*/);

        addr = _parseValue(tokens[0]);
        if (addr == null) {
            return;
        }

        var val = Number(tokens[1] != null ? tokens[1] : 1);
        len = isFinite(val) ? val : 1;

        val = tokens[2];
        if (val != null && (val == "0" || val[0] == "f")) {
            check = false;
        }
    }

    if (len == 0) {
        return;
    }

    var Program = xdc.useModule('xdc.rov.Program');
    var Monitor = xdc.useModule('xdc.rov.runtime.Monitor');

    /* Retrieve a buffer's worth of data */
    var buffer = Program.fetchArray(Monitor[type.name + "Buffer$fetchDesc"],
                                         addr, len, check);
    
    /* Create a view of this buffer (in an elem) ... */
    var count = 0;
    do {
        var elem = Program.newViewStruct(Monitor.$name, type.name);
        elem.addr = addr;
        var i;
        for (i = 0; i < type.cols && count < buffer.length; i++, count++) {
            elem[type.heading + i] = buffer[count].elem;
        }
        for (; i < type.cols; i++) {
            Program.displayError(elem, type.heading + i, 
                "N/A - value not read from the target");
        }
        
        /* Add the elem to the list of rows for the <type.name> view */
        view.elements.$add(elem);
        addr += type.cols * type.maus;
    } while (count < buffer.length);
}
