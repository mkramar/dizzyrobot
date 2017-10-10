include <sizes.scad>
include <parts/arm.scad>
include <parts/shoulder.scad>
include <parts/body-lower.scad>
//include <parts/body-upper.scad>
include <parts/heap.scad>
include <parts/thigh.scad>
include <parts/shin.scad>
include <parts/foot.scad>

assembly();

module assembly(){
	bodyMirror()
	bodyToShoulder(0){
		shoulderAssembly();
		
		shoulderToArm(0){
			armAssembly();
		}
	}

	bodyLowerAssembly();
	
	bodyMirror()
	bodyToHeap(00)
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

module shoulderToArm(angle){
	translate(armMotorOffset)
	rotate([angle, 0, 0])
		children();
}

module bodyToShoulder(angle){
	translate(shoulderOffset)
	rotate([0, -angle, 0])
		children();
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