use <part2-print.scad>

rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection() 
		{
			part2();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
}
