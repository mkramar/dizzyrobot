gap = 3; // distance between moving parts that should not touch
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

// 60XX

motor6D = 57.7 + 1.0;
motor6H = 27.5;
motor6Cut = 8;


// motor6D = 68;
// motor6H = 23;
// motor6Cut = 4;

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

// body -----------------------------------------------------------------------

headD = 200;
headOffsetZ = 400;
headOffsetY = 60;
headOffset = [0, headOffsetY, headOffsetZ];

bodyMotorOffsetX = motor6D/2 + gap * 2;
bodyMotorOffsetZ = -motor6D/2;
bodyMotorOffsetY = -30;
bodyMotorOffset = [bodyMotorOffsetX, bodyMotorOffsetY, bodyMotorOffsetZ];

// heap -----------------------------------------------------------------------

heapMotorOffsetX = 30;
heapMotorOffsetZ = -10;
heapMotorOffsetY = motor6H + motor8D/2 + 10;
heapMotorOffset = [heapMotorOffsetX, heapMotorOffsetY, heapMotorOffsetZ];

// thigh ----------------------------------------------------------------------

thighMotorOffsetX = 0;
thighMotorOffsetY = 0;
thighLength = 200;
thighMotorOffset = [thighMotorOffsetX, thighMotorOffsetY, -thighLength];

// shin -----------------------------------------------------------------------

shinMotorOffsetX = -15;
shinMotorOffsetY = 0;
shinLength = 200;
shinMotorOffset = [shinMotorOffsetX, shinMotorOffsetY, -shinLength];

// foot -----------------------------------------------------------------------
