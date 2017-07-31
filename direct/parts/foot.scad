include <../sizes.scad>

module footAssembly(){
	#coords();
	foot();
}

module foot(){
	translate([-20, 0, -30]){
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