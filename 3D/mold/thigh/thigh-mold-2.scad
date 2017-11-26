include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>

// difference() {
rotate([180, 0, 0])
moldMoldB(thighBoltPositions, thighLockPositions, boxToPart, boxSize){
	rotate([0, -90, 0]) thighShell("outer");		// 0
	rotate([0, -90, 0]) thighShell("inner");		// 1
	
	rotate([0, -90, 0]) thighStructPlus();			// 2
	rotate([0, -90, 0]) thighStructMinusInner();	// 3
	rotate([0, -90, 0]) thighStructMinusOuter();	// 4
	
	//
	
	thighPour();									// 8
	thighBoxAdjustment();							// 9
}



// translate([0, -10, -50])
// cube([200, 200, 100]);
// }