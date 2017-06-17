include <body-print.scad>

$fn = 100;

difference()
{
	union()
	{
		intersection()
		{
			popa();
			
			difference()
			{
				cutA();
				cutB();
			}
		}
		
		intersection() 
		{
			popaBase(true);
			nutsBplus();
		}
	}
	
	nutsBminus();
}
