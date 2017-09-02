additionalToothWidth = 0.2; //mm
additionalToothHeight = 0; //mm

//pulley (teeth = 100, height = 10);

module pulley(teeth, height, type="GT2", center = false, upperBorder = true, lowerBorder = true) {
	toothDepth = type=="MXL" ? 0.508 : 0.764;
	toothWidth =  type=="MXL" ? 1.321 : 1.494;
	toothPitch = type=="MXL" ? 2.032 : 2.00;
	pitchLineOffset = type=="MXL" ? 0.254 : 0.254;
	
	pulleyD = 2*((teeth*toothPitch)/(3.14159265*2)-pitchLineOffset);
	toothDistanceFromCentre = sqrt( pow(pulleyD/2,2) - pow((toothWidth+additionalToothWidth)/2,2));
	toothWidthScale = (toothWidth + additionalToothWidth ) / toothWidth;
	toothDepthScale = ((toothDepth + additionalToothHeight ) / toothDepth) ;
	
	difference()
	{
		union()
		{
			cylinder(d=pulleyD,h=height, $fn=teeth*4, center = center);
			
			if (upperBorder)
				translate([0, 0, height/2])
					cylinder(d=pulleyD + 1,h=1.5, $fn=teeth*4);
				
			if (lowerBorder)
				translate([0, 0, -height/2 - 1.5])
					cylinder(d=pulleyD + 1,h=1.5, $fn=teeth*4);				
		}
			
		for(i=[1:teeth])
		{			
			rotate([0,0,i*(360/teeth)])
			translate([0,-toothDistanceFromCentre,-height/2]) 
			scale ([ toothWidthScale , toothDepthScale , 1 ]) 
				if (type=="MXL")
				{
					toothMXL(height);
				}
				else
				{
					toothGT2(height);
				}
		}
	}
}
			
module toothMXL(height) {
	linear_extrude(height=height) 
		polygon([[-0.660421,-0.5],[-0.660421,0],[-0.621898,0.006033],[-0.587714,0.023037],[-0.560056,0.049424],[-0.541182,0.083609],[-0.417357,0.424392],[-0.398413,0.458752],[-0.370649,0.48514],[-0.336324,0.502074],[-0.297744,0.508035],[0.297744,0.508035],[0.336268,0.502074],[0.370452,0.48514],[0.39811,0.458752],[0.416983,0.424392],[0.540808,0.083609],[0.559752,0.049424],[0.587516,0.023037],[0.621841,0.006033],[0.660421,0],[0.660421,-0.5]]);
}

module toothGT2(height) {
	linear_extrude(height=height) 
		polygon([[0.747183,-0.5],[0.747183,0],[0.647876,0.037218],[0.598311,0.130528],[0.578556,0.238423],[0.547158,0.343077],[0.504649,0.443762],[0.451556,0.53975],[0.358229,0.636924],[0.2484,0.707276],[0.127259,0.750044],[0,0.76447],[-0.127259,0.750044],[-0.2484,0.707276],[-0.358229,0.636924],[-0.451556,0.53975],[-0.504797,0.443762],[-0.547291,0.343077],[-0.578605,0.238423],[-0.598311,0.130528],[-0.648009,0.037218],[-0.747183,0],[-0.747183,-0.5]]);
}