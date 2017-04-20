include <_sizes.scad>
use <../lib/shapes.scad>
use <../lib/ballBearing.scad>
use <../lib/pulley.scad>
use <../lib/sensor.scad>

difference()
{
	bearingOuter();
	translate([-50, 0, 0])
	cube ([100, 100, 100]);
}

module bearingOuter(withPulley = true) {
	translate([-thEdge/2, 0, 0])
	rotate([0, -90, 0])
		if (withPulley)
		{
			difference()
			{
				pulley(teeth=70, height = belt, center = true);
				cylinder(d = bbo, h = belt + 5, $fn = 70, center = true);
			}
		}
		else
		{
			ring(d = bbo, t = th, h = bbh + thEdge, $fn = 70);
		}

	// this stops the bearing
	
	translate([(-bbh - thEdge - 1) / 2, 0, 0])
	rotate([0, -90, 0])
		ring(d = bbo - thEdge * 2, t = thEdge * 2, h = thEdge + 1, $fn = 70);
		
	// sensor holder
	
	translate([(-bbh - th) / 2 - 1, 0, 0])
	rotate([0, -90, 0])
	difference()
	{
		cylinder(h = th, d = bbo);
		
		rotationSensorSpacing();
		
		translate([0, 11, 0])
			cylinder (d =6, h = 10, center = true);

		translate([0, -11, 0])
			cylinder (d =6, h = 10, center = true);
	}
}

module bearingInner(showBearing = true) {
	outside = 10;

	if (showBearing)
	{
		color("white")
		rotate([0, -90, 0])
			ballBearing(inner = bbi, outer = bbo, height = bbh);
	}
		
	// inner

	translate([(outside - thEdge) / 2, 0, 0])
	rotate([0, 90, 0])
		ring(d = bbi - th * 2, t = th, h = bbh + outside + thEdge, $fn = 70);
		
	translate([(-bbh - thEdge) / 2, 0, 0])
	rotate([0, 90, 0])
	{
		ring(d = bbi, t = thEdge, h = thEdge, $fn = 70);
		
		translate([0, 0, (th - thEdge) / 2])
			cube([6, bbi - 2, th], center = true);
			
		translate([0, 0, -2])
		dCylinder(h = 5, d = 4, x = 1, $fn = 20);	
	}
}