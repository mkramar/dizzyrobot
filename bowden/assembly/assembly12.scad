include <../main.scad>

angle = 30;

color("orange")
	part1();

translate([0, 0, -h])
rotate([-angle, 0, 0])
	part2();