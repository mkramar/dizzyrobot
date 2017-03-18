include <main.scad>

translate([0, 0, o1/2 - 1])	
rotate([90, 0,0])
	cut1();

translate([0, 60, o1/2 - 1])	
rotate([-90, 0,0])
	cut2();

translate([-40, 30, 15])
rotate([0, -90, 0])
	cut3();
	
module cut1(){
	difference()
	{
		intersection()
		{
			part0();
			
			translate([-5, -50, -100])
				cube([200, 50, 200]);
		}
		
		// big ball connectors

		translate(part1Off)
		rotate([-90, 0, 0])
			roundCut2Minus(d = 51, angles =[-10, -90, 180]);
		/*
		for (i = [90, 180, 255])
		{
			if (i != 270)
			{
				rotate([0, i, 0])
				translate([-4, 1, -21])
				rotate([90, 90, 0])
					tapered_cuboid(w =10, l = 8, h = 4.5, taper = 2); 			
			}
		}
		*/
		// small ball connectors
		
		translate([-5, 0, 0])
		rotate([0, -90, 0])
			roundCutMinus(d = 30);
	}
}

module cut2(){
	difference()
	{
		intersection()
		{
			part0();
			
			union()
			{
				translate([-5, 0, -100])
					cube([200, 50, 200]);
					
				translate(part1Off)
				rotate([-90, 0, 0])
					roundCut2(d = 51, angles =[-10, -90, 180]);	
			}
		}
		
		// small ball connectors
		
		translate([-5, 0, 0])
		rotate([0, -90, 0])
			roundCutMinus(d = 30);		
	}
}

module cut3(){
	intersection()
	{
		part0();
		
		union()
		{
			translate([-35, -30, -30])
				cube([30, 60, 60]);
				
			translate([-5, 0, 0])
			rotate([0, -90, 0])
				roundCut(d = 30);			
		}
	}
	

}