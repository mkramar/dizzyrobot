include <../../parts/knee.scad>
use <../../../lib/shapes.scad>
use <../../../lib/bolt.scad>
include <../../_sizes.scad>

module cutA() {
	translate([kneeMiddle, -50, -150])
		cube([60, 100, 300]);
}


module boltsAplus(){
	rotate([0, 90, 0])
	for (x = kneeBoltPositions)
	{
		translate(x)
			cylinder(h = 36, d = 10);
	}
}

module boltsAminus(){
	rotate([0, 90, 0])
	for (x = kneeBoltPositions)
	{
		translate(x)
			boltaMinus(h = 40);
	}
}

module boltsBplus() {
	rotate([0, 90, 0])
	for (x = kneeBoltPositions)
	{
		translate(x)
		translate([0, 0, -20])
			cylinder(h = 20, d = 10);
	}
}

module boltsBminus() {
	rotate([0, 90, 0])
	for (x = kneeBoltPositions)
	{
		translate(x)
			boltbMinus();
	}
}