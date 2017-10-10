include <../../sizes.scad>
use <../../parts/motor.scad>
//$fn = 70;

module cut1(){
	translate(waistMotorOffset2)
	mirror([0, 0, 1])
		motor6caseRotor("outer");
			
	translate([0, 60, 60]) {
		rotate([160, 0, 0])
		translate([-100, 0, 0])
			cube([200, 200, 170]);
			
		translate([-100, -200, 0])
			cube([200, 200, 100]);
	}
}