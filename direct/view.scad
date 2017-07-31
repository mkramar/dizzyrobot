include <sizes.scad>
include <parts/body.scad>
include <parts/heap.scad>
include <parts/thigh.scad>
include <parts/shin.scad>
include <parts/foot.scad>

assembly();

module assembly(){
	bodyAssembly();
	
	bodyMirror()
	bodyToHeap(0)
	{
		heapAssembly();
		
		heapToThigh(0){
			thighAssembly();
			
			thighToShin(0){
				shinAssembly();
				
				shinToFoot(){
					footAssembly();
				}
			}
		}
	}
}

module bodyToHeap(angle){
	translate(bodyMotorOffset)
	rotate([0, -angle, 0])
		children();
}

module heapToThigh(angle){
	translate(heapMotorOffset)
	rotate([angle, 0, 0])
		children();
}

module thighToShin(angle){
	translate(thighMotorOffset)
	rotate([-angle, 0, 0])
		children();
}

module shinToFoot(){
	translate(shinMotorOffset)
		children();
}

module bodyMirror(){
	children();
	mirror(1, 0, 0) children();
}