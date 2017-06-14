
/*
th = 3;

// ball bearing

bbi = 25 - 0.2;
bbo = 37 + 0.7;
bbh = 7;

bbiPlastic = 25 + 0.4;
bboPlastic = 37 - 0.6;

//

//
*/

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

rod = 10 + 0.2;

// bearings -------------------------------------------------------------------

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

motorAdjustment = 5; // one side

th = 3;
gh = 10;
mm_per_tooth = 6;

//

heapWidth = 94;

//

// motor

nm = 10;
rm = pitch_radius(mm_per_tooth,nm);

// axis 1

axis1xOffset = rod/2 + th;
axis1Length = 50;

n1 = 43;
r1 = pitch_radius(mm_per_tooth,n1);
d1 = r1 * 2 + 2;

ring1Offset = 8;
axis1Angle1 = 96;
axis1Angle2 = 210;
axis1Bearing1 = ring1Offset + bb6805h/2 + th * 2 + 2;
axis1Bearing2 = axis1Length - bb6805h/2;

// axis 2

axis2 = motor5H + th + 4 + gh + 2 + bb6800h;//45;
n2 = 45;
r2 = pitch_radius(mm_per_tooth,n2);
d2 = r2*2 + 2;

ring2Offset = -axis2/2 + bb6800h + th + 4;
axis2yOffset = 2;
axis2zOffset = 0;
axis2Angle1 = 90;
axis2Angle2 = 300;

// angles

heapSideAngleMin = -10;
heapSideAngleMax = 90;
heapFrontAngleMin = -15;
heapFrontAngleMax = 150;

//

axisOverlap = 4;



motor2offset = [0, motor5H + ring2Offset + gh + 2, -(rm + r2)];

heapMotorRotate = [axis1Angle2 - 10, 0, 0];
heapMotorTranslate = [60, 0, -(rm + r1)];

// derivatives
 
heapBackBearingOffset = axis1xOffset + axis1Bearing2 + bb6805h;


