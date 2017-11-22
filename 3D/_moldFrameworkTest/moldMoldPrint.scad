include <part.scad>
include <framework.scad>

$fn = 60;

moldMoldA(boltPositions, lockPositions){
	translate(partToBox) shell("outer");
	translate(partToBox) shell("inner");
	
	translate(partToBox) structPlus();
	translate(partToBox) structMinus();
	
	boxBottomA(boxSize);
	boxVolumeA(boxSize);
}

//

// boxBorderA(boxSize);		

//

// rotate([0, 180, 0])
// moldMoldB(boltPositions, lockPositions){
	// shell("outer");
	// shell("inner");
	
	// structPlus();
	// structMinus();
	
	// translate(boxOffset) boxBottomB(boxSize);
	// translate(boxOffset) boxVolumeB(boxSize);
// }

//

// rotate([0, 180, 0])
// translate(boxOffset) boxBorderB(boxSize);			
