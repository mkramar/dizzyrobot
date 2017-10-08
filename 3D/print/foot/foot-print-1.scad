include <foot-print.scad>

$fn = 50;

rotate([0, 90, 0]) {
	difference() {
		union() {
			intersection(){
				foot();
				cut("plus");
			}
			
			intersection(){
				intersection(){
					footBase("outer");
					cut("plus");
				}
				boltsPlus();
			}
		}
		
		boltsMinus();
	}
}