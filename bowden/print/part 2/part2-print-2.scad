use <part2-print.scad>

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			part2();
			cutA();
		}
		boltsBplus();
	}
	boltsBminus();
}