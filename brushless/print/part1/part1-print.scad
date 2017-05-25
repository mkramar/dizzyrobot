include <../../parts/part1.scad>
use <../../../lib/shapes.scad>
use <../../../lib/bolt.scad>
include <../../_sizes.scad>

boltPositions = [[h1/2 - 12, 29, 0], [h1/2 - 12, -29, 0],
				 [h1/2 + 12, 29, 0], [h1/2 + 12, -29, 0],
				 [27, 29, 0], [27, -29, 0],
				 [h1 - 27, 29, 0], [h1 - 27, -29, 0]];

module cutA() {
	translate([0, -50, -250])
		cube([100, 100, 300]);
}

module boltsAplus(){
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			cylinder(h = 36, d = 10);
	}
}

module boltsAminus(){
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltaMinus(h = 40);
	}
}

module boltsBplus() {
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
		translate([0, 0, -13])
			cylinder(h = 13, d = 10);
	}
}

module boltsBminus() {
	rotate([0, 90, 0])
	for (x = boltPositions)
	{
		translate(x)
			boltbMinus();
	}
}