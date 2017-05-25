use <../../../lib/bolt.scad>
include <../../parts/knee.scad>

module boltsAplus(){
	for (x = bolts)
		translate(x)
			mirror([0, 0, 1])
			cylinder(h = 36, d = 10);
}

module boltsAminus(){
	for (x = bolts)
		translate(x)
			mirror([0, 0, 1])
			boltaMinus(h = 40);
}

module boltsAplusMotor(){
	d = 25 / sqrt(2) / 2;
	
	for (x = [-d, d])
	for (y = [-d, d])
		translate([x, y, 0])
			mirror([0, 0, 1])
				cylinder(h = 36, d = 10);	
}

module boltsAminusMotor() {
	d = 25 / sqrt(2) / 2;
	
	for (x = [-d, d])
	for (y = [-d, d])
		translate([x, y, 0])
			mirror([0, 0, 1])
				boltaMinus(h = 40);
}

// B

module boltsBplus() {
	for (x = bolts)
		translate(x)
			cylinder(h = 40, d = 10);
}

module boltsBminus() {
	for (x = bolts)
		translate(x)
			mirror([0, 0, 1])
				boltbMinus();
}
