gap = 2.5; // distance between moving parts that should not touch
th = 2.5;

// rods -----------------------------------------------------------------------

rod25o = 25 + 0.0;
rod25i = rod25o - 1 * 2;

rod10o = 10 + 0.2;

// motors ---------------------------------------------------------------------

// 80XX

motor8D = 88.65 + 1.0;
motor8H = 21.5;
motor8Cut = 5;

// multistar elite 5008

//motor6D = 57.7 + 1.0;
//motor6H = 27.5;
//motor6Cut = 8;

// TYI-Motor 5008

motor6D = 58.4 + 1.0;
motor6H = 27.5;
motor6Cut = 8.5;

// board ----------------------------------------------------------------------

boardW = 20 + 0.5;
boardH = 37 + 0.5;

// battery --------------------------------------------------------------------

batteryZ = 140;
batteryX = 50;
batteryY = 50;
battery = [batteryX, batteryY, batteryZ];

// arm ------------------------------------------------------------------------

armMotorOffset = [70, 30 , 0];
armLength = 160;

// shoulder -------------------------------------------------------------------

shoulderWidth = 140;
shoulderY = 30;
shoulderX = shoulderWidth/2;
shoulderZ = 300;
shoulderOffset = [shoulderX, shoulderY, shoulderZ];

// waist ----------------------------------------------------------------------

waistMotorX = 0;
waistMotorY = 30;
waistMotorZ = 40;
waistMotorOffset = [waistMotorX, waistMotorY, waistMotorZ];
waistMotorOffset2 = [waistMotorX, waistMotorY, waistMotorZ + motor6H];

// body -----------------------------------------------------------------------

headD = 200;
headOffsetZ = 400;
headOffsetY = 60;
headOffset = [0, headOffsetY, headOffsetZ];

bodyMotorOffsetX = motor6D/2 + gap * 2 + 15;
bodyMotorOffsetZ = -motor6D/2;
bodyMotorOffsetY = -30;
bodyMotorOffset = [bodyMotorOffsetX, bodyMotorOffsetY, bodyMotorOffsetZ];

// heap -----------------------------------------------------------------------

heapMotorOffsetX = 30;
heapMotorOffsetZ = 0;
heapMotorOffsetY = motor6H + motor8D/2 + 10;
heapMotorOffset = [heapMotorOffsetX, heapMotorOffsetY, heapMotorOffsetZ];

heapConnectorCylinderD = motor6D + plus2th("outer");//40;

// thigh ----------------------------------------------------------------------

thighMotorOffsetX = 0;
thighMotorOffsetY = 0;
thighLength = 200;
thighMotorOffset = [thighMotorOffsetX, thighMotorOffsetY, -thighLength];

// shin -----------------------------------------------------------------------

shinMotorOffsetX = -25;
shinMotorOffsetY = 0;
shinLength = 200;
shinMotorOffset = [shinMotorOffsetX, shinMotorOffsetY, -shinLength];

// foot -----------------------------------------------------------------------
