include <../../parts/part1.scad>
use <part1-print.scad>


difference() {
	union()
	{
		difference()
		{
			part1();
			cutA();
		}
		boltsBplus();
	}
	boltsBminus();
}