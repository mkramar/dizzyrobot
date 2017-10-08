include <../sizes.scad>
include <_common.scad>

module armAssembly(){
	#coords();
	
	color("pink") arm("preview");
}

module arm(mode) {
	difference() {
		armBase("outer");
		armBase("inner");
	}
}

module armBase(mode){
	rotate([90, 0, 0])
		motor6caseStator(mode);
		
	translate([0, 0, -armLength])
	rotate([0, 90, 0])
		motor6caseStator(mode);		
}