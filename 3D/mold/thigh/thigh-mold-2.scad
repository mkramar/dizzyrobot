include <../../lib/moldFramework.scad>
include <../../parts/thigh.scad>

rotate([180, 0, 0])
moldMoldB(thighBoltPositions, lockPositions){
	translate(partUp) rotate([0, -90, 0]) thighShell("outer");
	translate(partUp) rotate([0, -90, 0]) thighShell("inner");
	
	translate(partUp) rotate([0, -90, 0]) thighStructPlus();
	translate(partUp) rotate([0, -90, 0]) thighStructMinus();
	
	translate(boxToPart) boxBottomB(boxSize);
	translate(boxToPart) boxVolumeB(boxSize);
	
	thighBoxAdjustment();
}