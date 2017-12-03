include <part.scad>
include <../../lib/moldFramework.scad>

difference() {
	assembly1(boltPositions){
		shell("outer");
		shell("inner");
	}

	cube([100, 200, 100]);
}

translate([100, 0, 0])
difference() {
	assembly2(boltPositions){
		shell("outer");
		shell("inner");
		
		structPlus();
		structMinus();		
	}

	cube([100, 200, 100]);
}

translate([200, 0, 0])
difference() {
	assembly(boltPositions){
		shell("outer");
		shell("inner");
		structPlus();
		structMinus();
	}

	cube([100, 200, 100]);
}
