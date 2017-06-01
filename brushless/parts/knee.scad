include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>
use <../_shared.scad>
use <../../lib/pulley.scad>

kneeAxisOffset = 50;
kneeH = 40;
kneeMotorOffset = 32;
kneeMotorOffset2 = kneeH - kneeMotorOffset;
kneeMiddle = kneeH/2 - (kneeH - kneeMotorOffset);
kneeCutoff = kneeAxisOffset + 70;

kneeRodsUp1 = [kneeMiddle, 26, kneeAxisOffset + motor5D / 2 + 8];
kneeRodsUp2 = [kneeMiddle, -26, kneeAxisOffset + motor5D / 2 + 8];

kneeBoltsX = 17;

kneeBoltPositions = [[-25, 29, kneeMiddle],
					 [-kneeCutoff+5, kneeBoltsX, kneeMiddle], [-kneeCutoff+5, -kneeBoltsX, kneeMiddle],
					 [-kneeCutoff+37-5, kneeBoltsX, kneeMiddle], [-kneeCutoff+37-5, -kneeBoltsX, kneeMiddle],
					 [-kneeCutoff+40, -28, kneeMiddle]];

module knee(preview = false) {
	difference()
	{
		color("turquoise")
		union()
		{
			translate([kneeMotorOffset - 20, 0, 0])
			{
				difference()
				{
					kneeA(outer = true);
					if (!preview) kneeA(outer = false);
					
					translate([-50, -50, kneeCutoff])
						cube([100, 100, 100]);					
				}
			
				if (!preview)
				{
					// holder for upper rods
				
					intersection()
					{
						kneeA(outer = true);					
						
						union()
						{
							translate([-30, -kneeBoltsX-30, kneeCutoff - 10]) cube([80, 30, 10]);							
							translate([-30, -kneeBoltsX-30, kneeCutoff - 37]) cube([80, 30, 10]);
							translate([-30, kneeBoltsX, kneeCutoff - 10]) cube([80, 30, 10]);							
							translate([-30, kneeBoltsX, kneeCutoff - 37]) cube([80, 30, 10]);
						}
					}
					
					// bolts

					intersection()
					{
						kneeA(outer = true);					
									
						rotate([0, 90, 0])
						for (x = kneeBoltPositions)
						{
							translate(x)
							translate([0, 0, -35])
								cylinder(h = 60, d = 10);
						}
					}
				}
			}
			
			// bearing holder for knee axis
			
			translate([kneeMotorOffset - kneeH, 0, 0])
			rotate([0, 90, 0])
				ring(d = bb6800o, h = bb6800h, t = th, center = false);
				
			translate([kneeMotorOffset - bb6800h, 0, 0])
			rotate([0, 90, 0])
				ring(d = bb6800o, h = bb6800h, t = th, center = false);
		}
		
		if (!preview)
		{
			translate([kneeMiddle, 0, 70])
				cylinder(d = rod, h = 50);
				
			kneeRods();
			
			translate([kneeMotorOffset, 0, 0])
			rotate([0, 90, 0])
				rotationSensorSpacing();
			
			translate([0, 0, kneeAxisOffset])
			translate([kneeMotorOffset + 5, 0, 0])
			rotate([90, 0, 0])
			rotate([0, -90, 0])
				motor5BoltSpace();
		}
		
		// opening for part 2
		
		hull()
		{
			rotate([-120, 0, 0])
			translate([kneeMiddle, 0, -100])
				cylinder(d = 15, h = 100);
					
			rotate([-60, 0, 0])
			translate([kneeMiddle, 0, -100])
				cylinder(d = 15, h = 100);
					
			translate([kneeMiddle, 15, -90])
				cylinder(d = 15, h = 100);
		}
			
		// translate([-70, 0, -20])
			// cube([200, 100, 150]);
			
		// translate([-100, -100, 0])
			// cube([100, 100, 100]);
	}
}

module kneeA(outer = true){
	d = outer ? th : 0;
	h = (outer ? th * 2 : 0) + kneeH;
	rd = outer ? 15 : 10;
	
	hull()
	{
		translate([0, 0, kneeAxisOffset + kneeCutoff])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = rd);
			
		translate([0, 0, 0])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = rd);
	}
}

module kneeRods() {
	translate(kneeRodsUp1)
		cylinder(d = rod, h = 100, $fn = 50);
		
	translate(kneeRodsUp2)
		cylinder(d = rod, h = 100, $fn = 50);		
}

module kneeAxisAssembly() {
	color("white")
	translate([kneeMotorOffset - kneeH, 0, 0])
	rotate([0, 90, 0])
	{
		cylinder(d = 10, h = kneeH);
		
		translate([0, 0, bb6800h/2]) bb6800();
		translate([0, 0, kneeH-bb6800h/2]) bb6800();
	}
}

module kneePulley(){
	rotate([0, 90, 0])
	{
		difference()
		{
			pulley(teeth=90, height = belt, center = true, upperBorder = true);

			mirror([0, 0, 1])
			translate([0, 0, -2])
				cylinder(d = bb6800o + th*2 + 4, h = 20);
		}
		
		translate([0, 0, -(kneeMotorOffset2 - bb6800h)])
			ring(d = rod + 0.6, h = kneeH - (bb6800h*2), t = th, center = false);
	}
}

module kneeRodsDown() {
	// rotate([-15, 0, 0])
	// {
		// translate([10, 15, -90])
			// cylinder(d = rod, h = 100);
			
		// translate([21, 15, -90])
			// cylinder(d = rod, h = 100);
	// }
		
	rotate([0, 0, 0])
	translate([kneeMiddle, 0, 0])
	{
		translate([0, 15, -85])
			cylinder(d = rod, h = 100);
		
		translate([0, 0, -110])
			cylinder(d = rod, h = 100);
	}
}
