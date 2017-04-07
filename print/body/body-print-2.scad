include <body-print.scad>


difference()
{
	union()
	{
		intersection()
		{
			translate([-100, -140, -20])
				cube ([200, 200, 100]);
			
			rotate([0, 90, 0])
			rotate(part1RotMinus) 
				body2();
		}
			
		boltsBplus();
		
	}
	
	boltsBminus();
	
}


			rotate([0, 90, 0])
			rotate(part1RotMinus) 
			{
				difference()
				{	
					bolts2Bplus();
					bolts2Bminus();
				}
			}