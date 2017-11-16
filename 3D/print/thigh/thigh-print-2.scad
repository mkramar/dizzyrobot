include <thigh-print.scad>

$fn = 50;

cutNuts(boltPositions){
	rotate([0, -90, 0])thigh();
	rotate([0, -90, 0])cut();
	rotate([0, -90, 0]) thighBase("outer");
}
