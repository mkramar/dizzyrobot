include <../sizes.scad>
include <motor.scad>

module bodyAssembly(){
	color("lightGray") {
		body();
		//bodyMotors();
	}
	
	%translate(headOffset)
		sphere(d = headD);
		
	translate([0, 30, 120])
		cube(battery, center = true);
}

module body(){
	//cylinder(h = 50, d = rod25o);
	difference(){
		bodyBase("outer");
		bodyBase("inner");
	}
}

module bodyBase(mode) {	
	bodySimmetry(){
		hull()
		translate([shoulderWidth/2, 0, 0])
		translate([0, shoulderY, shoulderZ])
		rotate([0, 90, 0])
			motor6case(mode);
	}

	hull(){
		translate([0, shoulderY, shoulderZ])
			spineEnd(mode);
	
		translate([0, 30, 60])
			spineEnd(mode);
	}

	hull(){
		translate([0, 40, 60])
			sphere(30);
	
		bodySimmetry()
		translate(bodyMotorOffset)
		rotate([-90, 0, 0])
			motor6case(mode);
	}
}

module spineEnd(mode){
	h = batteryY + 10 + plus2th(mode);
	d1 = batteryX + 30 + plus2th(mode);
	rd = (mode == "outer" ? 20 : 15);

	rotate([90, 0, 0])
		shayba2(h, d1, 10, rd);
}

module bodyMotors(){
	translate(bodyMotorOffset)
	rotate([-90, 0, 0])
		motor6();
}

module bodySimmetry(){
	intersection() {
		children();
		
		translate([0, -500, -500])
			cube([1000, 1000, 1000]);
	}
	
	intersection() {
		mirror([1, 0, 0])
			children();
		
		translate([-1000, -500, -500])
			cube([1000, 1000, 1000]);
	}
}

module bodyMirror(){
	children();
	mirror(1, 0, 0) children();
}