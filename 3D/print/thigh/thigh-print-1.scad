include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/thigh.scad>
include <../../lib/moldFramework.scad>

//$fn = 50;

rotate([0, 180, 0])
cutA([0, -90, 0], thighBoltPositions){
	thighShell("outer");
	thighShell("inner");
	thighStructPlus();
	thighStructMinus();
	thighPrintCut();
}