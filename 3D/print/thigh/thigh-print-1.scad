include <thigh-print.scad>
include <../../lib/cut.scad>
include <../../lib/moldFramework.scad>

//$fn = 50;

rotate([0, 90, 0])
cutA(thighBoltPositions){
	thighShell("outer");
	thighShell("inner");
	thighStructPlus();
	thighStructMinus();
	cut();
}

// mirror([0, 0, 1]) {
	// cutBolts(boltPositions){
		// rotate([0, -90, 0]) thigh();
		// rotate([0, -90, 0]) cut();
		// rotate([0, -90, 0]) thighShell("outer");
	// }
// }
