include <part1-print.scad>

$fn = 100;

rotate([90, 0, 0])
difference() {
	union()
	{
		difference()
		{
			part1();
			cutA();

		}
		
		intersection()
		{
			partBase();
			boltsBplus();
		}
	}
	boltsBminus();
}