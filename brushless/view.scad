use <../lib/ballBearing.scad>
use <../lib/shapes.scad>
use <../_temp/gimbal.scad>
include <_sizes.scad>


half();

#mirror([1, 0, 0]) translate([90, 0, 0]) half();

module half()
{
	// heap motor
	
	translate([15, -50, h1 + 35])
	rotate([0, -90, 0])
		tyiPower5008();

	// bearing joint to body
	
	translate([-30, 0, 0])
	translate([0, 0, h1]) 
	rotate([0, 0, 180])
		bearingWithHolders(innerColor = "Violet", outerColor = "YellowGreen");

	// heap bearing
	
	translate([0, 0, h1]) 
	rotate([0, 0, -90])	
		bearingWithHolders(innerColor = "turquoise", outerColor = "YellowGreen");

	// knee joint bearing

	translate([4, 0, 0])
		bearingWithHolders(innerColor = "turquoise", outerColor = "teal");	
		
	// heap motor

	translate([0, -42, h1 -60])
	rotate([-90, 0, 0])
		//tyiPower5008();	
		bgm3608();
		
	// bone 1
	
	color("turquoise")
	{
		translate([0, -10, 0])
		hull()
		{
			translate([0, 0, h1])
			rotate([90, 9, 0])
				cylinder(d = 30, h = th);
				
			translate([0, 0, h1/2])
			rotate([90, 9, 0])
				cylinder(d = 40, h = th);		
		}
		
		translate([10, 0, 0])
		hull()
		{
			translate([0, 0, h1/2])
			rotate([0, 90, 0])
				cylinder(d = 40, h = th);

			rotate([0, 90, 0])
				cylinder(d = 30, h = th);	
		}
	}

	// knee motor
	translate([42, 0, 45])
	rotate([0, -90, 0])
		tyiPower5008();
		
	// bone 2
	
	color("teal")
	translate([0, 0, 0])
	hull()
	{
		rotate([0, 90, 0])
			cylinder(d = 50, h = th);	
			
		translate([0, 0, -h2])
		rotate([0, 90, 0])
			cylinder(d = 40, h = th);
	}
	
	translate([30, 0, -h2 + 40])
	rotate([0, -90, 0])
		//tyiPower5008();	
		bgm3608();	
	
	// ankle joint
	
	translate([-7, 0, -h2])
		bearingWithHolders(innerColor = "teal");
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