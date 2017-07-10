include <thigh-print.scad>

rotate([-90, 0, 0]) thighPrint2();

module thighPrint2()
{
	//$fn = 70;

	difference()
	{
		union()
		{
			intersection()
			{
				#thigh();
				cutB();
			}
			
			intersection() 
			{
				thighBase("outer");
				
				union()
				{
					boltsAplus(bolts2to4);
					boltsAplus(bolts2to5);
				}
			}
		}
		
		boltsAminus(bolts2to4);
		boltsAminus(bolts2to5);
	}
}