include <../../parts/part1.scad>
use <../../../lib/shapes.scad>
use <../../../lib/bolt.scad>
include <../../_sizes.scad>

boltPositions = [[h1/2 - 12, 29, part1TopCut], [h1/2 - 12, -29, part1TopCut],
				 [h1/2 + 12, 29, part1TopCut], [h1/2 + 12, -29, part1TopCut]];

module cutA() {
	difference()
	{
		translate([-50, 0, -250])
			cube([100, 60, 300]);

		translate([100, -1, -6])
		rotate([-90, 90, 0])
			tapered_cuboid(w = 100, l = 200, h = 15, taper = 10);
	}
	
	// translate([0.5, 3, 10])
	// rotate([90, 0, -90])
		// tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
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