include <../sizes.scad>

tubeUpOffset = motor8D/2 + 10;
tubeDownOffset = motor8D/2 + 10;
thighTubeOffset = [thighMotorOffsetX + 10, 0, -thighLength + tubeDownOffset];

module thighAssembly(){
	#coords();
	
	color("tan") {
		thigh();
		thighMotor();
	}
	
	color("white") thighMetal();
}

module thigh(){
	difference() {
		union() {
			hull() {
				translate(thighTubeOffset)
					cylinder(d = rod25o + th*2, h = 30);
					
				translate(thighMotorOffset)
					sphere(d = 25);
			}

			#
			translate(thighMotorOffset)
			rotate([0, -90, 0])
				motor8case();
		}
		
		translate(thighMotorOffset)
		rotate([0, -90, 0])
			motor8MinusRotor();
	}
}

module thighMetal() {
	translate(thighTubeOffset)
		cylinder(d = rod25o, h = thighLength - (tubeUpOffset + tubeDownOffset));
}

module thighMotor(){
	translate(thighMotorOffset)
	rotate([0, -90, 0])
		motor8();
}