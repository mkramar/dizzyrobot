include <../../parts/knee.scad>
use <knee-print.scad>

$fn = 100;

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			knee();
			cutA();
		}
		
		intersection()
		{
			//kneeA(true);
			knee();
			boltsBplus();

		}
	}
	boltsBminus();
}