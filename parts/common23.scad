use <../lib/shapes.scad>
include <../_sizes.scad>

com23MaxAngle = 45;
com23MinAngle = -20;
com23CableOffset = 3; // offset from center to the cable ring

h3 = is + th * 2 + 3;

module com23BearingSpacing()
{
	union()
	{
		translate([hs/2, 0, 0])
		rotate([0, 90, 0])
			torus(d = is - 6, w = 5.5, $fn = 50);
			
		translate([-hs/2, 0, 0])
		rotate([0, 90, 0])
			torus(d = is - 6, w = 5.5, $fn = 50);	
	}
}

module com23openingDownPlus(inflate = false) {
	d = inflate ? 9 : 8;
	intersection()
	{
		rotate([0, 90, 0])
			cylinder(d = is + th * 3, h = 50, center = true);
		
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
