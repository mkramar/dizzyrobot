include <body-print.scad>

rotate([180, 0, 0])
difference()
{
	union()
	{
		rotate([0, 90, 0]) body1();
			
		boltsAplus();
	}
	
	boltsAminus();
}
