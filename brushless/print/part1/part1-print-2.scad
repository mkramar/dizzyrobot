include <../../parts/part1.scad>
use <part1-print.scad>

rotate([0, 90, 0])
rotate([-90, 0, 0])
difference() {
	union()
	{
		part1B();
		
		intersection()
		{
			part1BBase();
			boltsBplus();

		}
	}
	boltsBminus();
}