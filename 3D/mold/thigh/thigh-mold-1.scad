include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>



moldMoldA(thighBoltPositions, thighLockPositions){
	translate(partUp) rotate([0, -90, 0]) thighShell("outer");
	translate(partUp) rotate([0, -90, 0]) thighShell("inner");
	
	translate(partUp) rotate([0, -90, 0]) thighStructPlus();
	translate(partUp) rotate([0, -90, 0]) thighStructMinus();
	
	translate(boxToPart) boxBottomA(boxSize);
	translate(boxToPart) boxVolumeA(boxSize);

	thighBoxAdjustment();	
}

translate(boxToPart) boxBorderA(boxSize);