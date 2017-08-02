use <../../lib/shapes.scad>
include <../sizes.scad>
use <_common.scad>
use <../../lib/boltFlat.scad>

// motor8 ---------------------------------------------------------------------

module motor8() {
	z = 2;
	
	cylinder(d1 = 60, d2 = motor8D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor8D, d2 = motor8D, h = motor8H - z * 2);
	translate([0, 0, motor8H - z]) cylinder(d1 = motor8D, d2 = 60, h = z);
}

module motor8case(mode) {
	h = motor8H + 10 + plus2th(mode);
	d = motor8D + plus2th(mode);
	x = 5;
	rd = (mode == "outer" ? 10 : 8);
	
	translate([0, 0, motor8H/2])
		shayba2(h, d, x, rd);
}

module motor8caseRotor(mode){
	intersection() {
		motor8case(mode);
		
		translate([0, 0, motor8Cut + gap/2]) 
			cylinder(d = motor8D + 10, h = motor8H + 20);
	}
}

module motor8caseStator(mode){
	intersection() {
		motor8case(mode);
		
		translate([0, 0, motor8Cut - gap/2]) 
		rotate([180, 0, 0])
			cylinder(d = motor8D + 10, h = motor8H + 20);
	}
}

module motor8MinusRotor(){
	translate([0, 0, motor8Cut - gap/2]) 
		cylinder(d = motor8D + th*2 + gap*2, h = 30, center = false);
}

module motor8StatorHolderPlus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			cube([th, 100, 50], center = true);
			
			mirror([0, 0, 1]) {
				translate([15, 0, 0])
					boltPlus(50);
					
				translate([-15, 0, 0])
					boltPlus(50);
			}
		}
}

module motor8StatorHolderMinus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			mirror([0, 0, 1]) {
				translate([15, 0, 0])
					boltMinus(6, 50);
					
				translate([-15, 0, 0])
					boltMinus(6, 50);					
			}
		}
}

// motor6 ---------------------------------------------------------------------

module motor6() {
	z = 3;
	
	cylinder(d1 = 30, d2 = motor6D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor6D, d2 = motor6D, h = motor6H - z * 2);
	translate([0, 0, motor6H - z]) cylinder(d1 = motor6D, d2 = 30, h = z);
}

module motor6case(mode) {
	h = motor6H + 10 + plus2th(mode);
	d = motor6D + plus2th(mode);
	x = 5;
	rd = (mode == "outer" ? 10 : 8);
	
	translate([0, 0, motor6H/2])
	shayba2(h, d, x, rd);
}

module motor6caseRotor(mode){
	intersection() {
		motor6case(mode);
		
		translate([0, 0, motor6Cut + gap/2]) 
			cylinder(d = motor6D + 10, h = motor6H + 20);
	}
}

module motor6caseStator(mode){
	intersection() {
		motor6case(mode);
		
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