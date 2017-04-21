use <../../parts/part1.scad>
use <../../../lib/shapes.scad>
use <../../../lib/bolt.scad>

boltPositions = [[-20, 0, 0], [-13, 11, 0], [-13, -11, 0]];

module cutA() {
	difference()
	{
		translate([-50, 0, -250])
			cube([100, 60, 300]);

		translate([100, -1, -70])
		rotate([-90, 90, 0])
			tapered_cuboid(w = 40, l = 200, h = 10, taper = 10);
	}
	
	// translate([0.5, 3, 10])
	// rotate([90, 0, -90])
		// tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
}

module boltsAplus(){
	for (x = boltPositions)
	{
		translate(x)
			cylinder(h = 16, d = 10);
	}
}

module boltsAminus(){
	for (x = boltPositions)
	{
		translate(x)
			boltaMinus();
	}
}

module boltsBplus() {
	for (x = boltPositions)
	{
		translate(x)
		translate([0, 0, -13])
			cylinder(h = 13, d = 10);
	}
}

module boltsBminus() {
	for (x = boltPositions)
	{
		translate(x)
			boltbMinus();
	}
}