include <main.scad>

translate([0, 60, 0])
	cut1();
	
translate([15, 60, 15.5])
	cut2();

translate([-85, 60, 15.5])
	cut3();

translate([-25, 25, 0])
	cut4();	
	
translate([25, 25, 0])
	cut4();		
	
module cut1()
{
	rotate([0, 90, 0])	
	intersection()
	{
		part0();
		

		translate([-50, -100, -100])
			cube([50, 200, 200]);
	}
}

module cut2()
{
	rotate([-90, 0, 0])
	difference()
	{
		intersection()
		{
			part0();
			
			translate([11, 0, -100])
				cube([200, 50, 200]);
		}
		
		translate([10, -5, 5])
		rotate([0, 90, 0])
			pyramid(w = 10, l = 10, h = 4);
	}
}

module cut3()
{
	rotate([90, 0, 0])
	difference()
	{
		intersection()
		{
			part0();
			
			translate([11, -50, -100])
				cube([200, 50, 200]);
		}
		
		translate([10, -5, 5])
		rotate([0, 90, 0])
			pyramid(w = 10, l = 10, h = 4);
	}
}

module cut4()
{
	rotate([0, -90, 0])
	difference()
	{
		intersection()
		{
			part0();
			
			union()
			{
				translate([0, -50, -50])
					cube([11, 50, 100]);
					
				intersection()
				{				
					translate([10, -5, 5])
					rotate([0, 90, 0])
						pyramid(w = 10, l = 10, h = 4);
						
					translate([10, -50, -50])
						cube([11, 50, 100]);						
				}
			}
		}
	}
}