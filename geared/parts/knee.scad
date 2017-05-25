use <../../lib/shapes.scad>
include <../../lib/gear.scad>
use <../../lib/sensor.scad>
include <../sizes.scad>
use <../parts/motor.scad>
use <../parts/_shared.scad>

axisOffset = 40;

//gearOffset = 28;
//gearAngle = 45;

gap = 0.3;
gth = 4;

// gear

mm_per_tooth = 6;

n1 = 10;
n2 = 22;
n3 = 13;
n4 = 22;

r1 = pitch_radius(mm_per_tooth,n1);
r2 = pitch_radius(mm_per_tooth,n2);
r3 = pitch_radius(mm_per_tooth,n3);
r4 = pitch_radius(mm_per_tooth,n4);

gearOffset = r1 + r2;
gearGear = r2 * 2;
axisGear = r4 * 2;

tb = r1 + r2;
ta = r3 + r4;
tc = axisOffset;

gearAngle = acos((tb*tb + tc*tc - ta*ta)/(2 * tb * tc));

bolts = [[46, 28, motor5H/2], [25, -25, motor5H/2], [-9, 33, motor5H/2]];

module knee(){
	difference()
	{
		union()
		{
			intersection()
			{
				case(outer = true);
				upperCover();
			}

			intersection()
			{
				case(outer = true);
				lowerCover();
			}

			difference()
			{
				case(outer = true);
				case(outer = false);
				
				// spacing for part 2
				
				translate([32, -30, 0])
					cube([40, 40, motor5H]);
					
				translate([54, -30, 0])
					rotate([0, 0, 45])
						cube([40, 40, motor5H]);
					
			}
		}
		
		z = motor5H + gth + gap + gth + gap + bb6000h;
		
		translate([axisOffset, 0, 0])
			translate([0, 0, z])
				rotationSensorSpacing();					
	}
	
	// d = 25 / sqrt(2) / 2;
	
	// for (x = [-d, d])
	// for (y = [-d, d])
		// translate([x, y, 0])
		
	//for(bolt = bolts)
	//	translate(bolt)
	//		cylinder(d = 7, h = 60);
}

module upperCover() {
	z = motor5H + gth + gap + gth + gap;
	
	// gear
	
	rotate([0, 0, gearAngle])
	translate([gearOffset, 0, 0])
	difference()
	{
		union()
		{
			translate([0, 0, z])
			{
				ring(d = bb6701i - th*2, h = bb6701h, t = th, center = false);
				
				translate([0, 0, bb6701h - gap])
					ring(d = bb6701i - th*2, h = 10, t = th + 2, center = false);
			}
			
			translate([0, 0, z])
			{
				difference()
				{
					ring(d = gearGear - 10, h = 20, t = th, center = false);
					rotate([0, 0, 215]) cube([100, 100, 100]);
				}
			}
		}
		
		//cube([100, 100, 100]);
	}
	
	// axis
	
	translate([axisOffset, 0, 0])
	difference()
	{
		union()
		{
			translate([0, 0, z])
			{
				ring(d = bb6000o, h = 15, t = th, center = false);
		
				translate([0, 0, bb6000h])	
				{
					difference()
					{
						cylinder(d = bb6000o, h = th * 2);
					}
				}
			}
		}
		
		//cube([100, 100, 100]);
	}
}

module lowerCover() {
	translate([axisOffset, 0, 0])
	rotate([180, 0, 0])
	{
		ring(d = bb6000o, h = bb6000h + 5, t = th, center = false);
		
		translate([0, 0, bb6000h])
			ring(d = bb6000o - 2, h = 5, t = th, center = false);
	}
}

module case(outer = true){
	wall = outer ? th : 0;
	
	hull()
	{
		h1 = motor5H + th * 2;
		h2 = motor5H + th * 2 + bb6701h;
		h3 = motor5H + th * 3 + bb6000h * 2;
		
		translate([0, 0, h1/2])
			shayba(d = motor5D + 6 + wall * 2, h = h1 + wall*2, rd = 10);
			
		rotate([0, 0, gearAngle])
		translate([gearOffset, 0, 0])
		translate([0, 0, h2/2])
			shayba(d = gearGear + 6 + wall * 2, h = h2 + wall*2, rd = 10);
			
		translate([axisOffset, 0, 0])
		translate([0, 0, (h3)/2 - bb6000h])
			shayba(d = axisGear + 6 + wall * 2, h = h3 + wall*2, rd = 10);
	}
}

module motorAssembly() {
	difference()
	{
		union()
		{
			color ("turquoise")
				motor5();
				
			translate([0, 0, motor5H])
			{
				motorGear();
			}
		}
		
		//translate([-100, 0, -1]) cube([100, 100, 100]);
	}
}

module gearAssembly(){
	rotate([0, 0, gearAngle])
	translate([gearOffset, 0, 0])
	difference()
	{
		translate([0, 0, motor5H])
		{
			color ("turquoise")
				interimGear();
				
			translate([0, 0, gth + gap])
			{
				translate([0, 0, gth + bb6701h/2])
				{
					color("white")
						bb6701();
				}
			}
		}
		
		cube([100, 100, 100]);
	}
}

module axisAssembly() {
	translate([axisOffset, 0, 0])
	difference()
	{
		union()
		{
			color ("white")
			translate([0, 0, -10])
				cylinder(h = 50, d = 10);
				
			color ("pink")
			{
				axisGear();
			}
			
			color("white")
			{
				translate([0, 0, motor5H + gth + gap + gth + gap + bb6000h/2])
					bb6000();
			
				translate([0, 0, -4])
					bb6000();
			}		
		}
		
		//cube([100, 100, 100]);		
	}
}

module motorGear() {
	cylinder(d = 30, h = gth);
	
	translate([0, 0, gth])
		gear(mm_per_tooth,n1,gth + gap,0);
}

module interimGear(){
	gear(mm_per_tooth,n3,gth + gap,0);
		
	translate([0, 0, gth + gap])
	{
		gear(mm_per_tooth,n2,gth,0);
			
		translate([0, 0, gth + bb6701h/2])
			ring(d = bb6701o, h = bb6701h, t = th);
	}
}

module axisGear(){
	translate([0, 0, motor5H])
		gear(mm_per_tooth,n4,gth,rod + 1);
	
	ring(d = rod + 0.6, h = motor5H + gth + gap + gth + gap, t = th, center = false);
}