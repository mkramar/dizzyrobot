use <../lib/shapes.scad>
include <../_sizes.scad>

com23MaxAngle = -45;
com23MinAngle = 20;
com23CableOffset = 0; // offset from center to the cable ring

com23JointD = 35;
com23JointH = 20;

h3 = com23JointD + th * 2 + 3;

module com23BearingSpacing()
{
	union()
	{
		translate([com23JointH/2, 0, 0])
		rotate([0, 90, 0])
			torus(d = com23JointD - 8, w = ball, $fn = 50);
			
		translate([-com23JointH/2, 0, 0])
		rotate([0, 90, 0])
			torus(d = com23JointD - 8, w = ball, $fn = 50);	
	}
}

module com23openingDownPlus(inflate = false) {
	d = inflate ? 10 : 8;
	intersection()
	{
		rotate([0, 90, 0])
			cylinder(d = com23JointD + th * 3, h = 50, center = true);
		
		hull()
		{
			rotate([180 - 30, 0, 0]) 
			{
				translate([-4, 0, 0]) cylinder(d = d, h = 30);
				translate([+4, 0, 0]) cylinder(d = d, h = 30);
				
			}
			rotate([180 + 30, 0, 0]) 
			{
				translate([-4, 0, 0]) cylinder(d = d, h = 30);
				translate([+4, 0, 0]) cylinder(d = d, h = 30);
			}
		}
	}
}

module com23openingDownMinus() {
	intersection()
	{
		rotate([0, 90, 0])
			cylinder(d = h3 + th * 2 + 1, h = 50, center = true);
			
		hull()
		{
			rotate([180 - 30, 0, 0]) 
			{
				translate([-3, -1, 0]) cylinder(d = 4, h = 30);
				translate([+3, -1, 0]) cylinder(d = 4, h = 30);
				
			}
			rotate([180 + 30, 0, 0]) 
			{
				translate([-3, 1, 0]) cylinder(d = 4, h = 30);
				translate([+3, 1, 0]) cylinder(d = 4, h = 30);
			}
		}
	}
}
