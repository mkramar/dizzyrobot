include <foot-print.scad>

$fn = 100;

rotate([90, 0, 0])
difference() {
	union()
	{
		difference()
		{
			foot();
			cutA();

		}
		
		intersection()
		{
			footBase();
			boltsBplus();
		}
	}
	boltsBminus();
}