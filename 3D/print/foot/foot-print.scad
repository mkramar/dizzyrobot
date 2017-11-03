include <../../sizes.scad>
include <../../parts/_common.scad>
include <../../parts/motor6-tyi.scad>
include <../../lib/shapes.scad>
include <../../lib/dent.scad>
include <../../lib/cut.scad>
include <../../lib/boltFlat.scad>
include <../../parts/foot.scad>

cutOffset = motor6Cut + gap/2;
boltPositions = [[-42, 70, -cutOffset], [-27, 30, -cutOffset], [-28.5, -30, -cutOffset], [-42.5, -55, -cutOffset]];
				 
module cut(mode) {
	translate([cutOffset, 0, 0]){
		translate([0, -100, -100])
			cube([100, 200, 200]);
			
		translate([0, 60, -60])
		rotate([90, 0, -90])
			dent(mode);
			
		translate([0, -40, -60])
		rotate([90, 0, -90])
			dent(mode);
			
		translate([0, -105, -44])
		rotate([0, -90, 0])
			dent(mode);

		translate([0, 80, -44])
		rotate([0, -90, 0])
			dent(mode);
	}
}
