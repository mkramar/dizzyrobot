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
				cylinder(d = bbo + bbMargin * 2, h = belt + 5, $fn = 70, center = true);
			}
		}
		else
		{
			ring(d = bbo + bbMargin * 2, t = th, h = bbh + thEdge, $fn = 70);
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

module bearingInner(showBearing = true, color) {
	outside = 10;

	if (showBearing)
	{
		color("white")
		rotate([0, -90, 0])
			ballBearing(inner = bbi, outer = bbo, height = bbh);
	}
		
	// inner

	color(color)
	{
		translate([(outside - thEdge) / 2, 0, 0])
		rotate([0, 90, 0])
			ring(d = bbi - (th + bbMargin) * 2, t = th, h = bbh + outside + thEdge, $fn = 70);
			
		translate([(-bbh - thEdge) / 2, 0, 0])
		rotate([0, 90, 0])
		{
			ring(d = bbi - bbMargin * 2, t = thEdge, h = thEdge, $fn = 70);
			
			translate([0, 0, (th - thEdge) / 2])
				cube([6, bbi - 2, th], center = true);
				
			translate([0, 0, -2])
			dCylinder(h = 5, d = 4, x = 1, $fn = 20);	
		}
	}
}

module motor4(){
	cylinder(d = motor4D, h = motor4H);
	cylinder(d = 14, h = motor4H + 15);
}

module motor5() {
	cylinder(d = motor5D, h = motor5H);
	cylinder(d = 14, h = motor5H + 15);
}
module motor5BoltSpace(){
	d = 25 / sqrt(2) / 2;
	
	for (x = [-d, d])
	for (y = [-d, d])
		translate([x, y, 0])
		hull()
		{
			translate([0, motorAdjustment, 0])
				cylinder(d = 4, h = 10);
				
			translate([0, -motorAdjustment, 0])
				cylinder(d = 4, h = 10);
		}
		
	hull()
	{
		translate([0, motorAdjustment, 0])
			cylinder(d = 10, h = 10);
			
		translate([0, -motorAdjustment, 0])
			cylinder(d = 10, h = 10);			
	}
}