
module boltPlus(shaft)
{
    cylinder(h = shaft, d = 10);
}

module boltMinus(bolt, shaft)
{
	sd = 3.2;
	sw = 6.5;
	sh = 2.5;
	
    translate([0, 0, -0.01]) {
		cylinder(h = bolt, d = sd, $fn = 15);

	translate([0, 0, bolt-0.01]) {
		cylinder(h = sh, d1 = sd, d2 = sw, $fn = 15);

		translate([0, 0, sh-0.01])
			cylinder(h = shaft - bolt, d = 7, $fn = 15);
		}
	}
}

module nutPlus()
{
    translate([0, 0, -4.5])
		cylinder(h = 4.5, d = 15);
}

module nutMinus()
{
    rotate([180, 0, 0])
    {
        translate([0, 0, -1])
            cylinder(h = 7, d = 3.5, $fn = 10);

        translate([0, 0, 4.5])
            cylinder(h = 35, d = 7, $fn = 6);    
    }
}