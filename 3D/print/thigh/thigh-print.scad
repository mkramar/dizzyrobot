include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/thigh.scad>

cutLevel = 6;

boltPositions = [[50, 22, cutLevel], [50, -22, cutLevel],
				 [150, 20, cutLevel], [150, -20, cutLevel]];

module cut() {
	difference() {
		translate([cutLevel, -50, -thighLength])
		mirror([1, 0, 0])
			cube([20, 100, thighLength]);
			
		union() {
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				motor8caseRough("outer");
				
			rotate([0, -90, 0])
				motor8caseRough("outer");
				
		}
	}
}
