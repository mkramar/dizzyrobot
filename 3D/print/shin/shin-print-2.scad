include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/shin.scad>
include <../../lib/moldFramework.scad>

//$fn = 50;

rotate([0, 180, 0])
cutB([0, -90, 0], shinBoltPositions){
	shinShell("outer");
	shinShell("inner");
	shinStructPlus();
	shinStructMinus();
	shinPrintCut();
}

// cutNuts(boltPositions){
	// rotate([0, 90, 0]) shin();
	// rotate([0, 90, 0]) cut();
	// rotate([0, 90, 0]) shinShell("outer");
// }

