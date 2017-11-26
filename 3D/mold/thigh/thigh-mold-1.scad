include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>


// intersection() {
	union() {
		moldMoldA(thighBoltPositions, thighLockPositions, boxToPart, boxSize){
			rotate([0, -90, 0]) thighShell("outer");		// 0
			rotate([0, -90, 0]) thighShell("inner");		// 1
			
			rotate([0, -90, 0]) thighStructPlus();			// 2
			rotate([0, -90, 0]) thighStructMinusInner();	// 3
			rotate([0, -90, 0]) thighStructMinusOuter();	// 4
			
			//

			thighPour();									// 7
			thighBoxAdjustment();							// 8
		}

		//translate(boxToPart) boxBorderA(boxSize);
	}
	
	// translate([-100, -100, -20])
		// cube ([100, 100, 100]);
// }