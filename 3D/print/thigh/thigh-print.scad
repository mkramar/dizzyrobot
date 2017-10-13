include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../lib/shapes.scad>

include <../../parts/thigh.scad>

cutLevel = 6;

boltPositions = [[50, 22, 0], [50, -22, 0],
				 [150, 20, 0], [150, -20, 0]];

module cut() {
	difference() {
		translate([cutLevel, -50, -thighLength])
		mirror([1, 0, 0])
			cube([50, 100, thighLength]);
			
		union() {
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				motor8caseRough("outer");
				
			rotate([0, -90, 0])
				motor8caseRough("outer");
				
		}
	}
}


module boltsPlus(){
	translate([cutLevel, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltPlus(40);
	}
}

module boltsMinus(){
	translate([cutLevel, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltMinus(4, 40);
	}
}

module nutsPlus(){
	translate([cutLevel, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			nutPlus(40);
	}
}

module nutsMinus(){
	translate([cutLevel, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			nutMinus(4, 40);
	}
}