use <../lib/shapes.scad>
use <../lib/servo.scad>
include <../_sizes.scad>
include <../_shared.scad>
use <../elec/board-joint.scad>

module body() {
	rotate(part1Rot)
		body1();
	
	body2();
}

module body1(side = "a"){
	db = bodyBearingDiam;

	difference()
	{
		union()
		{
			rotate([0, -90, 0])
			{
				difference()
				{
					halfShayba(d = db + 15, h = 8, rd = 6, $fn=50);
					
					// this is part0
					shayba(h = 7, d = db + 1, rd=3, $fn = 50);
					
					cylinder(d = db - 5, h = 16, center = true, $fn = 50);
					
					// bearing balls
					torus(d = db + 1, w = 5, $fn = 50);
				}
				
				// this holds the board-joint
				union()
				{
					translate([0, 0, 10])
					{
						difference()
						{
							union()
							{
								ring(d = boardSize * 1.42 - 10, h = 4, t = 5, $fn = 50);
								rotate([0, 0, 45])
									cube([8, db, 4], center = true);
							}		
							
							translate([0, 0, -2])
								cube([boardSize, boardSize, 5], center = true);
						}
					}
				}
			}
			
			//rotate([0, 90, 0])
			//translate([0, 0, -6])
			//	boardJoint();
		}
		
		translate([-25, 0, 0]) cube([50, 50, 50]);
	}
	
	//#rotate([0, 90, 0])
	//translate([0, 0, -6])
	//cylinder(d = 200, h = th);
}

module body2() {
	db = bodyBearingDiam;

	difference()
	{
		intersection()
		{
			body2Plus();

			rotate(part1Rot)
			rotate([0, 90, 0])
			difference()
			{
				cylinder(d = 180, h = 5);
				
				cylinder(d = db - 5, h = 16, center = true, $fn = 50);
				// bearing balls
				torus(d = db + 1, w = 5, $fn = 50);
			}
		}

		//translate([-25, 0, 0]) cube([50, 50, 50]);		
	}
	
	intersection()
	{
		difference()
		{
			body2Plus();
			
			hull()
			{
				translate([-bodyDistance/2, 20, 20])
					sphere(d = 130);
				
				translate([-bodyDistance/2, 40, -20])
					sphere (d =110);
					
				translate([-bodyDistance/2, 140, -5])
					sphere (d =120);					
			}			
		}
		
		intersection()
		{
			rotate(part1Rot)
			rotate([0, -90, 0])
				cylinder(d = 400, h = 200);
			
			translate([-bodyDistance/2, 0, 0])
			rotate([0, 90, 0])
				cylinder(d = 400, h = 200);
		}
	}
		
	//#translate([-20, 20, 10])
	//	sphereSector(d = 120, w = th, a = 45);
	
	//#translate([-20, 50, -10])
	//sphere(d = 100);
	
	//#translate([-20, 200, -10])
	//sphere(d = 100);
	
	//#translate([-20, 250, 10])
	//sphere(d = 120);	
	
	// translate([-40, 40, 0])
	// rotate([0, -20, 0])
		// sphereSector(d = 120, w = th, a = 45);

	// translate([-10, 60, 0])
	// rotate([180, -20, 0])
		// sphereSector(d = 100, w = th, a = 45);

	// translate([-20, 220, 0])
	// rotate([180, -20, 0])
		// sphereSector(d = 100, w = th, a = 45);	
}

module body2Plus() {
	hull()
	{
		translate([-bodyDistance/2, 20, 20])
			sphere(d = 140);
		
		translate([-bodyDistance/2, 40, -20])
			sphere (d =120);
			
		translate([-bodyDistance/2, 140, -5])
			sphere (d =130);
	}
}
