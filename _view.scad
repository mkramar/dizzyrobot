include <main.scad>

a1 = 10;
a2 = 60;
a3 = 30;

//part0(); 
part3();

//half();
//mirror([1, 0, 0]) translate([bodyDistance, 0, 0]) half();

//part2();

//color("green")
//translate(part3Off)
//part3();


module half()
{
	color("green")
	rotate(part1Rot)
		body();

	color("pink")
	rotate(part1Rot)
		part0();
		
	color("orange")
	rotate(part1Rot)
	translate(part1Off)
	rotate([0, -a1, 0])
		part1();

	color("green")
	rotate(part1Rot)
	translate(part1Off)
	rotate([0, -a1, 0])
	translate([0, 0, -h])
	rotate([-a2, 0, 0])
	    part2();
		
	color("red")
	rotate(part1Rot)
	translate(part1Off)
	rotate([0, -a1, 0])
	translate([0, 0, -h])
	rotate([-a2, 0, 0])
	translate([0, 0, -h])
	rotate([a3, 0, 0])
	    part3();		
}