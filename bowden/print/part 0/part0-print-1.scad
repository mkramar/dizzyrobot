use <part0-print.scad>

rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection() 
		{
			rotate([0, 0, 90]) part0();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
	rotate([0, 0, 90]) part2PullMinus();
}
