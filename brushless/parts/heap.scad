include <../_sizes.scad>
use <../../lib/shapes.scad>
use <../_shared.scad>

heapOffset = 15;
heapWidth = 36;

//heap();

module heap(preview = false) {
	rotate([0, 0, 90])
		heap1(preview);
	
	translate([heapWidth, -heapOffset, 0])
		heap2(preview);
}

module heap1(preview) {
	bearingOuter(withPulley = !preview);
	
	intersection()
	{
		length = 60;// bbo/2 + th + heapOffset - bbh;
		
		translate([-length/2 - bbh/2, 0, 0])
		rotate([0, 90, 0])
			ring(d = bbo - thEdge*2, t = th, h = length, $fn = 70);
		
		translate([-heapOffset, 0, 0])
		rotate([0, 0, 45])
		translate([0, -50, -50])
			cube([100, 100, 100]);
	}
}

module heap2(preview) {
	bearingOuter(withPulley = !preview);
	
	intersection()
	{
		translate([-heapWidth, 0, 0])
		rotate([0, 90, 0])
			ring(d = bbo - thEdge*2, t = th, h = 60, $fn = 70);
			
		translate([-heapWidth, 0, 0])
		rotate([0, 0, -45])
		translate([0, -50, -50])
			cube([100, 100, 100]);
			
		translate([-60, -45, -25])
			cube([120, 50, 50]);
	}
}