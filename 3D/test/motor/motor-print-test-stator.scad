include <../../sizes.scad>
include <../../parts/motor6-tyi.scad>

$fn = 50;

//motor6();

difference(){
	testStator();

	rotate([0, 0, 90])
	translate([0, 0, -25])
		cube([50, 50, 50]);
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