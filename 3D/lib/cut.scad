use <boltFlat.scad>

module cutNuts(boltPositions){
	difference(){
		union() {
			intersection() {
				children(0);					// part
				children(1);					// cut
			}

			intersection(){
				intersection(){
					children(2);				// part - outline
					children(1);				// cut
				}
				nutsPlus(boltPositions);
			}
		}

		nutsMinus(boltPositions);
	}
}

module cutBolts(boltPositions){
	difference() {
		union() {
			difference() {
				children(0);					// part
				children(1);					// cut
			}

			intersection(){
				//difference(){
					children(2);				// part - outline
					//children(1);				// cut
				//}
				boltsPlus(boltPositions);
			}
		}

		boltsMinus(boltPositions);
	}
}

// private --------------------------------------------------------------------

module boltsPlus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
			boltPlus(40);
	}
}

module boltsMinus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
			boltMinus(4, 40);
	}
}

module nutsPlus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
			nutPlus(40);
	}
}

module nutsMinus(boltPositions){
	for (x = boltPositions)
	{
		translate(x)
			nutMinus(4, 40);
	}
}
