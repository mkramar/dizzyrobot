use <part1-print.scad>

rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection() 
		{
			part1();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
}
