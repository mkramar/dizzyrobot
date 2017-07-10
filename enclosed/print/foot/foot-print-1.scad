include <foot-print.scad>

$fn = 70;

rotate([-90, 0, 0])
difference()
{
	union()
	{
		intersection()
		{
			foot("render");
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
