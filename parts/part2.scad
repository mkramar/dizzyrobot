use <../lib/shapes.scad>
include <common12.scad>
include <common23.scad>
include <../_sizes.scad>
include <../_shared.scad>
include <../elec/board-joint.scad>

module part2()
{    
    difference()
	{
		union()
		{
			// main
			
			difference()
			{
				union()
				{
					difference()
					{
						//smallBall();
						//smallBallMinus1();
					}
					
					com12BonePlus();
					
					translate([0, 0, -h])
					rotate([0, 90, 0])
						shayba(d = is + th * 2, h = hs + th * 3, rd=6, $fn = 50);		
				}
				
				//smallBallMinus2();
				//smallBallMinus3();
				//smallBallMinus4a(half = true);
				//smallBallMinus4b();
				com12BoneMinus();
				
				translate([0, 0, -h])
				rotate([0, 90, 0])
				{
					shayba(d = is - 1, h = hs - 1, rd=5, $fn = 50);
					shayba(d = is - 16, h = hs + 4, rd = 4);
				}
			}
			
			// cable holder
			/*
			intersection()
			{
				com23BoneMinus();
				
				translate([0, 0, -h])
				{
					translate([0, cableOffset, 0])
					rotate([cableAngle, 0, 0])
					difference()
					{
						translate([0, 0, 15])
						intersection()
						{
							translate([-5, -3]) cube([10, 6, 20])
							rotate([90 - cableAngle, 0, 0]) cube([30, 30, 30]);
						}
					}
					
					translate([0, -cableOffset, 0])
					rotate([-cableAngle, 0, 0])
					difference()
					{
						translate([0, 0, 15])
						intersection()
						{
							translate([-5, -3]) cube([10, 6, 20])
							rotate([cableAngle, 0, 0]) cube([30, 30, 30]);
						}
					}
				}
			}
			*/
		}
        
        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -25, -h]) cube ([50, 50, 50]);
		//translate([-25, 0, -h]) cube ([50, 50, 50]);
		translate([0, -50, -h-25]) cube ([50, 50, 50]);
        
		translate([0, 0, -h])
		rotate([0, 90, 0])		
		{
			cylinder(d = is-12, h = hs - th * 2, center = true);
				
			// rotate([0, 0, 180])
				// dCylinder(d = is - 8, h = hs+20, x = (is-8)/2 + 2);
		}
			
		translate([0, 0, -h])
		{
			com23BearingSpacing();
			
			// cable spacing

			translate([0, cableOffset, 0])
			rotate([cableAngle, 0, 0])
			{
				cylinder(h = 100, d = cd2, center = true, $fn = 8);
				translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
			}
			
			translate([0, -cableOffset, 0])
			rotate([-cableAngle, 0, 0])
			{
				cylinder(h = 100, d = cd2, center = true, $fn = 8);
				translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
			}			
		
			// opening into part 3
		
			rotate([com23MaxAngle, 0, 0])
				com23openingDownPlus(inflate = true);
				
			rotate([com23MinAngle, 0, 0])
				com23openingDownPlus(inflate = true);				
		}
	}
}
