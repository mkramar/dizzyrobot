include <../sizes.scad>
include <_common.scad>

use <../lib/shapes.scad>
use <../lib/magnetoSensor.scad>
use <../lib/boltFlat.scad>

module motor8() {
	z1 = 1;
	z2 = 3;
	
	cylinder(d1 = 70, d2 = motor8D, h = z1);
	translate([0, 0, z1]) cylinder(d1 = motor8D, d2 = motor8D, h = motor8H - z1 - z2);
	translate([0, 0, motor8H - z2]) cylinder(d1 = motor8D, d2 = 43, h = z2);
}

module motor8case(mode) {
	h = motor8H + 10 + plus2th(mode);
	d = motor8D + plus2th(mode);
	x = 5;
	rd = (mode == "outer" ? 10 : 8);
	
	translate([0, 0, motor8H/2])
		shayba2(h, d, x, rd);
}

module motor8caseRough(mode) {
	h = motor8H + 10 + plus2th(mode);
	d = motor8D + plus2th(mode);
	
	translate([0, 0, motor8H/2])
		cylinder(h = h, d = d, center = true);
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

module motor8MinusStator(){
	translate([0, 0, motor8Cut + gap/2]) 
	rotate([180, 0, 0])
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
		
	for (a = [-40 : 20 : 220])
	//for (a = [-60 : 20 : 240])
		rotate([0, 0, a])
			translate([0, 45, 0])
				cube([th, 20, 50], center = true);
		
	mirror([0, 0, 1])
	translate([0, 0, 5])
	difference() {
		cylinder(d1 = 22, d2 = 25, h = 20);
		
		translate([7.5, -8.5/2, 0])
			cube([10, 8.5, 20]);
	}
	
	// translate([0, 0, -7.5])
	// rotate([0, 0, 90])
		// magnetoSensor();	
}

module motor8StatorHolderMinus() {	for (a = [-45, 45])
		rotate([0, 0, a]) {
			mirror([0, 0, 1]) {
				translate([15, 0, 0])
					boltMinus(6, 50);
					
				translate([-15, 0, 0])
					boltMinus(6, 50);					
			}
		}
	
	mirror([0, 0, 1]) {
		cylinder(d = 20.5, h = 5);
		
		translate([0, 0, 5])
		translate([0, 0, 4 + th])
			cylinder(d1 = 22 - th*2, d2 = 25-th*2, h = 20);
	}
	
	translate([0, 0, -7.5])
	rotate([0, 0, 90])
		magnetoSensorSpacing();
	
}

module motor8RotorHolderPlus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			translate([0, 0, motor8H]) {
				cube([th, 100, 70], center = true);
				
				translate([35/2, 0, 0])
					boltPlus(50);
					
				translate([-35/2, 0, 0])
					boltPlus(50);
			}
		}
		
	for (a = [-180 : 45 : 0])
		rotate([0, 0, a])
			translate([0, 45, motor8H])
				cube([th, 20, 50], center = true);
}

module motor8RotorHolderMinus() {
	for (a = [-45, 45])
		rotate([0, 0, a]) {
			translate([0, 0, motor8H]) {
				translate([35/2, 0, 0])
					boltMinus(6, 50);
					
				translate([-35/2, 0, 0])
					boltMinus(6, 50);
			}
		}
}

module motor8SensorAdapter(){
	difference() {
		union() {
			cylinder(d1 = 18, d2 = 5, h = 6.5);
			
			translate([0, 0, 6.5 - 0.01])
				dCylinder(5, 4.2, 0.8, false);
				//dCylinder(5, 4, 1, false);
		}
		
		translate([0, 3.25, -0.01])
			sphere(d = 5.6);
			
		translate([0, -3.25, -0.01])
			sphere(d = 5.6);
		
		// translate([-1, -1, -0.01])
			// cube([2, 2, 2]);
	}
}

module motor8MagnetAdapter(){
	h = 4.5;
	d = 6.2;
	
	difference() {
		cylinder(d = 18, h = h);
		
		translate([0, 3.25, -0.01])
			sphere(d = d);
			
		translate([0, -3.25, -0.01])
			sphere(d = d);

		translate([0, 0, h + 0.01])
			cube([3.2, 6.2, 3.2], center = true);
	}
}
