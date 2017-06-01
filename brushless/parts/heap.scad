include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>
use <../../lib/pulley.scad>

heapMotorOffset = 32;
heapAxisOffset = 50;
heapH = 40;
heapMotorOffset2 = heapH - heapMotorOffset;
heapCutoff = heapAxisOffset + 70;
heapPulleyLength2 = 25;

module heap(preview = false){
	translate([heapMotorOffset - 20, 0, 0])
	difference()
	{
		heapA(outer = true);
		if (!preview) heapA(outer = false);
		
		translate([-50, -50, -heapCutoff - 100])
			cube([100, 100, 100]);
	}
}

module heapA(outer = true){
	d = outer ? th : 0;
	h = (outer ? th * 2 : 0) + heapH;
	rd = outer ? 15 : 10;
	
	hull()
	{
		translate([0, 0, -heapAxisOffset - heapCutoff])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = rd);
			
		translate([0, 0, 0])
		rotate([0, 90, 0])
			shayba(d = motor5SpaceD + d * 2, h = h, rd = rd);
	}
}

module heapAxisAssembly() {
	color("white")
	translate([heapMotorOffset - heapH, 0, 0])
	rotate([0, 90, 0])
	{
		translate([0, 0, -heapPulleyLength2])
		cylinder(d = 10, h = heapH + heapPulleyLength2);
		
		translate([0, 0, bb6800h/2]) bb6800();
		translate([0, 0, heapH-bb6800h/2]) bb6800();
	}
}

module heapPulley(){
	rotate([0, 90, 0])
	{
		difference()
		{
			pulley(teeth=90, height = belt, center = true, upperBorder = true);

			mirror([0, 0, 1])
			translate([0, 0, -2])
				cylinder(d = bb6800o + th*2 + 4, h = 20);
		}
		
		translate([0, 0, -(heapMotorOffset2 - bb6800h)])
			ring(d = rod + 0.6, h = heapH - (bb6800h*2), t = th, center = false);
	}
}

module heapPulley2(){
	rotate([0, 90, 0])
	translate([0, 0, -heapMotorOffset2 - heapPulleyLength2])
	ring(d = rod + 0.6, h = heapPulleyLength2, t = th, center = false);
}