use <../lib/ballBearing.scad>
use <../lib/shapes.scad>
use <parts/heap.scad>
use <parts/part1.scad>
use <parts/part2.scad>
use <parts/knee.scad>
use <parts/knee-joint.scad>
use <_shared.scad>
include <_sizes.scad>


half();

#mirror([1, 0, 0]) translate([heapWidth, 0, 0]) half();

module half()
{
	heap(preview = true);
	
	// part 1
	
	translate(part1KneeOffset)
	{
		knee(preview = true);
		
		//kneeAxisAssembly();
		//kneePulley();
		kneeRods();
		kneeRodsDown();
	}
}

module bearingWithHolders(innerColor, outColor) {
	outside = 10;

	color("white")
	rotate([0, -90, 0])
		ballBearing6805();
		
	// inner

	color(innerColor)
	translate([(outside - thEdge) / 2, 0, 0])
	rotate([0, 90, 0])
		ring(d = bbi - th * 2, t = th, h = bbh + outside + thEdge);
		
	color(innerColor)
	translate([(-bbh - thEdge) / 2, 0, 0])
	rotate([0, 90, 0])
		ring(d = bbi, t = thEdge, h = thEdge);
		
	// outer
		
	color(outerColor)
	translate([-thEdge/2, 0, 0])
	rotate([0, -90, 0])
		ring(d = bbo, t = th, h = bbh + thEdge);

	color(outerColor)
	translate([(-bbh - thEdge) / 2, 0, 0])
	rotate([0, -90, 0])
		ring(d = bbo - thEdge * 2, t = thEdge * 2, h = thEdge);		
}