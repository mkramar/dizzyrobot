use <../lib/shapes.scad>
include <common12.scad>
include <common23.scad>
include <../_sizes.scad>
include <../_shared.scad>
include <../elec/board-joint.scad>

part2CableAngle = 11;

module part2()
{    
    difference()
	{
		union()
		{
			com12JointInner();
			
			bone2Plus();
			
			translate([0, 0, -h])
			rotate([0, 90, 0])
				shayba(d = com23JointD + th * 2, h = com23JointH + th * 3, rd=6, $fn = 50);
		}
		
		translate([-com12CableOffset, 0, 0]) com12JointInnerMinus1();
		com12JointInnerMinus2();
		com12JointInnerMinus3();
		//com12JointInnerMinus4a();
		//com12JointInnerMinus4b();
		bone2Minus();
		
		rotate([0, -90, 0])
			cylinder(h = com12JointH + 1, d = com12JointD - ball * 2 - th * 2);
		
		translate([com12JointH / 2, 0, 0])
		rotate([0, -90, 0])		
			rotationSensorSpacing();

		part2CableHolderMinus();		
		
		translate([0, 0, -h])
		{
			rotate([0, 90, 0])
			{
				shayba(d = com23JointD + 2, h = com23JointH + 2, rd=5, $fn = 50);
				cylinder(d = com23JointD - 18, h = com23JointH + 20);
			}
			
			com23BearingSpacing();
		}	


		// cut on the side of the bone
		
		hull()
		{
			translate([0, 0, -50])
			rotate([0, 90, 0])
				cylinder(d = 10, h = 40, center = true);
			
			translate([0, 0, -h + 40])
			rotate([0, 90, 0])
				cylinder(d = 10, h = 40, center = true);		
		}

        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -25, -h]) cube ([50, 50, 50]);
		//translate([-25, 0, -h]) cube ([50, 50, 50]);
		translate([0, -50, -h-25]) cube ([50, 50, 100]);
		

		// opening into part1
		
		//translate([4.5, 0, 0])
		//hull()
		//{
		//	rotate([90, 0, 0]) cylinder(h = 30, d = 5);
		//	rotate([30, 0, 0]) cylinder(h = 30, d = 5);
		//	rotate([-20, 0, 0]) cylinder(h = 30, d = 5);
		//}

		translate([-4.5, 0, 0])
		hull()
		{
			rotate([90, 0, 0]) cylinder(h = 30, d = 5);
			rotate([30, 0, 0]) cylinder(h = 30, d = 5);
			rotate([-20, 0, 0]) cylinder(h = 30, d = 5);
		}		
		
		// opening into part 3
		
		translate([0, 0, -h])
		{
			rotate([com23MaxAngle, 0, 0])
				com23openingDownPlus(inflate = true);
				
			rotate([com23MinAngle, 0, 0])
				com23openingDownPlus(inflate = true);				
		}
		
		// shifted pull entry
		
		translate([0, 0, -com23JointD/2 - 14])
		rotate([90, 0, 0])
			cylinder(h = 20, d = cd2, $fn = 10);
	}
	
	difference()
	{
		part2CableHolderPlus();
		part2CableHolderMinus();
	}

	
	// rotation sensor axis
	
	translate([-com23JointH/2, 0, -h])
	rotate([0, 90, 0])	
		dCylinder(h = 5, d = 4, x = 1, $fn = 20);
}

module part2CableHolderPlus() {
	intersection()
	{
		bone2Minus();
		
		translate([0, 0, -h])
		{
			translate([0, com23JointD/2, 0])
			rotate([part2CableAngle, 0, 0])
			translate([0, 0, 33])
				cube([20, 8, 10], center = true);
			
			translate([0, -com23JointD/2, 0])
			rotate([-part2CableAngle, 0, 0])
			translate([0, 0, 33])
				cube([20, 8, 10], center = true);
		}
	}	
}

module part2CableHolderMinus() {
	translate([0, 0, -h])
	{
		rotate([part2CableAngle, 0, 0])
		translate([-com23CableOffset, com23JointD/2 - 0.6, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 30]) cylinder(h = 18, d = cd1, $fn = 15);
		}
		
		rotate([-part2CableAngle, 0, 0])
		translate([-com23CableOffset, -com23JointD/2 + 0.6, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 30]) cylinder(h = 18, d = cd1, $fn = 15);
		}
	}
}