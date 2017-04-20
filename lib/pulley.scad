additionalToothWidth = 0.2; //mm
additionalToothHeight = 0; //mm

//pulley (teeth = 100, height = 10);

module pulley(teeth, height, center = false) {
	toothDepth = 0.508;
	toothWidth =  1.321;
	toothPitch = 2.032;
	pitchLineOffset = 0.254;
	pulleyD = 2*((teeth*toothPitch)/(3.14159265*2)-pitchLineOffset);
	toothDistanceFromCentre = sqrt( pow(pulleyD/2,2) - pow((toothWidth+additionalToothWidth)/2,2));
	toothWidthScale = (toothWidth + additionalToothWidth ) / toothWidth;
	toothDepthScale = ((toothDepth + additionalToothHeight ) / toothDepth) ;
	
	difference()
	{
		union()
		{
			cylinder(d=pulleyD,h=height, $fn=teeth*4, center = center);
			
			translate([0, 0, height/2])
				cylinder(d=pulleyD + 2,h=2, $fn=teeth*4);
				
			translate([0, 0, -height/2 - 2])
				cylinder(d=pulleyD + 2,h=2, $fn=teeth*4);				
		}
			
		for(i=[1:teeth])
		{			
			rotate([0,0,i*(360/teeth)])
			translate([0,-toothDistanceFromCentre,-height/2]) 
			scale ([ toothWidthScale , toothDepthScale , 1 ]) 
			tooth(height);
		}
	}
}
			
module tooth(height) {
	linear_extrude(height=height) 
		polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
}