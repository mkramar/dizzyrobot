use <../lib/shapes.scad>
use <../lib/servo.scad>
include <../_sizes.scad>
include <../_shared.scad>
use <../elec/board-joint.scad>

module body() {
	difference()
	{
		union()
		{
			rotate(part1Rot)
				body1();
		
			body2();
		}
		
		//translate([-25, 0, 0]) cube([50, 50, 50]);		
	}
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
					cylinder(h = 9, d = db + 1, $fn = 50, center = true);
					
					cylinder(d = db - 5, h = 16, center = true, $fn = 50);
					
					// bearing balls
					torus(d = db + 1, w = ball, $fn = 50);
				}
				
				// rotation sensor holder
				
				translate([0, 0, 8])
				{
					translate([-9, 0, 0])
						cube([18, db / 2, 4]);
						
					cylinder(h = 4, d = 18);
				}
			}
			
			//rotate([0, 90, 0])
			//translate([0, 0, -6])
			//	boardJoint();
		}
		
		translate([-25, 0, 0]) cube([50, 50, 50]);
		
		// rotation holder spacing
		
		translate([-8, 0, 0])
		rotate([90, 0, 0])
		rotate([0, -90, 0])
			rotationSensorSpacing();
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
				
				cylinder(d = db + 2, h = 16, center = true, $fn = 50);
				
				// bearing balls
				torus(d = db + 1, w = ball, $fn = 50);
			}
		}
		
		// holes
		
		for (a = [-45, 0, 45, 90])
		{
			rotate(part1Rot)
			rotate([a, 0, 0])
			translate([0, 60, 0])
			rotate([0, 90, 0])
				cylinder(d = 30, h = 20, center = true);
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
