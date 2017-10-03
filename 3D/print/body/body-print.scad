include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../lib/shapes.scad>

include <../../parts/body.scad>

//$fn = 70;

difference() {
	intersection() {
		body();
		
		translate([-100, -190, -100])
			cube([200, 200, 170]);
	}
	
	translate([-100, -10, -200])
		cube([200, 200, 200]);	
}