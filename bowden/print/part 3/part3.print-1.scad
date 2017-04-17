use <part3.print.scad>

rotate([0, 90, 0])
difference()
{
	union()
	{
		intersection() 
		{
			part3();
			cutA();
		}
		boltsAplus();
	}
	
	boltsAminus();
}
