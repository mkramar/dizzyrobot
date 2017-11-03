include <../sizes.scad>

module footAssembly(){
	#coords();
	foot();
}

module foot(mode){
	difference() {
		union() {
			difference() {
				footBase("outer");
				footBase("inner");
			}
			
			intersection() {
				rotate([0, 90, 0])
				translate([0, 0, 0.01])
					motor6caseRotor("inner");
				
				rotate([0, 90, 0])
					motor6RotorHolderPlus();
			}
		}
		
		rotate([0, 90, 0])
			motor6MinusStator();
		
		rotate([0, 90, 0])
			motor6RotorHolderMinus();
			
		rotate([0, 90, 0])
			motor6();
	}
}

module footBase(mode){
	d = 16 + plus2th(mode);
	d2 = 26 + plus2th(mode);
	centre = [10, 0, 0];
	
	rotate([0, 90, 0])
	translate([0, 0, 0.01])
		motor6caseRotor(mode);
	
	translate([0, 0, -30]){
		hull(){
			translate([-20, 80, -10]) sphere(d = d);
			translate([20, 80, -10]) sphere(d = d);
			
			translate(centre) sphere(d = d2);
		}
		
		hull(){
			translate(centre) sphere(d = d2);
			
			translate([0, -60, -10]) {
				translate([-10, 0, 0]) sphere(d = d);
				translate([20, 0, 0]) sphere(d = d);
			}
		}		
	}
}