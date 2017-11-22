include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>

boxSize = [340, 140, 20];
boxToPart = [-70, -70, 0];

moldMoldB(thighBoltPositions, lockPositions){
	rotate([0, -90, 0]) thighShell("outer");
	rotate([0, -90, 0]) thighShell("inner");
	
	rotate([0, -90, 0]) thighStructPlus();
	rotate([0, -90, 0]) thighStructMinus();
	
	// translate(boxToPart) boxBottomB(boxSize);
	// translate(boxToPart) boxVolumeB(boxSize);
	
	union() {
		translate(boxToPart) boxBottomB(boxSize);
		thighBoxAdjustment();
	}
	
	//union(){
		translate(boxToPart) boxVolumeB(boxSize);
	//	thighBoxAdjustment();
	//}	
}