include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../lib/shapes.scad>
include <../../lib/dent.scad>
include <../../lib/boltFlat.scad>
include <../../parts/foot.scad>

boltPositions = [[39, 70, 0], [39, 0, 0], [39, -55, 0]];
				 
module cut(mode) {
	translate([motor6Cut + gap/2, 0, 0]){
		translate([0, -100, -100])
			cube([100, 200, 200]);
			
		translate([0, 60, -60])
		rotate([90, 0, -90])
			dent(mode);
			
		translate([0, -40, -60])
		rotate([90, 0, -90])
			dent(mode);
			
		translate([0, -105, -44])
		rotate([0, -90, 0])
			dent(mode);

		translate([0, 80, -44])
		rotate([0, -90, 0])
			dent(mode);
	}
}

module boltsPlus(){
	translate([motor6Cut + gap/2, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltPlus(40);
	}
}

module boltsMinus(){
	translate([motor6Cut + gap/2, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltMinus(4, 40);
	}
}

module nutsPlus(){
	translate([motor6Cut + gap/2, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			nutPlus(40);
	}
}

module nutsMinus(){
	translate([motor6Cut + gap/2, 0, 0])
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			nutMinus(4, 40);
	}
}