include <../sizes.scad>

module footAssembly(){
	#coords();
	foot();
}

module foot(){
	difference() {
		union() {
			translate([0, 0, 0.01])
			rotate([0, 90, 0])
				motor6caseStator();

			translate([0, 0, -30]){
				hull(){
				
					translate([0, 80, -10]) {
						translate([-20, 0, 0]) sphere(d = 30);
						translate([20, 0, 0]) sphere(d = 30);
					}
					
					sphere(d = 30);
				}
				
				hull(){
				
					translate([0, -60, -10]) {
						translate([-20, 0, 0]) sphere(d = 30);
						translate([20, 0, 0]) sphere(d = 30);
					}
					
					sphere(d = 30);
				}		
			}
		}
		
		rotate([0, 90, 0])
			motor6MinusRotor();
	}
}