use <../../lib/ballBearing.scad>
use <../../lib/shapes.scad>
use <../parts/heap.scad>
include <../parts/knee.scad>
use <../parts/knee-joint.scad>
use <../_shared.scad>
include <../_sizes.scad>

knee();

//kneeRods();

translate([0, 0, kneeAxisOffset])
translate([kneeMotorOffset, 0, 0])
rotate([0, -90, 0])
	motor5();

rotate([-90, 0, 0])
rotate([0, -90, 0])
{
	#kneeJoint(preview = true);	
	sideOuterMinusRods();
}
