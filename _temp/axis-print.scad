include <axis.scad>
use <../lib/shapes.scad>
use <../lib/bolt.scad>

boltPositions = [[28, 0, -80], [-28, 0, -80]];

module cutA(){
	translate([-100, 0, -160])
		cube([200, 200, 200]);
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