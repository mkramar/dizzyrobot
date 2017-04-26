use <../lib/ballBearing.scad>
use <../lib/shapes.scad>
use <parts/heap.scad>
use <parts/part1.scad>
use <parts/part2.scad>
use <_shared.scad>
include <_sizes.scad>


half();

#mirror([1, 0, 0]) translate([90, 0, 0]) half();

module half()
{
	// heap motor
	
	translate([15, -50, 35])
	rotate([0, -90, 0])
		motor5();

	// bearing joint to body
	
	//translate([-30, 0, 0])
	//rotate([0, 0, 180])
	//	bearingWithHolders(innerColor = "Violet", outerColor = "YellowGreen");

	// heap
	
	#rotate([0, 180, 0])
		heap(preview = true);

	// knee joint bearing

	#rotate([0, 0, 90])
		bearingInner(showBearing = true, color = "turquoise");	
		
	// part 1
	
	color("turquoise")
		part1(preview = true);
		
	part1Motors();
		
	translate(part1KneeOffset)
	{
		color("white")
		rotate([0, -90, 0])
			ballBearing6805();
		
	
		color("teal")
			part2(preview = true);
			
		part2Motors();
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