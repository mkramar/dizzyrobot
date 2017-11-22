include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>



moldMoldA(thighBoltPositions, lockPositions){
	translate(partUp) rotate([0, -90, 0]) thighShell("outer");
	translate(partUp) rotate([0, -90, 0]) thighShell("inner");
	
	translate(partUp) rotate([0, -90, 0]) thighStructPlus();
	translate(partUp) rotate([0, -90, 0]) thighStructMinus();
	
	union() {
		translate(boxToPart) boxBottomA(boxSize);
		thighBoxAdjustment();
	}
	
	//difference(){
		translate(boxToPart) boxVolumeA(boxSize);
	//	thighBoxAdjustment();
	//}
}

