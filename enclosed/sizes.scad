use <../lib/gear.scad>

// motors ---------------------------------------------------------------------

// 50XX

motor5D = 58;
motor5H = 27;

motor5SpaceD = motor5D + 5;
motor5SpaceH = motor5H;

//40XX

motor4D = 50;
motor4H = 30;

motor4SpaceD = motor4D + 5;
motor4SpaceH = motor4H;

// rods -----------------------------------------------------------------------

rod25o = 25;
rod25i = rod25o - 1 * 2;

rod10 = 10 + 0.2;

// bearings -------------------------------------------------------------------

bb6701i = 12 - 0.2;
bb6701o = 18 + 0.7;
bb6701h = 4;

//

bb6000i = 10 - 0.2;
bb6000o = 26 + 0.7;
bb6000h = 8;

//

bb6800i = 10 - 0.2;
bb6800o = 19 + 1;
bb6800h = 5;

//

bb6805i = 25 - 0.2;
bb6805o = 37 + 0.7;
bb6805h = 7;

// custom ---------------------------------------------------------------------

gap = 3; // distance between moving parts that should not touch
th = 2.5;
gh = 10;

// gears

mm_per_tooth = 6;

// motor gear

nm = 10;
rm = pitch_radius(mm_per_tooth,nm);
dm = rm * 2;

// common ---------------------------------------------------------------------

thighH = th + motor5H + th*2 + gap;
thighLength = 200;

heapAngle1Min = -20;
heapAngle1Max = 150;

// heap -----------------------------------------------------------------------

//  gear 1

gn2 = 45;
gr2 = pitch_radius(mm_per_tooth, gn2);
gd2 = gr2 * 2;

// gear 2

gn3 = 40;
gr3 = pitch_radius(mm_per_tooth, gn3);
gd3 = gr3 * 2;

//

heapShellInner1 = (gd2 + 6 + gap * 2);
heapShellOuter1 = heapShellInner1 + th*2;

heapShellInner2 = (gd3 + 6 + gap * 2);

//

heapY1 = -thighH/2 - gap - th;
heapY2 = heapY1 + th;
heapY3 = heapY2 + gap;
heapY4 = heapY3 + th;
heapY5 = heapY4 + motor5H;		// left end of motor
heapY6 = heapY5 + th;			// end motor gear holder
heapY7 = heapY6 + gap;			// begin gear
heapY8 = heapY6 + gh;			// end motor gear
heapY9 = heapY8 + gap;			// end heap inner
heapY0 = heapY9 + th;			// end heap outer

// thigh ----------------------------------------------------------------------

thighMotorUpperYOffset = thighH/2 - th;
thighMotorToAxisUpperAngle = 70;

// knee -----------------------------------------------------------------------

// gear

n1 = 45;
r1 = pitch_radius(mm_per_tooth,n1);
d1 = r1 * 2;

//

kneeShellInner = d1 + 6 + gap * 2;
kneeShellOuter = kneeShellInner + th*2;

motor5DInner = motor5D + gap* 2;
motor5DOuter = motor5D + gap* 2 + th*2;

kneeH = th + gap + th + motor5H + th + gh + gap + th;
shinH = th + motor4H + gap + th;
shinOffset = (kneeH - thighH)/2 - gap - th;

kneeMaxAngle = 160;

kneeY1 = thighH/2 + gap + th;	// shin begin outer
kneeY2 = kneeY1 - th;			// shin begin inner
kneeY3 = kneeY2 - gap;			// thigh begin outer
kneeY4 = kneeY3 - th;			// thigh begin inner, begin motor
kneeY5 = kneeY4 - motor5H;		// left end of motor
kneeY6 = kneeY5 - th;			// end motor gear holder
kneeY7 = kneeY6 - gap;			// begin gear on shin
kneeY8 = kneeY6 - gh;			// end motor gear
kneeY9 = kneeY8 - gap;			// end shin inner
kneeY0 = kneeY9 - th;			// end shin outer

function toY(h, y) = y - h/2;

kneeMotorOffset = motor5H/2 + toY(motor5H, kneeY4);

shinLength = 230;

// ankle ----------------------------------------------------------------------

nf = 36;
rf = pitch_radius(mm_per_tooth,nf);
df = rf * 2;

ankleAngle1 = -30;
ankleAngle2 = 40;

footShellInner = df + 6 + gap * 2;
footShellOuter = footShellInner + th*2;

ankleH = th + gap + th + motor4H + th + gh + gap + th;
footOffset = (ankleH - shinH)/2 - gap - th;

ankleY1 = ankleH/2;	// foot begin outer
ankleY2 = ankleY1 - th;			// foot begin inner
ankleY3 = ankleY2 - gap;		// foot begin outer
ankleY4 = ankleY3 - th;			// foot begin inner, begin motor
ankleY5 = ankleY4 - motor4H;	// left end of motor
ankleY6 = ankleY5 - th;			// end motor gear holder
ankleY7 = ankleY6 - gap;		// begin gear on foot
ankleY8 = ankleY6 - gh;			// end motor gear
ankleY9 = ankleY8 - gap;		// end foot inner
ankleY0 = ankleY9 - th;			// end foot outer

ankleMotorOffset = motor4H/2 + toY(motor4H, ankleY4);