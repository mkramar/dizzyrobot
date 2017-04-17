use <../lib/shapes.scad>
include <common01.scad>
include <common12.scad>
include <../_sizes.scad>
include <../_shared.scad>

part1BoltHolder1 = [0, -10, com12JointD / 2 - h + 7];
part1BoltHolder2 = [0, 21, -h-23];

part1JointOffset = [0, 10, -2];
part1CanleAngle1 = 8;
part1CanleAngle2 = 24;

module part1()
{    
    difference()
	{
        union()
        {
			rotate([0, 0, 90])
            difference()
            {
                com01JointInner();
					com01JointInnerMinus1();
            }
            
            bone1Plus();

            translate([0, 0, -h])
			{
                //com12JointOuter();
				
				hull()
				{
					com12JointOuter();
						
					translate(part1JointOffset)
					com12JointOuter();
				}
			}
        }
        
        //translate([0, 0, -h/2]) cube([50, 50, h + 50]);
        //translate([0, -50, -h]) cube ([50, 100, 50]);
		translate([0, -50, 0]) cube ([50, 100, 50]);
		//translate([0, -50, -h-50]) cube ([50, 100, 150]);
	
		// cable entry from part0
		
		union()
		{
			// offset
			
			translate([0, 0, -25])
			rotate([0, -90, 0])
				cylinder(h = 50, d = cd2, $fn = 10);

			// centred
			
			//translate([0, -com01CableOffset, -i1/2 + 3])
			rotate([0, 90, 0])
				cylinder(h = 40, d1 = 2, d2 = cd2, $fn = 10);
		}
		
		// rotation sensor space
		
		translate([0, com01JointH / 2, 0])
		rotate([90, 0, 0])
			rotationSensorSpacing();
		
		rotate([0, 0, 90])
		{
			com01JointInnerMinus2();
			com01JointInnerMinus3();
			//com01JointInnerMinus4a();
			com01JointInnerMinus4b();
		}
		
        bone1Minus();

		// opening into the bone
		
		hull()
		{
			translate([0, 0, -50])
			rotate([0, 90, 0])
				cylinder(h = 40, d = 10, center = true);
				
			translate([0, 6, -h+40])
			rotate([0, 90, 0])
				cylinder(h = 40, d = 15, center = true);
		}
			
        translate([0, 0, -h])
        {
			hull()
			{
				com12JointInner(inflate = 2);
					
				translate(part1JointOffset)
				com12JointInner(inflate = 2);
			}
		
            //com12JointInner(inflate = 2);
            com12JointInnerMinus3();
			//com12JointInnerMinus4a();
			com12JointInnerMinus4b();
        
			// opening for part 2 bone
			
            hull()
            {
                rotate([-part1angle1, 0, 0])
                    bone2Plus(inflate = 2);
                
                rotate([(-part1angle1-part1angle2)/2, 0, 0])
                    bone2Plus(inflate = 2);
            }
			
            hull()
            {
                rotate([(-part1angle1-part1angle2)/2, 0, 0])
                    bone2Plus(inflate = 2);
                
                rotate([-part1angle2, 0, 0])
                    bone2Plus(inflate = 2);
            }			
        }
		
		// communication opening into part 0
		
		translate([0, 6, 0])
		hull()
		{
			rotate([0, -45, 0])
				cylinder(d = 5, h = 50);

			rotate([0, -120, 0])
				cylinder(d = 5, h = 50);
		}
		
		translate([0, -6, 0])
		hull()
		{
			rotate([0, -45, 0])
				cylinder(d = 5, h = 50);

			rotate([0, -120, 0])
				cylinder(d = 5, h = 50);
		}		
    }
	
	// cable holders to part 2
	
	difference()
	{
		part1CableHolderPlus();
		part1CableHolderMinus();
	}
	
	// rotation sensor axis
	
	translate([0, 0, -h])
	translate([com12JointH/2, 0, 0])
	rotate([0, 90, 0])
		dCylinder(h = 5, d = 4, x = 1, $fn = 20);	
	
	// bolt holder
	
	translate(part1BoltHolder2)
	rotate([0, 90, 0])
		cylinder(h = 26, d = 10, center = true);		
}

module part1CableHolderPlus() {
	intersection()
	{
		bone1Minus();
		
		union()
		{
			translate([0, 0, -h])
			{
				rotate([part1CanleAngle1, 0, 0])
				translate([0, com12JointD/2, 65])
					cube([30, 8, 10], center = true);
				
				rotate([-part1CanleAngle2, 0, 0])
				translate([0, -com12JointD/2, 36])
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
		rotate([part1CanleAngle1, 0, 0])
		translate([-com12CableOffset, com12JointD/2, 0])
		{
			cylinder(h =70, d = cd2, $fn = 8);
			translate([0, 0, 65]) cylinder(h = 10, d = cd1, $fn = 15);
		}
		
		rotate([-part1CanleAngle2, 0, 0])
		translate([-com12CableOffset, -com12JointD/2, 0])
		{
			cylinder(h = 40, d = cd2, $fn = 8);
			translate([0, 0, 35]) cylinder(h = 10, d = cd1, $fn = 15);
		}
	}
}