include <../sizes.scad>

module motor5() {
	z = 4;
	
	cylinder(d1 = 30, d2 = motor5D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor5D, d2 = motor5D, h = motor5H - z * 2);
	translate([0, 0, motor5H - z]) cylinder(d1 = motor5D, d2 = 30, h = z);
}