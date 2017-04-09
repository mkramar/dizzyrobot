include <../main.scad>

angle = -10;

color("orange")
rotate(part1Rot)
	part0();

rotate(part1Rot)
translate(part1Off)
rotate([0, -angle, 0])
	part1();