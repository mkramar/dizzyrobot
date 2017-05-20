use <../../lib/shapes.scad>
include <../sizes.scad>

module bb(){
	ring(d = bbi, h = bbh, t = (bbo-bbi)/2);
}