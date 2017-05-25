include <../../parts/knee.scad>
use <../../../lib/bolt.scad>
use <print-knee.scad>

difference()
{
	d = 25 / sqrt(2) / 2;
	
	union()
	{
		intersection()
		{
			knee($fn = 100);
			
			translate([-100, -100, motor5H/2 - 50])
				cube([200, 200, 50]);
		}

		intersection() 
		{
			case(outer = true);		
			
			union()
			{
				boltsAplus();
				boltsAplusMotor();
			}
		}
	}
	
	boltsAminus();	
	boltsAminusMotor();
}