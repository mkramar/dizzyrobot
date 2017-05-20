include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

part1CaseOffset = part1MotorX - 6;

module part1(preview = false) {
	difference()
	{
		union()
		{
			difference()
			{
				part1Base(preview = preview);
				
				if (!preview)
				{
					translate([-0.1, 0, 0])
						part1Base(inner = true, preview = preview);
				}		
			}

			if (!preview)
			{
				// upper axis connection
				
				intersection()
				{
					part1Base(outer = true);
					
					translate([part1CaseOffset, 0, 0])
					union()
					{
						h = (motor5SpaceD - bbiPlastic) / 2;
						
						translate([-5, -th/2, bbiPlastic/2])
							cube([25, th, h]);
							
						translate([-5, -bbiPlastic/2 - h, -th/2])
							cube([25, h, th]);
							
						translate([-5, bbiPlastic/2, -th/2])
							cube([25, h, th]);	
					}
				}
				
				{
					x = (bbh/2);
					l = 34 - x;
					$fn = preview ? 25 : 60;

					translate([l / 2 + x, 0, 0])
					rotate([0, 90, 0])
						ring(d = bbiPlastic, h = l, t = th);
				}
				
				// lower axis connection
				
				intersection()
				{
					part1Base(outer = true);
					
					translate([part1CaseOffset, 0, -h1])
					union()
					{
						h = (motor5SpaceD - bbiPlastic) / 2;
						
						translate([-5, -th/2, -bbiPlastic/2 - h])
							cube([25, th, h]);
							
						translate([-5, -bbiPlastic/2 - h, -th/2])
							cube([25, h, th]);
							
						translate([-5, bbiPlastic/2, -th/2])
							cube([25, h, th]);	
					}
				}
				
				{
					x = (bbh/2);
					l = 34 - x;
					$fn = preview ? 25 : 60;

					translate([l / 2 + x, 0, -h1])
					rotate([0, 90, 0])
						ring(d = bbiPlastic, h = l, t = th);
				}
			}
		}
		
		if (!preview)
		{
			rotate([0, -90, 0])
				cylinder(d = 70, h = 20);
			
			translate([0, 0, -h1])
			rotate([0, -90, 0])
				cylinder(d = 70, h = 20);		
		}
		
		if (!preview)
		{
			translate(part1HeapMotorOffset)
			rotate([90, 0, 0])
			rotate([0, 90, 0])
			translate([0, 0, 10])
				motor5BoltSpace();
				
			translate(part1KneeMotorOffset)
			rotate([90, 0, 0])
			rotate([0, 90, 0])
			translate([0, 0, 10])
				motor5BoltSpace();
		}
			
		// translate([-50, 0, -200])
			// cube ([100, 100, 300]);				
	}
}

module part1Base(inner = false, preview = true) {
	d = !inner ? th : 0;
	h = (!inner ? th * 2 : 0) + 40;
	$fn = preview ? 25 : 60;

	translate([part1CaseOffset, 0, 0])
	hull()
	{
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = 15);
			
		translate([0, 0, -h1])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = 15);			
	}
}

module part1Motors(){
	translate(part1HeapMotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -motor5H / 2])
		motor5();
		
	// knee motor
	translate(part1KneeMotorOffset)
	rotate([0, -90, 0])
	translate([0, 0, -motor5H / 2])
		motor5();		
}