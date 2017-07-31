use <../../lib/shapes.scad>
include <../sizes.scad>

// public ---------------------------------------------------------------------

module motor8() {
	z = 2;
	
	cylinder(d1 = 60, d2 = motor8D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor8D, d2 = motor8D, h = motor8H - z * 2);
	translate([0, 0, motor8H - z]) cylinder(d1 = motor8D, d2 = 60, h = z);
}

module motor6() {
	z = 3;
	
	cylinder(d1 = 30, d2 = motor6D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor6D, d2 = motor6D, h = motor6H - z * 2);
	translate([0, 0, motor6H - z]) cylinder(d1 = motor6D, d2 = 30, h = z);
}

module motor8case() {
	h = motor8H + 15;
	d = motor8D + th*2;
	x = 5;
	rd = 10;
	
	translate([0, 0, motor8H/2])
	shayba2(h, d, x, rd);
}
module motor8MinusRotor(){
	ring(d = motor8D + th*2, h = 30, t = th, center = false);
}