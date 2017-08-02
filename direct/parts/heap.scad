include <../sizes.scad>
include <_common.scad>

module heapAssembly(){
	#coords();
	
	color("seaGreen"){
		heap();
		heapMotor();
	}
}

module heap(){
	translate([0, 0, 0.01])
	rotate([-90, 0, 0])
		motor6caseRotor();

	translate(heapMotorOffset)
	rotate([0, -90, 0])
		motor8caseRotor();
}

module heapMotor(){
	translate(heapMotorOffset)
	rotate([0, -90, 0])
		motor8();
}