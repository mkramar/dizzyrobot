include <../../sizes.scad>
include <../../parts/motor6-tyi.scad>

$fn = 50;

//motor6();

difference(){
	mirror([0, 0, 1])
		testRotor();

	translate([0, 0, -50])
		cube([50, 50, 50]);
}

module testRotor(){
	difference(){
		union(){
			difference() {
				motor6caseRotor("outer");
				motor6caseRotor("inner");
			}

			intersection() {
				motor6RotorHolderPlus();
				motor6caseRotor("outer");
			}
		}
		
		rotate([0, 0, -45/2]) motor6();			
		motor6RotorHolderMinus();
	}
}