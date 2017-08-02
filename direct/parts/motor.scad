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

module motor8caseRotor(){
	intersection() {
		motor8case();
		
		translate([0, 0, motor8Cut + gap/2]) 
			cylinder(d = motor8D + 10, h = motor8H + 20);
	}
}

module motor8caseStator(){
	intersection() {
		motor8case();
		
		translate([0, 0, motor8Cut - gap/2]) 
		rotate([180, 0, 0])
			cylinder(d = motor8D + 10, h = motor8H + 20);
	}
}

module motor8MinusRotor(){
	translate([0, 0, motor8Cut - gap/2]) 
		cylinder(d = motor8D + th*2 + gap*2, h = 30, center = false);
}

module motor6case() {
	h = motor6H + 15;
	d = motor6D + th*2;
	x = 5;
	rd = 10;
	
	translate([0, 0, motor6H/2])
	shayba2(h, d, x, rd);
}

module motor6caseRotor(){
	intersection() {
		motor6case();
		
		translate([0, 0, motor6Cut + gap/2]) 
			cylinder(d = motor6D + 10, h = motor6H + 20);
	}
}

module motor6caseStator(){
	intersection() {
		motor6case();
		
		translate([0, 0, motor6Cut - gap/2]) 
		rotate([180, 0, 0])
			cylinder(d = motor6D + 10, h = motor6H + 20);
	}
}

module motor6MinusRotor(){
	translate([0, 0, motor6Cut - gap/2]) 
		cylinder(d = motor6D + th*2 + gap*2, h = 30, center = false);
}

module motor6MinusStator(){
	translate([0, 0, motor6Cut + gap/2]) 
	rotate([180, 0, 0])
		cylinder(d = motor6D + th*2 + gap*2, h = 30, center = false);
}