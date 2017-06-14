include <../../parts/body.scad>
use <../../../lib/shapes.scad>
use <../../../lib/bolt.scad>

cutX = axis1xOffset + axis1Bearing1 + (axis1Bearing2-axis1Bearing1)/2;
boltApositions = [[cutX, 20, 14], [cutX, 18, -17], [cutX, -24, -5],
				  [cutX, -heapWidth - 20, 14], [cutX, -heapWidth - 18, -17], [cutX, -heapWidth + 24, -5]];
				  
boltBpositions = [[cutX, 20, 50], [cutX, -heapWidth/2, -33], [cutX, -heapWidth - 20, 50]];

module cutA(){
	translate([-200 + cutX, -100 -heapWidth/2, -100])
		cube([200, 200, 200]);
}

module cutB(){
	rotate([0, 90, 0])
	hull()
	{
		cylinder(d = 45, h = cutX);
		translate([0, -heapWidth, 0]) cylinder(d = 45, h = cutX);
	}
}

// A

module boltsAplus(){
	for (x = boltApositions)
	{
		translate(x)
		rotate([0, 90, 0])
			cylinder(h = 36, d = 10);
	}
}

module boltsAminus(){
	for (x = boltApositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltaMinus(h = 40);
	}
}

module nutsAplus() {
	h = (axis1Bearing2 - axis1Bearing1 + bb6805h)/2 + th;
	
	for (x = boltApositions)
	{
		translate(x)
		rotate([0, 90, 0])
		translate([0, 0, -h])
			cylinder(h = h, d = 10);
	}
}

module nutsAminus() {
	for (x = boltApositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltbMinus();
	}
}

// B

module boltsBplus(){
	for (x = boltBpositions)
	{
		translate(x)
		rotate([0, 90, 0])
			cylinder(h = 36, d = 10);
	}
}

module boltsBminus(){
	for (x = boltBpositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltaMinus(h = 40);
	}
}

module nutsBplus() {
	h = (axis1Bearing2 - axis1Bearing1 + bb6805h)/2 + th;
	
	for (x = boltBpositions)
	{
		translate(x)
		rotate([0, 90, 0])
		translate([0, 0, -h])
			cylinder(h = h, d = 10);
	}
}

module nutsBminus() {
	for (x = boltBpositions)
	{
		translate(x)
		rotate([0, 90, 0])
			boltbMinus();
	}
}