include <foot-print.scad>

$fn = 100;

rotate([-90, 0, 0])
difference()
{
	union()
	{
		intersection()
		{
			foot();
			cutA();
		}
		
		intersection() 
		{
			footBase();		
			boltsAplus();
		}
	}
	
	boltsAminus();
}
