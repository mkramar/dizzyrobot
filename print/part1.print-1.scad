include <main.scad>

off = 2;

translate([0, 0, 2])
rotate([90, 0, 90])
	print12();

translate([0, 65, 2])
rotate([-90, 0, -90])
    print11();

translate([30, 35, 15])
rotate([0, 90, 0])
    print22();    

translate([30, 100, 15])
rotate([0, -90, 180])
    print21();
    
module print11()
{
    //
	difference()
	{
		intersection()
		{
			union()
			{
				part1();
				//part11bolts();
			}
			cutCube11();
		}
		//part11boltsMinus();
	}
}
module print12()
{
	difference()
	{
		intersection()
		{
			union()
			{
				part1();
				//part12bolts();
			}
			cutCube12();
		}
		//part12boltsMinus();
	}
}
module print21()
{
    intersection()
    {
        part1();    
        cutCube21();
    }
}
module print22()
{
    intersection()
    {
        part1();    
        cutCube22();
    }
}
module cutCube11()
{
	difference()
	{
		union()
		{
			translate([0, -27, 0])
				cube([50, 50, h], center = true);
				
			translate([-20, -22, -h/2 - 20])
				cube([20, 20, 20]);
				
			saw1(part = "all", small = true);

			//for (i = [0:45:360])
			//{
			//	rotate([-90, i, ])
			//	translate([-25, -4+0.25, -3])
			//		tapered_cuboid(w =10, l = 7.5, h = 4.1, taper = 2); 			
			//}			
		}

		translate([0, -18, -h/2 - 20])
			cube([20, 20, 40]);		
	}
	
	intersection()
	{
		saw2(part = "upper", small = true);
		
		translate([0, -27, -30])
			cube([50, 50, h], center = true);		
	}
}
/*
module part11bolts()
{
	translate([-6, -2, -40])
	rotate([90, 0, 0])
		bolta();
		
	translate([-5.8, -2, -73])
	rotate([90, 0, 0])
		bolta();		
		
	translate([6, -2, -40])
	rotate([90, 0, 0])
		bolta();		
}
module part11boltsMinus() {
	translate([-6, -2, -40])
	rotate([90, 0, 0])
		boltaMinus();
		
	translate([-5.8, -2, -73])
	rotate([90, 0, 0])
		boltaMinus();			
		
	translate([6, -2, -40])
	rotate([90, 0, 0])
		boltaMinus();			
}
*/
module cutCube12(){
	difference()
	{
		union()
		{
			translate([0, 25 - off, 0])
				cube([50, 50, h], center = true);
				
			translate([-20, -2, -h/2 - 20])
				cube([20, 20, 20]);
		}
		
		translate([00, -3, -h/2 - 20])
			cube([20, 20, 40]);		
		
		saw1(part = "all");
		
		
		//for (i = [0:45:360])
		//{
		//	rotate([-90, i, 0])
		//	translate([-25, -4, -3])
		//		tapered_cuboid(w =10, l = 8, h = 4.5, taper = 2); 			
		//}		
	}			
	
	intersection()
	{
		saw2(part = "upper");	

		translate([00, -3, -h/2 - 20])
			cube([20, 20, 40]);		
	}			
}
/*
module part12bolts(){
	translate([-6, -2, -40])
	rotate([90, 0, 0])
		boltb();
		
	translate([-5.8, -2, -73])
	rotate([90, 0, 0])
		boltb();		
		
	translate([6, -2, -40])
	rotate([90, 0, 0])
		boltb();		
}
module part12boltsMinus() {
	translate([-6, -2, -40])
	rotate([90, 0, 0])
		boltbMinus();
		
	translate([-5.8, -2, -73])
	rotate([90, 0, 0])
		boltbMinus();			
		
	translate([6, -2, -40])
	rotate([90, 0, 0])
		boltbMinus();			
}
*/
module cutCube21()
{
	difference()
	{
		translate([-25, 0, -h+20])
			cube([50, 60, h], center = true);
			
		translate([-19, -22, -h/2 - 20])
			cube([20, 40, 41]);
	}
	
	difference()
	{
		saw2(part = "lower", small=true);
		
		translate([-10, -22, -h/2 - 20])
			cube([20, 20, 40]);		
	}

	translate([0, 0, -h])
	for (i = [0:45:360])
	{
		rotate([i, 0, 0])
		translate([-1, -4 + 0.25, -21])
		rotate([0, 90, 0])
			tapered_cuboid(w =10, l = 7.5, h = 4.1, taper = 2); 		
	}		
}
module cutCube22()
{
	difference()
	{
		translate([25, 0, -h + 20])
			cube([50, 60, h], center = true);

		saw2(part = "all");
		
		translate([0, 0, -h])
		for (i = [0:45:360])
		{
			rotate([i, 0, 0])
			translate([-1, -4, -21])
			rotate([0, 90, 0])
				tapered_cuboid(w =10, l = 8, h = 4.5, taper = 2); 			
		}		
	}
}

module saw1(part, small){
	for (i = [i2 + 5 : 17: h/2 + 10])
	{
		if (part == "upper" && i < h/2  ||
		    part == "lower" && i > h/2 - 20 ||
			part == "all")
		{
			translate([0, 0, -i])
			rotate([-90, 0, 0])
			if (small == true)
			{
				translate([-30, 0.25, -3])
					tapered_cuboid(w =60, l = 7.5, h = 4.3, taper = 2); 
			}
			else
			{
				translate([-30, 0, -3])
					tapered_cuboid(w =60, l = 8, h = 4.5, taper = 2); 			
			}
		}		
	}
}

module saw2(part, small){
	for (i = [i2 + 50 : 17: h/2 + 40])
	{
		if (part == "upper" && i < h/2 + 20  ||
		    part == "lower" && i > h/2 + 20 ||
			part == "all")
		{
			translate([0, 0, -i])
			rotate([90, 0, 90])
			if (small == true)
			{
				translate([-30, 0.25, -1])
					tapered_cuboid(w =60, l = 7.5, h = 4.3, taper = 2); 
			}
			else
			{
				translate([-30, 0, -1])
					tapered_cuboid(w =60, l = 8, h = 4.5, taper = 2); 			
			}
		}		
	}
}