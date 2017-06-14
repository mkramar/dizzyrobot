include <body-print.scad>

$fn = 100;

difference()
{
	union()
	{
		intersection()
		{
			popa();
			cutB();
		}
		
		intersection() 
		{
			popaBase(true);
			nutsAplus();
		}
	}
	
	nutsAminus();
}
