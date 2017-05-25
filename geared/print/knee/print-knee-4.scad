include <../../parts/knee.scad>
use <print-knee.scad>

rotate([180, 0, 0])
difference()
{
	union()
	{
		intersection()
		{
			knee($fn = 100);
			
			translate([-100, -100, motor5H/2])
				cube([200, 200, 50]);
		}

		intersection() 
		{
			case(outer = true);		
			boltsBplus();
		}
	}
	
	boltsBminus();	
}