include <part.scad>
include <framework.scad>

difference() {
	union() {
		moldMoldA(boltPositions, thighLockPositions){
			translate(partToBox) shell("outer");
			translate(partToBox) shell("inner");
			
			translate(partToBox) structPlus();
			translate(partToBox) structMinus();
			
			boxBottomA(boxSize);
			boxVolumeA(boxSize);
		}

		color("green")
			boxBorderA(boxSize);		
	}
	
	// mirror([1, 0, 0])
	 // translate([14, -30, -20])
		// cube([100, 300, 100]);
}

rotate([0, 180, 0])
translate([100, 0, 0])
difference() {
	union() {
		moldMoldB(boltPositions, thighLockPositions){
			translate(partToBox) shell("outer");
			translate(partToBox) shell("inner");
			
			translate(partToBox) structPlus();
			translate(partToBox) structMinus();
			
			boxBottomB(boxSize);
			boxVolumeB(boxSize);
		}

		color("green")
			boxBorderB(boxSize);			
	}
	
	// translate([14, -30, -21])
		// cube([100, 300, 100]);
}
