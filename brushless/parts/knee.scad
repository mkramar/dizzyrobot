include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

kneeAxisOffset = 50;
kneeMotorOffset = 33;

module knee() {
	difference()
	{
		color("turquoise")
		translate([kneeMotorOffset - 20, 0, 0])
		{
			difference()
			{
				kneeA(outer = true);
				kneeA(outer = false);
			}
			
			intersection()
			{
				kneeA(outer = true);
				
				union()
				{
					h = (motor5SpaceD - bbiPlastic) / 2;
					
					translate([-5, -th/2, -bbiPlastic/2 - h])
						cube([25, th, h]);
						
					translate([-5, -bbiPlastic/2 - h, -th/2])
						cube([25, h, th]);
						
					translate([-5, bbiPlastic/2 - h, -th/2])
						cube([25, -h, th]);	
				}
			}		
		}
		
		rotate([0, -90, 0])
			cylinder(d = 70, h = 20);
		
		translate([-70, 0, -20])
			cube([200, 100, 150]);
			
		translate([-100, -100, 0])
			cube([100, 100, 100]);
	}

	{
		x = (bbh/2);
		l = kneeMotorOffset - x;

		color("turquoise")
		translate([l / 2 + x, 0, 0])
		rotate([0, 90, 0])
			ring(d = bbiPlastic, h = l, t = th);
	}
}

module kneeA(outer = true){
	d = outer ? th : 0;
	h = (outer ? th * 2 : 0) + 40;

	hull()
	{
		translate([0, 0, kneeAxisOffset + motorAdjustment])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = 15);
			
		translate([0, 0, 0])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = 15);
	}
}

module kneeRods() {
	translate([-2, 20, kneeAxisOffset + motor5D / 2 - 5])
		cylinder(d = rod, h = 100, $fn = 50);
		
	translate([-2, -20, kneeAxisOffset + motor5D / 2 - 5])
		cylinder(d = rod, h = 100, $fn = 50);		
}
