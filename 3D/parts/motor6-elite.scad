include <../sizes.scad>
use <../lib/shapes.scad>
use <../lib/magnetoSensor.scad>
use <_common.scad>
use <../lib/boltFlat.scad>

module motor6() {
	z1 = 4.8;
	z2 = 4;
	
	cylinder(d1 = 27, d2 = motor6D, h = z1);
	translate([0, 0, z1]) cylinder(d1 = motor6D, d2 = motor6D, h = motor6H - z1 - z2);
	translate([0, 0, motor6H - z2]) cylinder(d1 = motor6D, d2 = 30, h = z2);
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

module motor6RotorHolderPlus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			translate([0, 0, motor6H]) {
				//cube([th, 100, 50], center = true);
				
				translate([6, 0, 0])
					boltPlus(20);
					
				translate([-6, 0, 0])
					boltPlus(20);
			}
		}
		
	for (a = [0 : 72 : 360])
		rotate([0, 0, a])
			translate([0, 20, motor6H])
				cube([th, 40, 40], center = true);
}

module motor6RotorHolderMinus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			translate([0, 0, motor6H]) {
				translate([6, 0, 0])
					boltMinus(6, 30);
					
				translate([-6, 0, 0])
					boltMinus(6, 30);
			}
		}
		
	translate([0, 0, motor6H-0.01])
		cylinder(d = 4.5, h = 8);
}

module motor6StatorHolderPlus() {
	for (a = [-45, 0, 45, 90])
		rotate([0, 0, a]) {
			cube([th, 60, 50], center = true);
		}
		
	for (a = [-22.5, 67.5])
		rotate([0, 0, a]) {
			mirror([0, 0, 1]) {
				translate([12.5, 0, 0])
					boltPlus(50);
					
				translate([-12.5, 0, 0])
					boltPlus(50);
			}
		}
		
	mirror([0, 0, 1])
	translate([0, 0, 5])
		cylinder(d1 = 22, d2 = 25, h = 20);
}

module motor6StatorHolderMinus() {
	for (a = [-22.5, 67.5])
		rotate([0, 0, a]) {
			mirror([0, 0, 1]) {
				translate([12.5, 0, 0])
					boltMinus(6, 50);
					
				translate([-12.5, 0, 0])
					boltMinus(6, 50);					
			}
		}
	
	mirror([0, 0, 1]) {
		cylinder(d = 18, h = 5);	
		
		translate([0, 0, 6])
		{
			mirror([0, 0, 1])
			rotate([0, 0, 22.5])
				magnetoSensorSpacing();
			
			translate([0, 0, 2 + th])
				cylinder(d1 = 22 - th*2, d2 = 25-th*2, h = 20);
		}
	}	
}