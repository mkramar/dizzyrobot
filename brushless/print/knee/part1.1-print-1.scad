include <../../parts/part1.1.scad>
use <part1-print.scad>

rotate([90, -90, 0])
difference()
{
	union()
	{
		part1A();
		//#part1Motors();
		
		intersection() 
		{
			part1Base();		
			boltsAplus();
		}
	}
	
	boltsAminus();
}
