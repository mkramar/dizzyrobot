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
}

module motor4(){
	cylinder(d = motor4D, h = motor4H);
	cylinder(d = 25, h = motor4H + pulleyH);
}

module motor5() {
	z = 3;
	
	cylinder(d1 = 30, d2 = motor5D, h = z);
	translate([0, 0, z]) cylinder(d1 = motor5D, d2 = motor5D, h = motor5H - z * 2);
	translate([0, 0, motor5H - z]) cylinder(d1 = motor5D, d2 = 30, h = z);
	
	cylinder(d = 25, h = motor5H + pulleyH);	
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

module motor4BlockA(inner = false) {
	wall = inner ? 0 : th ;
	
	hull() 
	{
		translate([motorAdjustment, 0, wall/2])
			halfShayba(d = motor4SpaceD + wall * 2, h = motor4SpaceH + wall, rd = 15);

		translate([-motorAdjustment, 0, wall/2])
			halfShayba(d = motor4SpaceD + wall * 2, h = motor4SpaceH + wall, rd = 15);
	}
}

module motor5BlockA(inner = false) {
	wall = inner ? 0 : th;
	
	hull() 
	{
		translate([motorAdjustment, 0, wall/2])
			halfShayba(d = motor5SpaceD + wall * 2, h = motor5SpaceH + wall, rd = 15);

		translate([-motorAdjustment, 0, wall/2])
			halfShayba(d = motor5SpaceD + wall * 2, h = motor5SpaceH + wall, rd = 15);
	}
}

module motor5BlockB(inner = false) {
	wall = inner ? 0 : th;
	h = 13;
	
	translate([0, 0, -motor5SpaceH / 2 - h/2])
	rotate([180, 0, 0])
	hull() 
	{
		translate([motorAdjustment, 0, wall/2])
			halfShayba(d = motor5SpaceD + wall * 2, h = h + wall, rd = 15);

		translate([-motorAdjustment, 0, wall/2])
			halfShayba(d = motor5SpaceD + wall * 2, h = h + wall, rd = 15);
	}
}