include <thigh-print.scad>

rotate([-90, 0, 0]) thighPrint3();

module thighPrint3()
{
	$fn = 70;

	difference() {
		union()
		{
			intersection()
			{
				difference()
				{
					thigh();
					cutA();
				}
				
				cutC();
			}
			
			intersection()
			{
				thighBase();
				boltsBplus(bolts1to3);
			}
		}
		boltsBminus(bolts1to3);
	}
}