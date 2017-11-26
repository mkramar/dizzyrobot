include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor8.scad>
include <../../parts/motor6-tyi.scad>
include <../../lib/shapes.scad>
include <../../lib/cut.scad>
include <../../parts/shin.scad>

thighCutLevel = -25;

boltPositions = [[-55, 20, -thighCutLevel], [-55, -20, -thighCutLevel],
				 [-160, 14, -thighCutLevel], [-160, -14, -thighCutLevel]];

module cut() {
	difference() {
		translate([thighCutLevel, -50, -shinLength])
		//mirror([1, 0, 0])
			cube([20, 100, shinLength]);
			
		union() {
			translate(shinMotorOffset)
			rotate([0, -90, 0])
				motor6caseRough("outer");
				
			rotate([0, -90, 0])
				motor8caseRough("outer");
				
		}
	}
}
