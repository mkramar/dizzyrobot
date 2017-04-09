use <part1-print.scad>

rotate([0, -90, 0])
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
	part1CableHolderMinus();
}