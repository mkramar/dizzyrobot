use <../lib/shapes.scad>
include <../_sizes.scad>
include <../_shared.scad>

module body(side = "a"){
	db = bodyBearingDiam;

	difference()
	{
		intersection()
		{
			rotate(part1RotMinus)
			{
				rotate([0, 90, 0])
					ring(d = db + 11, h = bodyDistance/* - 1*/, t = 3);
					
				translate([-bodyDistance / 2 + 2/* + 1*/, 0, 0])
				rotate([0, 90, 0])
					ring(d = db + 14, h = 4, t = 12);					
			}

			translate([-103, -50, -50])
				cube([100, 100, 100]);
		}

		intersection()
		{
			union(){
				rotate(part1RotMinus)
				translate([-30, 0, 0])
				rotate([-90, 0, 0])
				translate([0, -10, 0])
					cube([50, 20, db]);
					
				rotate(part1RotMinus)
				translate([-30, 0, 0])
				rotate([-30, 0, 0])
				translate([0, -50, 0])
					cube([50, 50, db]);
					
				rotate(part1RotMinus)
				translate([-30, 0, 0])
				rotate([210, 0, 0])
					cube([50, 50, db]);
					
				rotate(part1RotMinus)
				translate([-30, 0, 0])
				rotate([90, 0, 0])
				translate([0, -25, 0])
					cube([50, 50, db]);					
			}
			
			translate([-100, -50, -50])
				cube([100, 100, 100]);					
		}	
		
		for (a = [-47, -27, 27, 47])
		{
			if (side == "a")
			{
				rotate(part1RotMinus)
				rotate([a, 0, 0])
				translate([-bodyDistance / 2 , db / 2 + 14, 0])
				rotate([0, 90, 0])
					boltaMinus();			
			}
			else
			{
				rotate(part1RotMinus)
				rotate([a, 0, 0])
				translate([-bodyDistance / 2 - 2 , db / 2 + 14, 0])
				rotate([0, -90, 0])
					boltbMinus();				
			}		
		}
	}

	translate([-5, 0, 0])
	rotate([0, 90, 0])
	difference()
	{		
		union()
		{
			cylinder(h = 8, d1 = db + 8, d2 = db + 8, center = true);
			cylinder(h = 4, d1 = db + 20, d2 = db + 20, center = true);
		}

		cylinder(h = 10, d1 = db - 8, d2 = db - 8, center = true);

		translate([0, 0, -4.5])
			torus(d = db, w = 4.5, $fn = 50);

		translate([0, 0, 4.5])
			torus(d = db, w = 4.5, $fn = 50);

		//translate([0, 0, -10]) cube([50, 50, 20]);
	}
}

/*
module body()
{
	difference()
	{
		union()
		{
			bigBall();
			connect();
			
			translate([0, 0, i1 / 2 - 2])
			rotate([90, 0, 0])
				cylinder(h = 23, d1 = 8, d2 = 8, $fn = 10);

			translate([0, 0, -i1 / 2 + 2])
			rotate([90, 0, 0])
				cylinder(h = 23, d1 = 8, d2 = 8, $fn = 10);
		}
		
		translate([-15, 0, -h/2]) cube([50, 50, h + 50]);
		
		translate(part1Off)
			sphere(d = o1 + 5, $fn = 50);
		
		smallBall();
		smallBallMinus3();
		connect(minus = true);	
		
		translate([0, 0, i1 / 2 - 2])
		rotate([90, 0, 0])
			cylinder(h = 40, d1 = 3, d2 = 3, $fn = 10);
			
		translate([0, 0, -i1 / 2 + 2])
		rotate([90, 0, 0])
			cylinder(h = 40, d1 = 3, d2 = 3, $fn = 10);			
	}
}

module connect(minus = false){
	d = i1 - 10;
	
	rotate([0, -10, -10])
	rotate([0, -90, 0])
	difference()
	{
		if (minus)
		{
			translate([0, 0, -1])
				cylinder(h = bodyDistance / 2 + 2, d1 = d - 6, d2 = d - 6);
		}
		else
		{
			cylinder(h = bodyDistance / 2, d1 = d, d2 = d);
		}
	}
}
*/