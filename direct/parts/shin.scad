include <../sizes.scad>

shinTubeUpZ = motor8D/2 + 10;
shinTubeDownZ = motor6D/2 + 10;
shinTubeLength = shinLength - shinTubeUpZ - shinTubeDownZ;

shinTubeUpOffset = [shinMotorOffsetX - 20, 0, -shinLength + shinTubeDownZ + shinTubeLength];
shinTubeDownOffset = [shinMotorOffsetX - 20, 0, -shinLength + shinTubeDownZ];

module shinAssembly(){
	#coords();
	
	color("turquoise"){
		shin();
		shinMotor();
	}
	
	color("white") shinMetal();
}

module shin() {
	hull() {
		translate(shinTubeUpOffset)
			rotate([180, 0, 0])
			cylinder(d = rod25o + th*2, h = 30);
			
		translate([-22, 0, 0])
			sphere(d = 25);
	}
}

module shinMetal(){
	translate(shinTubeDownOffset)
		cylinder(d = rod25o, h = shinLength - (shinTubeUpZ + shinTubeDownZ));	
}

module shinMotor() {
	translate(shinMotorOffset)
	rotate([0, -90, 0])
		motor6();
}