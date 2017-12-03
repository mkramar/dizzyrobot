include <part.scad>
include <../../lib/moldFramework.scad>

rotate([0, 180, 0])
cutA(boltPositions){
	shell("outer");
	shell("inner");
	structPlus();
	structMinus();
	split();
}


translate([100, 0, 0])
cutB(boltPositions){
	shell("outer");
	shell("inner");
	structPlus();
	structMinus();
	split();
}



module split(){
	translate([-50, -50, 0])
		cube([100, 200, 50]);
}