use <../lib/shapes.scad>
include <common12.scad>
include <common23.scad>
include <../_sizes.scad>
include <../_shared.scad>
include <../elec/board-joint.scad>

part1CableAngle = 10;

module part2()
{    
    difference()
	{
		union()
		{
			com12JointInner();
			
			com12BonePlus();
			
			translate([0, 0, -h])
			rotate([0, 90, 0])
				shayba(d = is + th * 2, h = hs + th * 3, rd=6, $fn = 50);
		}
		
		translate([-com12CableOffset, 0, 0]) com12JointInnerMinus1();
		com12JointInnerMinus2();
		com12JointInnerMinus3();
		com12JointInnerMinus4a();
		com12JointInnerMinus4b();
		com12BoneMinus();

		cableHolderMinus();		
				
		translate([0, 0, -h])
		{
			rotate([0, 90, 0])
			{
				shayba(d = is + 1, h = hs + 1, rd=5, $fn = 50);
				cylinder(d = is - 16, h = hs + 20, center = true);
			}
			
			com23BearingSpacing();
		}		
		
		// cut inside the bone
		
		hull()
		{
			translate([0, 0, -30])
			rotate([0, 90, 0])
				cylinder(d = 10, h = 40, center = true);
			
			translate([0, 0, -120])
			rotate([0, 90, 0])
				cylinder(d = 10, h = 40, center = true);		
		}

        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -25, -h]) cube ([50, 50, 50]);
		//translate([-25, 0, -h]) cube ([50, 50, 50]);
		//translate([0, -50, -h-25]) cube ([50, 50, 100]);
		
		// opening into part1
		
		translate([4, 0, 0])
		hull()
		{
			rotate([30, 0, 0]) cylinder(h = 30, d = 8);
			rotate([-10, 0, 0]) cylinder(h = 30, d = 8);
			rotate([-90, 0, 0]) cylinder(h = 30, d = 8);
		}
			
		// opening into part 3
		
		translate([0, 0, -h])
		{
			rotate([com23MaxAngle, 0, 0])
				com23openingDownPlus(inflate = true);
				
			rotate([com23MinAngle, 0, 0])
				com23openingDownPlus(inflate = true);				
		}
	}
	
	difference()
	{
		part2CableHolderPlus();
		part2CableHolderMinus();
	}
}

module part2CableHolderPlus() {
	intersection()
	{
		com12BoneMinus();
		
		translate([0, 0, -h])
		{
			translate([0, is/2, 0])
			rotate([part1CableAngle, 0, 0])
			translate([0, 0, 30])
				cube([20, 8, 10], center = true);
			
			translate([0, -is/2, 0])
			rotate([-part1CableAngle, 0, 0])
			translate([0, 0, 30])
				cube([20, 8, 10], center = true);
		}
	}	
}

module part2CableHolderMinus() {
	translate([0, 0, -h])
	{
		rotate([part1CableAngle, 0, 0])
		translate([-com23CableOffset, is/2 - 0.6, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
		}
		
		rotate([-part1CableAngle, 0, 0])
		translate([-com23CableOffset, -is/2 + 0.6, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 32]) cylinder(h = 18, d = cd1, $fn = 15);
		}
	}
}