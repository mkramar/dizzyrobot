h1 = 190;
h2 = 170;

belt = 7; // 6 mm wide belt
pulleyH = belt + 3;

th = 3.5;
thEdge = 1.5; // ball bearing holder

bbi = 25 - 0.2;
bbo = 37 + 0.7;
bbh = 7;

bbiPlastic = 25 + 0.4;
bboPlastic = 37 - 0.6;

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

// part 1 ---------------------------------------------------------------------

part1UpperAttachment = 15;
part1LowerAttachment = 20;
part1HeapMotorOffset = [-5, 23, -55];
part1KneeMotorOffset = [5, 0, -h1 + 55];
part1KneeOffset = [-14, 0, -h1];

// part 2 ---------------------------------------------------------------------

part2MotorOffset = [10, 0, -h2 + 50];
part2LowerAttachment = 8;
part2AnkleOffset = [0, 0, -h2];