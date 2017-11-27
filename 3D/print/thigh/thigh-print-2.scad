include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/thigh.scad>
include <../../lib/moldFramework.scad>

include <thigh-print.scad>

//$fn = 50;

cutB([0, -90, 0], thighBoltPositions){
	thighShell("outer");
	thighShell("inner");
	thighStructPlus();
	thighStructMinus();
	thighPrintCut();
}

// cutNuts(boltPositions){
	// rotate([0, -90, 0])thigh();
	// rotate([0, -90, 0])cut();
	// rotate([0, -90, 0]) thighShell("outer");
// }
