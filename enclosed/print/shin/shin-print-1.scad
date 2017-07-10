include <shin-print.scad>

rotate([-90, 0, 0]) shinPrint1();

module shinPrint1()
{
	$fn = 70;

	difference()
	{
		union()
		{
			intersection()
			{
				part2();
				cutA();
			}
			
			intersection() 
			{
				part2Base();
				
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