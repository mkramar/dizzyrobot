include <shin-print.scad>

//rotate([90, 0, 0]) shinPrint4();

module shinPrint4()
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
					cutB();
				}
				
				cutD();
			}
			
			intersection()
			{
				part2Base();
				boltsBplus(bolts2to4);
			}
		}
		
		boltsBminus(bolts2to4);
	}
}