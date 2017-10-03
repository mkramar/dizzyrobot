magnetoSensor();
#magnetoSensorSpacing();

module magnetoSensor(){
	boardX = 13.2;
	boardY = 9.1;
	boardZ = 1;

	icX = 3.5;
	icY = 4.2;
	icZ = 1.75;
	
	translate([-boardX/2, -boardY/2, 0]) {
		cube([boardX, boardY, boardZ]);
		
		translate([0, 0, boardZ]){
			translate([boardX/2 - icX/2, boardY/2 - icY/2, 0])
				cube([icX, icY, icZ]);

			translate([boardX - 2, boardY/2 - 1, 0])
				cube([1.2, 2, 1.2]);
		}
	}
}

module magnetoSensorSpacing(){
	boardX = 13.2;
	boardY = 9.1;
	boardZ = 1;

	icX = 3.5;
	icY = 4.2;
	icZ = 1.75;
	
	cableX = 9;
	cableY = 15;
	cableZ = 1.5;
	
	d = 0.6;
	
	translate([-(boardX + d)/2, -(boardY + d)/2, 0]) {
		cube([boardX + d, boardY + d, boardZ + icZ + d]);
		
		translate([(boardX + d)/2 - cableX/2, 0, -cableZ])
			cube([cableX, boardY + cableY, 15]);
	}
}