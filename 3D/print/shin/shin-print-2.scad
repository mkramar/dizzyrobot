include <shin-print.scad>
include <../../lib/cut.scad>

$fn = 50;

cutNuts(boltPositions){
	rotate([0, 90, 0]) shin();
	rotate([0, 90, 0]) cut();
	rotate([0, 90, 0]) shinBase("outer");
}

