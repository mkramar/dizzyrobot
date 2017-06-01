use <../../lib/ballBearing.scad>
use <../../lib/shapes.scad>
include <../parts/heap.scad>
use <../_shared.scad>
include <../_sizes.scad>

difference()
{
	heap();
		
	translate([-70, 20, -120])
		cube([200, 100, 150]);
		
	translate([-100, -50, -80])
		cube([100, 100, 100]);
}

heapAxisAssembly();
heapPulley();
#heapPulley2();

//

translate([0, 0, -heapAxisOffset])
translate([heapMotorOffset, 0, 0])
rotate([0, -90, 0])
	motor5();
