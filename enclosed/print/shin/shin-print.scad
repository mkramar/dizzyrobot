use <../../../lib/bolt.scad>
include <../../parts/part2.scad>
include <../../parts/motor.scad>

bolts2to4 = [[24, 0, -180], [-24, 0, -180],
             [24, 0, -205], [-24, 0, -205]];
			 
bolts1to5 = [[-2, 0, -115], [-35, 0, -115],
             [-14, 0, -90], [-40, 0, -90]];

bolts2to5 = [[21, 0, -160], [-27, 0, -160],
             [9, 0, -135], [-32, 0, -135]];

bolts1to3 = [[-26, 0, -3], [-22, 0, -70], [-47, 0, -40]];

module cutA(){
	translate([-100, 0, -125])
		cube([200, 200, 200]);
}

module cutB(){
	translate([-100, 0, -325])
		cube([200, 200, 200]);
}

module cutC(){
	translate([-100, -100, -80])
		cube([200, 200, 155]);
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