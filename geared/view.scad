use <../lib/shapes.scad>
include <sizes.scad>
use <parts/motor.scad>
use <parts/_shared.scad>

axisOffset = 38;
axisGear = 35;

gearOffset = 28;
gearAngle = 45;
gearGear = 40;

gap = 0;

difference()
{
	union()
	{
		motorAssembly();
		gearAssembly();
	}
	
	//translate([0, 0, -30]) cube([100, 100, 100]);
}

axisAssembly();
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

%case(outer = true);

module upperCover() {
	rotate([0, 0, gearAngle])
	translate([gearOffset, 0, 0])
	difference()
	{
		union()
		{
			translate([0, 0, motor5H + th * 2 + 1])
			{
				cylinder(d = bb6701i, h = bb6701h - 1);
				
				translate([0, 0, bb6701h - 1])
					cylinder(d = bb6701i + 2, h = 10);
			}
			
			translate([0, 0, motor5H + th * 2 + gap])
			{
				difference()
				{
					ring(d = gearGear - 10, h = 15, t = th, center = false);
					rotate([0, 0, 230]) cube([100, 100, 100]);
				}
			}
		}
		
		cube([100, 100, 100]);
	}
	
	translate([axisOffset, 0, 0])
	difference()
	{
		union()
		{
			translate([0, 0, motor5H + th*2 + bb6000h])	
			{
				cylinder(d = bb6000o, h = th);
			}
			
			translate([0, 0, motor5H + th*2])
				ring(d = bb6000o, h = 15, t = th, center = false);
		}
		
		cube([100, 100, 100]);
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
		h3 = motor5H + th * 2 + bb6000h * 2 + 2;
		
		translate([0, 0, h1/2])
			shayba(d = motor5D + 6 + wall * 2, h = h1 + wall*2, rd = 10);
			
		rotate([0, 0, gearAngle])
		translate([gearOffset, 0, 0])
		translate([0, 0, h2/2])
			shayba(d = gearGear + 6 + wall * 2, h = h2 + wall*2, rd = 10);
			
		translate([axisOffset, 0, 0])
		translate([0, 0, (h3)/2 - bb6000h])
			shayba(d = gearGear + 6 + wall * 2, h = h3 + wall*2, rd = 10);
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
				cylinder(d = 30, h = th);
				
				translate([0, 0, th])
				{
					cylinder(d = 15, h = th);
								
					//translate([0, 0, th + 2])
					//{
					//	color("white")
					//	bb6701();
					//}
				}
			}
		}
		
		translate([-100, 0, -1]) cube([100, 100, 100]);
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
				cylinder(d = 17, h = th);
				
			translate([0, 0, th])
			{
				color ("turquoise")
					cylinder(d = gearGear, h = th);
					
				translate([0, 0, th + 2])
				{
					color ("turquoise")
						ring(d = bb6701o, h = bb6701h, t = th);
				
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
			translate([0, 0, motor5H])
				cylinder(d = axisGear, h = th);
			
			color("white")
			{
				translate([0, 0, motor5H + th*2 + 4])
					bb6000();
			
				translate([0, 0, -4])
					bb6000();
			}		
		}
		
		cube([100, 100, 100]);		
	}
}