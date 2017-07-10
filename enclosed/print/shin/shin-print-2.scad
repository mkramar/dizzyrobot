include <shin-print.scad>

//translate([0, 150, 0]) rotate([-90, 0, 0]) shinPrint2();

module shinPrint2()
{
	//$fn = 70;

	difference()
	{
		union()
		{
			intersection()
			{
				part2();
				cutB();
			}
			
			intersection() 
			{
				part2Base("outer");
				
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