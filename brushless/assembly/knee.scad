use <../../lib/ballBearing.scad>
use <../../lib/shapes.scad>
use <../parts/heap.scad>
include <../parts/knee.scad>
use <../parts/knee-joint.scad>
use <../_shared.scad>
include <../_sizes.scad>

difference()
{
	union()
	{
		knee();
		kneeAxisAssembly();
		kneePulley();
		kneeRods();
		kneeRodsDown();
	}
		
	translate([-70, 20, -20])
		cube([200, 100, 150]);
		
	translate([-100, -50, 0])
		cube([100, 100, 100]);
	
}

//kneeRods();

translate([0, 0, kneeAxisOffset])
translate([kneeMotorOffset, 0, 0])
rotate([0, -90, 0])
	motor5();

rotate([-90, 0, 0])
rotate([0, -90, 0])
{
	//#kneeJoint(preview = true);	
	//sideOuterMinusRods();
}
