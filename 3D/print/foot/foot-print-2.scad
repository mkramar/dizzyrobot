include <foot-print.scad>

//$fn = 50;

rotate([0, 90, 0]) {
	difference() {
		union() {
			difference(){
				foot();
				cut("minus");
			}
			
			intersection(){
				footBase("outer");
				nutsPlus();
			}
		}
		
		nutsMinus();
	}
}