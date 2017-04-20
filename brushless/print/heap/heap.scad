use <../../parts/heap.scad>
use <../../../lib/bolt.scad>

boltPositions = [[-20, 0, 0], [-13, 11, 0], [-13, -11, 0]];


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