include <../../parts/heap.scad>
use <heap.scad>

rotate([0, 135, 0])
difference()
{
	union()
	{
		translate([heapOffset / cos(45), 0, 0])
		rotate([0, -45, 0])
		translate([0, 0, heapOffset])
		rotate([90, 0, 0]) 
			heap1();
			
		intersection ()
		{
			boltsAplus();
			
			rotate([0, 45, 0])
				cylinder(d = bbo - thEdge*2 + th * 2, h = 100, center = true, $fn = 70);
		}
	}
	
	boltsAminus();
}
