include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../lib/shapes.scad>

include <../../parts/shin.scad>

$fn = 70;

intersection(){
	cube([150, 150, 150], center = true);
	
	rotate([0, -90, 0])
	difference() {
		shin();
		
		difference() {
			translate([-23, -50, -shinLength])
				cube([20, 100, shinLength]);
				
			rotate([0, -90, 0])
				motor8case("outer");
		}
	}
}