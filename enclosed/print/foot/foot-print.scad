use <../../../lib/bolt.scad>
include <../../parts/foot.scad>

boltPositions = [[47, 0, -10], [-71, 0, -10]];

module cutA(){
	translate([-100, 0, -100])
		cube([200, 200, 200]);
		
	translate([0, 0.5, -40])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([-40, 0.5, -40])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([-90, 0.5, -40])
	rotate([0, 45, 0])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([-50, 0.5, -20])
	rotate([0, -45, 0])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([60, 0.5, -40])
	rotate([0, -45, 0])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
		
	translate([20, 0.5, -20])
	rotate([0, 45, 0])
	rotate([90, 0, 0])
		tapered_cuboid(w = 6, l = 40, h = 2, taper = 2);
}

module boltsAplus(){
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			cylinder(h = 36, d = 10);
	}
}

module boltsAminus(){
	
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			boltaMinus(h = 40);
	}
}

module boltsBplus() {
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
		translate([0, 0, -30])
			cylinder(h = 30, d = 10);
	}
}

module boltsBminus() {
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			boltbMinus();
	}
}