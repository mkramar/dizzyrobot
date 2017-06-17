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
th = 3;
gh = 10;

// gears

mm_per_tooth = 6;

// motor gear

nm = 10;
rm = pitch_radius(mm_per_tooth,nm);
dm = rm * 2;

// knee gear

n1 = 45;
r1 = pitch_radius(mm_per_tooth,n1);
d1 = r1 * 2;


// knee -----------------------------------------------------------------------

kneeShellInner = d1 + 6 + gap * 2;
kneeShellOuter = kneeShellInner + th*2;

part1Inner = motor5D + gap* 2;
part1Outer = motor5D + gap* 2 + th*2;

part1H = th + motor5H + th*2 + gap;
kneeH = th + gap + th + motor5H + th + gh + gap + th;
part2H = th + motor4H + gap + th;
part2Offset = (kneeH - part1H)/2 - gap - th;

kneeMaxAngle = 160;

kneeY1 = part1H/2 + gap + th;	// part2 begin outer
kneeY2 = kneeY1 - th;			// part2 begin inner
kneeY3 = kneeY2 - gap;			// part1 begin outer
kneeY4 = kneeY3 - th;			// part1 begin inner, begin motor
kneeY5 = kneeY4 - motor5H;		// left end of motor
kneeY6 = kneeY5 - th;			// end motor gear holder
kneeY7 = kneeY6 - gap;			// begin gear on part2
kneeY8 = kneeY6 - gh;			// end motor gear
kneeY9 = kneeY8 - gap;			// end part2 inner
kneeY0 = kneeY9 - th;			// end part2 outer

function toY(h, y) = y - h/2;

motorOffset = motor5H/2 + toY(motor5H, kneeY4);

part2Length = 230;

// ankle ----------------------------------------------------------------------

nf = 35;
rf = pitch_radius(mm_per_tooth,nf);
df = rf * 2;

ankleAngle1 = -30;
ankleAngle2 = 40;

footShellInner = df + 6 + gap * 2;
footShellOuter = footShellInner + th*2;

ankleH = th + gap + th + motor4H + th + gh + gap + th;
footOffset = (ankleH - part2H)/2 - gap - th;

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