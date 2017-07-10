include <thigh-print.scad>

rotate([90, 0, 0]) thighPrint1();

module thighPrint1()
{
	$fn = 70;

	difference()
	{
		union()
		{
			intersection()
			{
				thigh();
				cutA();
			}
			
			intersection() 
			{
				thighBase();
				
				union()
				{
					boltsAplus(bolts1to5);
					boltsAplus(bolts1to3);
				}
			}
		}
		
		boltsAminus(bolts1to5);
		boltsAminus(bolts1to3);
	}
}