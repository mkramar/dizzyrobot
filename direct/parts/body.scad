include <../sizes.scad>
include <motor.scad>

module bodyAssembly(){
	color("lightGray") {
		body();
		bodyMotors();
	}
}

module body(){
	cylinder(h = 50, d = rod25o);
	
	translate(bodyMotorOffset)
	rotate([-90, 0, 0])
		motor6caseStator();
}

module bodyMotors(){
	translate(bodyMotorOffset)
	rotate([-90, 0, 0])
		motor6();
}