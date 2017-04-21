include <../../parts/part1.scad>
use <part1-print.scad>

difference()
{
	union()
	{
		intersection() 
		{
			part1();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
}
