include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/shin.scad>
include <../../lib/moldFramework.scad>

//$fn = 50;

difference() {
cutA([0, -90, 0], shinBoltPositions){
	shinShell("outer");
	shinShell("inner");
	shinStructPlus();
	shinStructMinus();
	shinPrintCut();
}

translate([shinLength, 0, -100])
cube([100, 100, 100]);
}


//shinMotor();


// mirror([0, 0, 1]) {
	// cutBolts(boltPositions){
		// rotate([0, 90, 0]) shin();
		// rotate([0, 90, 0]) cut();
		// rotate([0, 90, 0]) shinShell("outer");
	// }
// }
