include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/thigh.scad>





module cut() {
	translate([cutLevel, -50, -300])
		cube([20, 100, 400]);
		
	union() {
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8caseRough("outer");
			
		rotate([0, -90, 0])
			motor8caseRough("outer");
			
	}
}
