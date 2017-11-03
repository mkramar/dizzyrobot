include <../sizes.scad>
include <_common.scad>

use <../lib/shapes.scad>
use <../lib/magnetoSensor.scad>
use <../lib/boltFlat.scad>

module motor6() {
	z1 = 5;
	za = 3.5;
	z2 = 12.5;
	z3 = 3.6;
	z4 = 2;
	
	cylinder(d = 25.5, h = z1);
	translate([0, 0, z1 - 0.01]) {
	
		cylinder(d = 55, h = za);
		translate([0, 0, za - 0.01]) {
	
			cylinder(d = motor6D, h = z2);
			translate([0, 0, z2 - 0.01]) {
				cylinder(d1 = motor6D, d2 = 40, h = z3);
				translate([0, 0, z3 - 0.01]) {
					cylinder(d = 19, h = z4);
					translate([0, 0, z4 - 0.01]) {
						cylinder(d = 4, h = 5);
					}
				}
			}
		}
	}
	
	for (a = [0, 90, 180, 270]){
		rotate([0, 0, a])
		translate([13, 0, 0]){
			cylinder(d = 10, h = z1);
		}
	}
}

module motor6case(mode) {
	h = motor6H + 12 + plus2th(mode);
	d = motor6D + plus2th(mode);
	x = 5;
	rd = (mode == "outer" ? 10 : 8);
	
	translate([0, 0, -1])
	translate([0, 0, motor6H/2])
		shayba2(h, d, x, rd);
}

module motor6caseRough(mode) {
	h = motor6H + 10 + plus2th(mode);
	d = motor6D + plus2th(mode);
	
	translate([0, 0, motor6H/2])
		cylinder(h = h, d = d, center = true);
}

// rotor ----------------------------------------------------------------------

module motor6caseRotor(mode){
	intersection() {
		motor6case(mode);
		
		translate([0, 0, motor6Cut + gap/2]) 
			cylinder(d = motor6D + 10, h = motor6H + 20);
	}
}

module motor6MinusRotor(){
	translate([0, 0, motor6Cut - gap/2]) 
		cylinder(d = motor6D + th*2 + gap*2, h = 30, center = false);
}

module motor6RotorHolderPlus() {
	for (a = [0 : 120 : 360])
		rotate([0, 0, a + 90]) {
			translate([0, 0, motor6H]) {
				translate([-6, 0, 0])
					boltPlus(20);
			}
		}
		
	for (a = [0 : 60 : 360])
		rotate([0, 0, a])
			translate([0, 20, motor6H])
				cube([th, 40, 40], center = true);
}

module motor6RotorHolderMinus() {
	for (a = [0 : 120 : 360])
		rotate([0, 0, a + 90]) {
			translate([0, 0, motor6H]) {
				translate([-6, 0, 0])
					boltMinus(6, 30);
			}
		}
		
	translate([0, 0, motor6H-0.01])
		cylinder(d = 4.5, h = 8);
}

// stator ---------------------------------------------------------------------

module motor6caseStator(mode){
	intersection() {
		motor6case(mode);
		
		translate([0, 0, motor6Cut - gap/2]) 
		rotate([180, 0, 0])
			cylinder(d = motor6D + 10, h = motor6H + 20);
	}
}

module motor6MinusStator(){
	translate([0, 0, motor6Cut + gap/2]) 
	rotate([180, 0, 0])
		cylinder(d = motor6D + th*2 + gap*2, h = 30, center = false);
}

module motor6StatorHolderPlus() {
	rotate([0, 0, 22.5]){
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
			cylinder(d = 22, h = 15);
	}
}

module motor6StatorHolderMinus() {
	sensorOffset = 11;
	
	rotate([0, 0, 22.5]){
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
			cylinder(d = 18, h = sensorOffset - 2);
			
			translate([0, 0, sensorOffset]){
				mirror([0, 0, 1])
				rotate([0, 0, 22.5])
					magnetoSensorSpacing();
				
				translate([0, 0, 2 + th])
					cylinder(d1 = 22 - th*2, d2 = 25-th*2, h = 20);
			}
		}
	}
}

// magnet ---------------------------------------------------------------------

module motor6MagnetAdapter(){
	h = 4.5;
	
	translate([0, 0, -1]) // to match motor
	mirror([0, 0, 1])
	difference() {
		cylinder(d = 16, h = h);

		cylinder(d = 10.5, h = 1);
		cylinder(d = 6.8, h = 2);

		translate([0, 0, h + 0.01])
			cube([3.2, 6.2, 3.2], center = true);
	}
}
