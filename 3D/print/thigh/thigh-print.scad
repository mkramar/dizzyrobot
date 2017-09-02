include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor.scad>
include <../../../lib/shapes.scad>

include <../../parts/thigh.scad>

$fn = 50;

intersection(){
	// translate([-thighLength, 0, 0])
		// cube([150, 150, 150], center = true);
	
	rotate([0, 90, 0])
	difference() {
		thigh();
		
		difference() {
			translate([-16, -50, -thighLength])
				cube([20, 100, thighLength]);
				
			union() {
				translate(thighMotorOffset)
				rotate([0, -90, 0])
					motor8case("outer");
					
				rotate([0, -90, 0])
					motor8case("outer");
					
			}
		}
	}
}