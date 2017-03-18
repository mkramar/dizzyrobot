include <main.scad>

rotate([0, 90, 0])
	body();

translate([80, 95, 0])
rotate([0, 0, 180])
mirror([1, 0, 0])
{
	translate([-80, 0, 0])
	rotate([0, 90, 0])
		body(side = "b");
}
