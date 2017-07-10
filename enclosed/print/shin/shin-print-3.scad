include <shin-print.scad>

rotate([90, 0, 0]) shinPrint3();

module shinPrint3()
{
	$fn = 70;

	difference() {
		union()
		{
			intersection()
			{
				difference()
				{
					part2();
					cutA();
				}
				
				cutC();
			}
			
			intersection()
			{
				part2Base();
				boltsBplus(bolts1to3);
			}
		}
		boltsBminus(bolts1to3);
	}
}