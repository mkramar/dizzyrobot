h1 = 250;
h2 = 170;

belt = 7; // 6 mm wide belt
pulleyH = belt + 3;

th = 3;
thEdge = 1.5; // ball bearing holder

// ball bearing

bbi = 25 - 0.2;
bbo = 37 + 0.7;
bbh = 7;

bbiPlastic = 25 + 0.4;
bboPlastic = 37 - 0.6;

//

bb6000i = 10 - 0.2;
bb6000o = 26 + 0.7;
bb6000h = 8;

//

bb6800i = 10 - 0.2;
bb6800o = 19 + 0.7;
bb6800h = 5;

//

rod = 10 + 0.2;

motorAdjustment = 5; // one side

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

// heap -----------------------------------------------------------------------

heapWidth = 70;

// part 1 ---------------------------------------------------------------------

part1MotorX = 20;
part1UpperAttachment = 25;
part1LowerAttachment = 25;
part1HeapMotorOffset = [part1MotorX, 0, -50];
part1KneeMotorOffset = [part1MotorX, 0, -h1 + 50];
part1KneeOffset = [0, 0, -h1];

// part 2 ---------------------------------------------------------------------

part2MotorOffset = [10, 0, -h2 + 50];
part2LowerAttachment = 8;
part2AnkleOffset = [0, 0, -h2];