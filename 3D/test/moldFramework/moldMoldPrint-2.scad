include <part.scad>
include <../../lib/moldFramework.scad>

$fn = 60;

rotate([0, 180, 0])
moldMoldB(boltPositions, lockPositions, [0, 0, 0], boxToPart, boxSize){
	shell("outer");		// 0
	shell("inner");		// 1
	
	structPlus();			// 2
	structMinusInner();	// 3
	structMinusOuter();	// 4
	
	//

	pour();				// 7
	boxAdjustment();		// 8
}