include <../sizes.scad>
use <../../lib/shapes.scad>
use <../../lib/sensor.scad>

// public ---------------------------------------------------------------------

module body(){
	translate([(r2 - rm), 0, 0])
	difference()
	{
		heapBase("outer");
		heapBase("inner");
	}
}

