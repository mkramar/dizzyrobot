include <../../parts/knee.scad>
use <knee-print.scad>

rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection()
		{
			knee();
			cutA();
		}
		
		intersection() 
		{
			knee();		
			boltsAplus();
		}
	}
	
	boltsAminus();
}
