include <foot-print.scad>

$fn = 50;

mirror([0, 0, 1]) {
	cutNuts(boltPositions){
		rotate([0, 90, 0]) foot();
		rotate([0, 90, 0]) cut();
		rotate([0, 90, 0]) footBase("outer");
	}
}