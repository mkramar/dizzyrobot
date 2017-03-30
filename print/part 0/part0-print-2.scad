use <part0-print.scad>

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			rotate([0, 0, 90]) part0();
			cutA();
		}
		boltsBplus();
	}
	boltsBminus();
}