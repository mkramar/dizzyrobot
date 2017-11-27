include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>


// intersection() {
	union() {
		moldMoldA(thighBoltPositions, thighLockPositions, [0, -90, 0], boxToPart, boxSize){
			thighShell("outer");		// 0
			thighShell("inner");		// 1
			
			thighStructPlus();			// 2
			thighStructMinusInner();	// 3
			thighStructMinusOuter();	// 4
			
			//

			thighPour();				// 7
			thighBoxAdjustment();		// 8
		}

		//translate(boxToPart) boxBorderA(boxSize);
	}
	
	// translate([-100, -100, -20])
		// cube ([100, 100, 100]);
// }