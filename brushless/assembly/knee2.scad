include <../_sizes.scad>
include <../parts/part1.scad>
include <../parts/knee-joint.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

color("turquoise")
	part1(preview = false);
	
part1Motors();
	
translate(part1KneeOffset)
{
	rotate([-90, 0, 0])
	rotate([0, -90, 0])
	{
		#kneeJoint(preview = true);	
		sideOuterMinusRods();
	}
}