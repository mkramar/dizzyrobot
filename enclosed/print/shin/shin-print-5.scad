include <shin-print.scad>

//rotate([90, 0, 0]) shinPrint5();

module shinPrint5()
{
	//$fn = 70;

	difference() {
		union()
		{
			difference()
			{
				part2();
				cutA();
				cutB();
				cutC();
				cutD();
			}
			
			intersection()
			{
				part2Base();
				
				union()
				{
					boltsBplus(bolts1to5);
					boltsBplus(bolts2to5);
				}
			}
		}
		boltsBminus(bolts1to5);
		boltsBminus(bolts2to5);
	}
}