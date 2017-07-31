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
	
}

module heapMotor(){
	translate(heapMotorOffset)
	rotate([0, 90, 0])
		motor8();
}