use <../../../lib/bolt.scad>
include <../../parts/heap.scad>
include <../../parts/motor.scad>

bolts2to4 = [[24, 0, -180], [-24, 0, -180],
             [24, 0, -205], [-24, 0, -205]];
			 
bolts1to5 = [[-28, 0, 80], [8, 0, 80],
			 [-28, 0, 65], [8, 0, 65]];

bolts2to5 = [[21, 0, -160], [-27, 0, -160],
             [9, 0, -135], [-32, 0, -135]];

bolts1to3 = [[-28, 0, 35], [8, 0, 35],
			 [-28, 0, 50], [8, 0, 50]];

module cutA(){
	translate([-100, 0, -110])
		cube([200, 200, 200]);
}

module cutB(){
	translate([-100, 0, -325])
		cube([200, 200, 200]);
}

module cutC(){
	translate([-100, -100, -110])
		cube([200, 200, 170]);
}

module cutD(){
	translate([-100, -100, -325])
		cube([200, 200, 155]);
}


module boltsAplus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			cylinder(h = 36, d = 10);
	}
}

module boltsAminus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			boltaMinus(h = 40);
	}
}

module boltsBplus(boltPositions) {
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
		translate([0, 0, -30])
			cylinder(h = 30, d = 10);
	}
}

module boltsBminus(boltPositions) {
	for (x = boltPositions)
	{
		translate(x)
		rotate([-90, 0, 0])
			boltbMinus();
	}
}