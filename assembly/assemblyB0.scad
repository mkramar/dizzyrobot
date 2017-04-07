include <../main.scad>

angle = 10;

half();
//mirror([1, 0, 0]) translate([bodyDistance, 0, 0]) half();

module half () {
	color("green")
		body();

	rotate(part1Rot)
	rotate([angle, 0, 0])
		part0();
}