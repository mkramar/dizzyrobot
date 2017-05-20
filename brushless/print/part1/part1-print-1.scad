include <../../parts/part1.scad>
use <part1-print.scad>

rotate([90, -90, 0])
difference()
{
	difference()
	{
		union()
		{
			intersection()
			{
				part1();
				cutA();
			}
			
			intersection() 
			{
				part1Base();		
				boltsAplus();
			}
			
			//part1Motors();
		}
		
		boltsAminus();
	}
	
	translate([-100, -100, -h1/2])
		cube([200, 200, 200]);	
}