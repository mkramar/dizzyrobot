shaft = 100;
boxTh = 10;
moldTh = 20;
fitGap = 0.3;
lockPlus = 16;
lockMinus = 14;

module assembly1(){
	difference(){
		children(0);				// shell outer
		children(1);				// shell inner
	}
}

module assembly2(){
	difference() {
		union() {
			assembly1(){
				children(0);
				children(1);
			}
			
			intersection() {
				children(1);			// shell outer
				children(2);			// inner plus
			}
		}
		
		children(3);					// inner minus
	}
}

module assembly3(){
	difference() {
		union() {
			assembly2(){
				children(0);
				children(1);
				children(2);
				children(3);
			}
			
			intersection() {
				children(1);			// shell inner
				children(4);			// bolts plus
			}
		}
		
		children(5);					// bolts minus
	}
}

module assembly(bolts){
	assembly3(){
		children(0);				// shell outer
		children(1);				// shell inner
		children(2);				// shell outer
		children(3);				// shell inner

		for (x = bolts){
			translate(x)
			boltPlus();
		}		
		
		for (x = bolts){
			translate(x)
			boltMinus(10);
		}			
	}
}

// cut ------------------------------------------------------------------------

module cutA(bolts){
	intersection() {
		assembly(bolts){
			children(0);					// shell outer
			children(1);					// shell inner
			children(2);					// inner plus
			children(3);					// inner minus
		}
		
		children(4);						// split
	}
}

module cutB(bolts){
	difference() {
		assembly(bolts){
			children(0);
			children(1);
			children(2);
			children(3);
		}
		
		children(4);						// split
	}
}

// mold mold ------------------------------------------------------------------

module moldMoldA(bolts, locks){	
	children(4);							// box bottom
	
	difference() {
		union() {
			intersection() {
				//difference() {
					children(5);			// volume
				//	children(4);			// box bottom
				//}

				difference() {
					children(0);			// shell outer
					children(3);			// structure minus
				}
			}
			
			intersection() {
				//difference() {
					children(5);			// volume
				//	children(4);			// box bottom
				//}
				
				children(1);				// shell inner
			}
			
			for (x = locks){
				translate(x)
					sphere(d=lockPlus);
			}
		}
		
		for (x = bolts){
			translate(x)
				boltMinus(10);
		}
	}
}

module moldMoldB(bolts, locks){	
	children(4);							// box bottom
	
	difference() {
		children(5);						// volume
		children(1);						// shell inner
		
		for (x = locks){
			translate(x)
				sphere(d=lockMinus);
		}	
	}
	
	intersection() {
		children(5);						// volume
		children(1);						// shell inner	
		
		difference() {
			children(2);					// structure plus
			children(3);					// structure minus
		}
	}

	intersection() {
		children(5);						// volume
		children(1);						// shell inner	
		
		for (x = bolts){
			translate(x)
			boltPlus();
		}				
	}
}

// box ------------------------------------------------------------------------

module boxBorderA(box) {
	g = fitGap - plusAngle(boxTh);
	x = boxTh;
	boxPlus = [box[0] + g*2, box[1] + g*2, box[2]];
	
	difference() {
		translate([-x, -x, -x + 0.01])
			cube([box[0] + x*2, box[1] + x*2, box[2] + x + moldTh - 0.02]);
		
		translate([-g, -g, -x])
			cuboid(boxPlus[0], boxPlus[1], boxPlus[2] + moldTh + x, -plusAngle(boxPlus[2] + moldTh + x));
	}
}

module boxVolumeA(box) {
	cuboid(box[0], box[1], box[2]/* + moldTh*/, -plusAngle(box[2]/* + moldTh*/));
}

module boxBottomA(box) {
	mirror([0, 0, 1])
		cuboid(box[0], box[1], boxTh, plusAngle(boxTh));
}

//

module boxBorderB(box) {
	x = boxTh;
	g = fitGap + plusAngle(moldTh);
	boxPlus = [box[0] + g*2, box[1] + g*2, box[2]];
	
	difference() {
		translate([-x, -x, -moldTh + 0.01])
			cube([box[0] + x*2, box[1] + x*2, box[2] + moldTh + x - 0.02]);
		
		translate([-g, -g, -moldTh])
			cuboid(boxPlus[0], boxPlus[1], boxPlus[2] + moldTh + x, plusAngle(box[2] + moldTh + x));
	}
}

module boxVolumeB(box) {
	cuboid(box[0], box[1], box[2], plusAngle(box[2]));
}

module boxBottomB(box) {
	intersection() {
			cuboid(box[0], box[1], box[2] + boxTh, plusAngle(box[2] + boxTh));
	
		translate([0, 0, box[2]])
			cube([box[0], box[1], boxTh]);
	}
}

// bolts ----------------------------------------------------------------------

module boltPlus() {
	cylinder(d1 = 12, d2 = 12 + plusAngle(shaft), h = shaft);
	mirror([0, 0, 1]) cylinder(d1 = 12, d2 = 12 + plusAngle(shaft), h = shaft);
}

module boltMinus(bolt) {
	sd = 3.2;
	sw = 6.5;
	sh = 2.5;
	
	// bolt
	
	cylinder(h = bolt/2, d = sd, $fn = 15);

	translate([0, 0, bolt/2-0.01]) {
		cylinder(h = sh, d1 = sd, d2 = sw, $fn = 15);

		translate([0, 0, sh-0.01])
			cylinder(h = (shaft - bolt)/2 + 0.01, d1 = 7, d2 = 7 + plusAngle(shaft), $fn = 15);
	}
	
	// nut

    mirror([0, 0, 1]) {
		cylinder(h = bolt/2, d = sd, $fn = 15);

        translate([0, 0, bolt/2])
            cylinder(h = (shaft - bolt)/2 + 0.01, d1 = 7, d2 = 7 + plusAngle(shaft), $fn = 6);    
    }	
}

//

function plus2th(mode) = (mode == "outer" ? th*2 : 0);
function plusAngle(length) = length * 5 / 100;

module cuboid(w, l, h, taper) {
	ho = taper;
	hw = w - taper;
	hl = l - taper;
	polyhedron( points=[
		[ 0,  0, 0],
		[ho, ho, h],
		[hw, ho, h],
		[ w,  0, 0],
		[ 0,  l, 0],
		[ho, hl, h],
		[hw, hl, h],
		[ w,  l, 0] 
	], faces = [
		[0, 1, 2],
		[2, 3, 0],
		[3, 2, 6],
		[6, 7, 3],
		[7, 6, 5],
		[5, 4, 7],
		[4, 5, 1],
		[1, 0, 4],
		[1, 5, 2],
		[2, 5, 6],
		[4, 0, 3],
		[7, 4, 3],
	] );
}