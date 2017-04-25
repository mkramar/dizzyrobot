h1 = 200;
h2 = 150;

belt = 7; // 6 mm wide belt

th = 3.5;
thEdge = 2; // ball bearing holder

// plastic: between 0.25 and 0.5. try 0.4

bbi = 25; // -0.25 looks close, try -0.2
bbo = 37; // +0.5 is not enough, +1 is too much. try + 0.7
bbh = 7;
bbMargin = 0.2; // one side

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
part1LowerAttachment = 10;
part1HeapMotorOffset = [-5, 23, -55];
part1KneeMotorOffset = [2, 0, -h1 + 65];
part1KneeOffset = [-20, 0, -h1];

// part 2 ---------------------------------------------------------------------

part2MotorOffset = [30, 0, -h2 + 40];