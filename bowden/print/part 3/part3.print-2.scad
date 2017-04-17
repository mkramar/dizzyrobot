use <part3.print.scad>

rotate([0, -90, 0])
difference() {
	union()
	{
		difference()
		{
			part3();
			cutA();
		}
		boltsBplus();
	}
	boltsBminus();
}