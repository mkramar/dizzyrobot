include <main.scad>

a0 = 10;
a1 = 0;
a2 = 20;
a3 = 60;

//part0(); 
//part2();
//part3();

half();
//mirror([1, 0, 0]) translate([bodyDistance, 0, 0]) half();

// translate([0, 100, -20])
// rotate([90, 0, 0])
//	 motorBlockA();
	
// translate([0, 200, -20])
// rotate([90, 0, 0])
//	 motorBlockB();

// translate([-48, 40, -60])
//	 cube([47,224,24.3]);

// upper motors
	
	// translate([-bodyDistance/2 + 26, -10, 60])
	// rotate([-90, 0, 0])
		// motor25();
		
	// translate([-bodyDistance/2, -10, 60])
	// rotate([-90, 0, 0])
		// motor25();
		
	// translate([-bodyDistance/2 - 26, -10, 60])
	// rotate([-90, 0, 0])
		// motor25();		
//

//part2();

//color("green")
//translate(part3Off)
//part3();


module half()
{
	//color("green")
	//	body();

	//color("pink")
	//rotate(part1Rot)
	//rotate([a0, 0, 0])
	//	part0();

	//color("orange")
	//rotate(part1Rot)
	//rotate([a0, 0, 0])
	//translate(part1Off)
	//rotate([0, -a1, 0])
	//	part1();

	color("green")
	rotate(part1Rot)
	rotate([a0, 0, 0])
	translate(part1Off)
	rotate([0, -a1, 0])
	translate([0, 0, -h])
	rotate([-a2, 0, 0])
		part2();
	
	//color("red")
	//rotate(part1Rot)
	//rotate([a0, 0, 0])
	//translate(part1Off)
	//rotate([0, -a1, 0])
	//translate([0, 0, -h])
	//rotate([-a2, 0, 0])
	//translate([0, 0, -h])
	//rotate([a3, 0, 0])
	//	part3();		
}