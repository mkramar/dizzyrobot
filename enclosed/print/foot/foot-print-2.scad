include <foot-print.scad>

$fn = 70;

rotate([90, 0, 0])
difference() {
	union()
	{
		difference()
		{
			foot("render");
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