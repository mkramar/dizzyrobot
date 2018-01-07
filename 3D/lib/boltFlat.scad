
// translate([0, 0, 0.5]) {
	// %boltPlus(20);
	// boltMinus(4, 30);
// }

// %nutPlus(20);
// nutMinus(4, 30);

module boltPlus(shaft)
{
    cylinder(h = shaft, d = 12);
	
	//mirror([0, 0, 1])
	//	cylinder(d1 = 12, d2 = 0, h = 2);
}

module boltMinus(bolt, shaft)
{
	sd = 3.2;
	sw = 6.5;
	sh = 2.5;
	
    translate([0, 0, -0.01 - 2]) {		
		cylinder(h = bolt, d = sd, $fn = 15);

		translate([0, 0, bolt]) {
			cylinder(h = sh, d1 = sd, d2 = sw, $fn = 15);

			translate([0, 0, sh-0.01])
				cylinder(h = shaft - bolt, d = 7, $fn = 15);
		}
	}
}

module nutPlus(shaft)
{
	mirror([0, 0, 1])
	//difference() {
		cylinder(h = shaft, d = 12);
	//	cylinder(d1 = 12, d2 = 0, h = 2);
	//}
}

module nutMinus(bolt, shaft)
{
	sd = 3.2;

    mirror([0, 0, 1]) {
        translate([0, 0, -1])
            cylinder(h = 7, d = sd, $fn = 15);

        translate([0, 0, 4.5])
            cylinder(h = 35, d = 7, $fn = 6);    
    }
}