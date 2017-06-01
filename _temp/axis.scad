use <../lib/shapes.scad>
use <../brushless/_shared.scad>
include <../brushless/_sizes.scad>

th = 3;

bb6800i = 10;
bb6800o = 19;
bb6800h = 5;

// axis 1

bearing1 = 15;
bearing2 = 50;
d1 = 65;
ring1Offset = 22;
axis1Angle1 = 80;
axis1Angle2 = 210;

// axis 2

axis2 = 45;
d2 = 72;
ring2Offset = -axis2/2 + bb6800h + th + 2;
axis2Offset = -5;
axis2Angle1 = 90;
axis2Angle2 = 300;

motorOffset = 33 + ring2Offset - 5;

angle1 = 0;
angle2 = 0;

// body

color("turquoise")
{
	translate([60, 0, (d1 + 25)/2 - 4])
	rotate([0, -90, 0])
		motor4();

	translate([bearing1 - th, 0, 0])
	rotate([0, 90, 0])
	{
		cylinder(d = bb6800o + th*2, h = th);
		
		translate([0, 0, th])
			ring(d = bb6800o, h = bb6800h, t = th, center = false);
	}
		
	translate([bearing2, 0, 0])
	rotate([0, 90, 0])
	{
		cylinder(d = bb6800o + th*2, h = th);
		
		translate([0, 0, -bb6800h])
			ring(d = bb6800o, h = bb6800h, t = th, center = false);
		
	}
}

rotate([angle1, 0, 0])
{
	connSquareY = axis2 - (bb6800h + th + 1)*2;
	connSquareZ = 30;
	// axis1 with small ring
	
	color("pink")
	{
		translate([ring1Offset, 0, 0]) 
		{
			rotate([0, 90, 0])
			{
				ringSector(d = d1 - 10, h = 10, t = 5, start_angle = axis1Angle1, end_angle = axis1Angle2);
				cylinderSector(d = d1 - 10, h = th, start_angle = axis1Angle1, end_angle = axis1Angle2);
			}
			
			// translate([-20, -connSquareY/2 - th, connSquareZ + axis2Offset])
				// cube([20, connSquareY + th*2, th]);
		}

		translate([bearing1, 0, 0])
		rotate([0, 90, 0])
			ring(d = rod + 0.6, h = bearing2 - bearing1, t = th, center = false);
	}

	color("white")
	{
		translate([bearing1, 0, 0])
		rotate([0, 90, 0])
			cylinder(d = 10, h = bearing2 - bearing1);
		
		translate([bearing1, 0, 0]) rotate([0, 90, 0]) bb6800();
		translate([bearing2, 0, 0]) rotate([0, 90, 0]) bb6800();
	}
	
	translate([0, 0, axis2Offset])
	{
		// axis2 with big ring

		color("pink")
		{
			difference()
			{
				union()
				{
					translate([0, ring2Offset + 10 - th, 0])
					rotate([90, 0, 0])
						//ringSector(d = d2 - 10, h = 10, t = 5, start_angle = axis2Angle1, end_angle = axis2Angle2);
						ring(d = d2 - 10, h = 10, t = 5, center = false);
					
					translate([0, ring2Offset, 0])
					rotate([90, 0, 0])
						//cylinderSector(d = d2 - 10, h = th, start_angle = axis2Angle1, end_angle = axis2Angle2);
						cylinder(d = d2 - 10, h = th);
				}
				
				rotate([0, 30, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);
					
				rotate([0, 70, 0])
				translate([0, -axis2/2, 0])
					cube([100, 20, 100]);
					
			}
			
			rotate([90, 0, 0])		
				ring(d = rod + 0.6, h = axis2, t = th, center = true);
			
			// translate([(rod + 0.6)/2, -connSquareY/2, 0])
				// cube([th, connSquareY, connSquareZ]);
				
			intersection()
			{
				h = 31;
				
				union()
				{
					translate([ring1Offset, h/2, 0])
					rotate([90, 0, 0])
						ringSector(d = 55, h = h, t = th, start_angle = 90, end_angle = 180);
						
					translate([ring1Offset - 3, h/2, 9])
					rotate([90, 0, 0])
						ringSector(d = 26, h = h, t = th, start_angle = 60, end_angle = 200);
				}
				
				translate([-rod/2 - th, -h/2, 0])
					cube([ring1Offset + rod/2 + th, h, 40]);
			}
		}

		color("white")
		{
			rotate([90, 0, 0])
				cylinder(d = 10, h = axis2, center = true);
			
			translate([0, axis2/2 - 2.5, 0]) rotate([90, 0, 0]) bb6800();
			translate([0, -axis2/2 + 2.5, 0]) rotate([90, 0, 0]) bb6800();
		}

		//

		rotate([0, angle2, 0])
		{
			translate([0, (axis2 + bb6800h)/2, 0])
			{
				translate([0, -th, 0])
				rotate([90, 0, 0]) 
					ring(d = bb6800o, h = bb6800h, t = th, center = false);
				
				hull()
				{
					rotate([90, 0, 0]) cylinder(d = bb6800o + th*2, h = th);
					translate([0, 0, -100]) rotate([90, 0, 0]) cylinder(d = 20, h = th);
				}
			}		

			translate([0, -(axis2 + bb6800h)/2 + th, 0])
			{
				translate([0, bb6800h, 0])
				rotate([90, 0, 0]) 
					ring(d = bb6800o, h = bb6800h, t = th, center = false);
			
				hull()
				{
					rotate([90, 0, 0]) cylinder(d = bb6800o + th*2, h = th);
					translate([0, 0, -100]) rotate([90, 0, 0]) cylinder(d = 20, h = th);
				}
			}
			
			translate([0, motorOffset, -(d2 + 25)/2 + 4])
			rotate([90, 0, 0])
				motor5();
		}
	}
}
