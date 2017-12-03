include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>

//$fn = 60;

// difference() {
rotate([180, 0, 0])
moldMoldB(thighBoltPositions, thighLockPositions, [0, -90, 0], boxToPart, boxSize){
	thighShell("outer");		// 0
	thighShell("inner");		// 1
	
	thighStructPlus();			// 2
	thighStructMinusInner();	// 3
	thighStructMinusOuter();	// 4
	
	//
	
	thighPour();				// 8
	thighBoxAdjustment();		// 9
}



// translate([0, -10, -50])
// cube([200, 200, 100]);
// }