include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/bolt.scad>
use <../../lib/sensor.scad>
use <../../lib/pulley.scad>
use <../../lib/ballBearing.scad>
use <../../brushless/_shared.scad>

bolts = [[6, 22, 0], [-6, 22, 0],
		 [6, -22, 0], [-6, -22, 0],
		 [23, 0, 0], [-23, 0, 0]];

module kneeJoint(preview = false) {
	difference()
	{
		union()
		{
			sideOuterA(preview);
			color("turquoise") sideOuterB(preview);
			
			color("white") ballBearing6805();
			
			sideInner(preview);
		}
		
		//translate([-5, 0, -25])
		//	cube([100, 100, 50]);
	}
}

module sideOuterA(preview = false) {
	z = belt / 2 + thEdge + 1 + rod/2;
	
	difference()
	{
		union()
		{
			difference()
			{
				if (preview)
				{
					cylinder(d = 55, h = belt + 3, center = true);
				}
				else
				{
					pulley(teeth=90, height = belt, center = true, upperBorder = false);
				}
				
				translate([0, 0, -pulleyH / 2 + thEdge])
					cylinder(d = bbo, h = 40, $fn = 100);
					
				cylinder(d = bbo - thEdge * 2, h = 40, center = true, $fn = 100);
			}
			
			// B
			
			difference()
			{
				translate([0, 0, belt / 2])
					cylinder(d = 58, h = rod / 2 + 1 + thEdge, $fn = 100);
					
				if (!preview)
				{
					cylinder(d = bbo, h = 40, center = true, $fn = 100);
					sideOuterMinusRods();
				}
			}
		}
	
		if (!preview)
		{
			for (x = bolts)
			{
				translate(x)
				translate([0, 0, z])
					boltbMinus();
			}
		}
	}
}

module sideOuterB(preview = false) {
	l = rod / 2 + th;
	z = belt / 2 + thEdge + 1 + rod/2;

	difference()
	{
		union()
		{
			translate([0, 0, z])
			intersection()
			{
				shayba(d = 58, h = l * 2, rd = 10);
				cylinder(d = 58, h = l);
			}
			
			intersection()
			{
				cube([18, 100, 30], center = true);
				
				translate([0, 0, bbh / 2])
					ring(d = bboPlastic - 3 * 2, h = rod / 2 + 1 + thEdge, t = 3, center = false);			
			}
		}
		
		if (!preview)
		{
			translate([0, 0, z])
			rotate([0, 0, 90])
				rotationSensorSpacing();
			
			sideOuterMinusRods();
			
			translate([0, 0, z + 4])
				cylinder(d = 20, h = 20);
				
			for (x = bolts)
			{
				translate(x)
				translate([0, 0, z])
					boltaMinus();
			}
		}
	}
}

module sideOuterMinusRods(preview = false) {
	translate([15, 82, belt / 2 + thEdge + 1 + rod / 2])
	rotate([90, 0, 0])
		cylinder(d = rod, h = 100, $fn = 50);
		
	translate([-15, 82, belt / 2 + thEdge + 1 + rod / 2])
	rotate([90, 0, 0])
		cylinder(d = rod, h = 100, $fn = 50);		
}

module sideInner(preview = false) {
	outside = 30;
	
	translate([0, 0, -(outside - thEdge) / 2])
		ring(d = bbi - th * 2, t = th, h = bbh + outside + thEdge, $fn = 70);
		
	translate([0, 0, (bbh + thEdge) / 2])
		ring(d = bbi, t = thEdge, h = thEdge, $fn = 70);
		
	translate([0, 0, 5])
		coneCup(d1 = bbi - 2, d2 = bbi - 10, h = 5.5, th = 2);
		
	translate([0, 0, 11])
		dCylinder(h = 5, d = 4, x = 1, $fn = 20);	
}