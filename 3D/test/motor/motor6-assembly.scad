include <../../sizes.scad>
include <../../parts/motor6-tyi.scad>
include <../../lib/magnetoSensor.scad>

//$fn = 50;

color("pink")
	motor6();
	


color("red")	
translate([0, 0, -11])
rotate([0, 0, 22.5])
	magnetoSensor();

difference(){
	union() {
		testStator();
		testRotor();
		
		color("white")
			motor6MagnetAdapter();
	}

	rotate([0, 0, 90])
	translate([0, 0, -25])
		cube([50, 50, 100]);
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

module testStator() {
	difference(){
		union(){
			difference() {
				motor6caseStator("outer");
				motor6caseStator("inner");
			}

			intersection() {
				motor6StatorHolderPlus();
				motor6caseStator("outer");
			}
		}
		
		rotate([0, 0, -45/2]) motor6();
		motor6StatorHolderMinus();
	}
}