include <../sizes.scad>
include <_common.scad>

module shoulderAssembly(){
	#coords();
	
	color("seaGreen") shoulder("preview");
}

module shoulder(mode) {
	difference() {
		shoulderBase("outer");
		shoulderBase("inner");
	}
}

module shoulderBase(mode){
	translate([0, 0, 0.01])
	rotate([0, 90, 0])
		motor8caseRotor(mode);
	
	translate([0, 0, 0.01])	
	translate(armMotorOffset)
	rotate([90, 0, 0])
		motor6caseRotor(mode);		
}