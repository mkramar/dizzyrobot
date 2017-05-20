use <../lib/shapes.scad>
include <sizes.scad>
use <parts/motor.scad>
use <parts/_shared.scad>

difference()
{
	union()
	{
		color ("turquoise")
			motor5();
		assembly();
	}
	
	translate([0, 0, -30]) cube([100, 100, 100]);
}

module assembly() {
	
	translate([0, 0, motor5H])
	{
		$fn = 50;
		
		cylinder(h = th, d = 30);
		cylinder(h = th + 0.5 + bbh + 0.5 + th, d = bbi);
		
		translate([0, 0, th]) 
		{
			cylinder(h = 0.5, d = bbi + 2);

			translate([0, 0, 0.5]) 
			{
				color("green")
				translate([0, 0, (bbh - th)/2]) 
				{
					ring(d = bbo, h = th, t = (motor5D - bbo)/2, center = false);
					
					translate([0, 0, th])
					{
						ring(d = motor5D - 10, h = th + 0.5 + (bbh - th)/2, t = 5, center = false);
					}
				}

				translate([0, 0, bbh])
				{
					cylinder(h = 0.5, d = bbi + 2);
					
					translate([0, 0, 0.5]) 
					{
						cylinder(d = 16, h = th);
						
						color("orange")
						{
							translate([16, 0, 0]) cylinder(d = 16, h = th);
							translate([-16, 0, 0]) cylinder(d = 16, h = th);
							translate([0, 16, 0]) cylinder(d = 16, h = th);
							translate([0, -16, 0]) cylinder(d = 16, h = th);
						}
					}
				}
			}
		}
	}

	rotate([0, 180, 0])
	{
		$fn = 50;
		
		cylinder(h = th, d = 30);
		translate([0, 0, th]) 
		{
			cylinder(h = 0.5, d = bbi + 2);
			translate([0, 0, 0.5]) 
			{
				cylinder(h = bbh, d = bbi);
				translate([0, 0, bbh]) dCylinder(h = 3, d = 4, x = 1);
			}
		}
	}

	color ("white")
	{
		translate([0, 0, motor5H + th + 0.5 + bbh/2]) bb();
		translate([0, 0, - th - 0.5 - bbh/2]) bb();
	}
}