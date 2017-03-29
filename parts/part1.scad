use <../lib/shapes.scad>
include <common01.scad>
include <common12.scad>
include <../_sizes.scad>
include <../_shared.scad>

part1BoltHolder1 = [0, -4, 31 - h];
part1BoltHolder2 = [0, 22, -h-19];

module part1()
{    
    difference()
	{
        union()
        {
			rotate([0, 0, 90])
            difference()
            {
                smallBall();
                translate([-com01CableOffset, 0, 0])
				smallBallMinus1();
            }
            
            com01BonePlus();

            translate([0, 0, -h])
                bigBall();
        }
        
        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -30, -h]) cube ([50, 60, 50]);        
		
		rotate([0, 0, 90])
		{
			smallBallMinus2();
			smallBallMinus3();
			smallBallMinus4a();
			smallBallMinus4b();
		}
		
        com01BoneMinus();
		
		translate([0, -com01CableOffset, -i1/2 + 2.5])
		rotate([0, 90, 0])
			cylinder(h = 40, d1 = 2, d2 = 2, center = true, $fn = 10);
        
        translate([0, 0, -h])
        {
            smallBall(inflate = 2);
            smallBallMinus3();
			//smallBallMinus4a();
			smallBallMinus4b();
        
			// opening for part 2 bone
			
            hull()
            {
                rotate([-part1angle1, 0, 0])
                    com12BonePlus(inflate = 2);
                
                rotate([(-part1angle1-part1angle2)/2, 0, 0])
                    com12BonePlus(inflate = 2);
            }
			
            hull()
            {
                rotate([(-part1angle1-part1angle2)/2, 0, 0])
                    com12BonePlus(inflate = 2);
                
                rotate([-part1angle2, 0, 0])
                    com12BonePlus(inflate = 2);
            }			
        }
		
		// opening to part 0
		
		translate([0, 2, 0])
		hull()
		{
			rotate([0, 20, 0])
				cylinder(d = 5, h = 30);

			rotate([0, -60, 0])
				cylinder(d = 5, h = 30);
		}
    }
	
	// cable holders
	
	difference()
	{
		part1CableHolderPlus();
		part1CableHolderMinus();
	}
	
	// bolt holder
	
	translate(part1BoltHolder2)
	rotate([0, 90, 0])
		cylinder(h = 16, d = 10, center = true);		
}

module part1CableHolderPlus() {
	intersection()
	{
		com01BoneMinus();
		
		union()
		{
			translate([0, 0, -h])
			{
				rotate([12, 0, 0])
				translate([0, i1/2, 33])
					cube([30, 8, 10], center = true);
				
				rotate([-30, 0, 0])
				translate([0, -i1/2, 33])
					cube([30, 8, 10], center = true);
			}		

			// bolt holder
			
			translate(part1BoltHolder1)
			rotate([0, 90, 0])
				cylinder(h = 30, d = 10, center = true);	
		}
	}	
}

module part1CableHolderMinus() {
	translate([0, 0, -h])
	{
		rotate([12, 0, 0])
		translate([-com12CableOffset, i1/2, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
		}
		
		rotate([-30, 0, 0])
		translate([-com12CableOffset, -i1/2, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
		}
	}
}