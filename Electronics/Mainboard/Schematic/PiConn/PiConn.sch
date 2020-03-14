EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:PiConn-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L CONN_02X20 J2
U 1 1 5D043848
P 3950 4950
F 0 "J2" H 3950 6000 50  0000 C CNN
F 1 "CONN_02X20" V 3950 4950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x20_Pitch2.54mm" H 3950 4000 50  0001 C CNN
F 3 "" H 3950 4000 50  0001 C CNN
	1    3950 4950
	1    0    0    -1  
$EndComp
Text GLabel 3700 4000 0    60   Input ~ 0
3.3V
$Comp
L Earth #PWR7
U 1 1 5D043850
P 4200 4200
F 0 "#PWR7" H 4200 3950 50  0001 C CNN
F 1 "Earth" H 4200 4050 50  0001 C CNN
F 2 "" H 4200 4200 50  0001 C CNN
F 3 "" H 4200 4200 50  0001 C CNN
	1    4200 4200
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR1
U 1 1 5D043856
P 3700 4400
F 0 "#PWR1" H 3700 4150 50  0001 C CNN
F 1 "Earth" H 3700 4250 50  0001 C CNN
F 2 "" H 3700 4400 50  0001 C CNN
F 3 "" H 3700 4400 50  0001 C CNN
	1    3700 4400
	0    1    1    0   
$EndComp
Text GLabel 3700 4800 0    60   Input ~ 0
3.3V
Text GLabel 3700 4900 0    60   Input ~ 0
MOSI
Text GLabel 3700 5000 0    60   Input ~ 0
MISO
Text GLabel 3700 5100 0    60   Input ~ 0
SCK
$Comp
L Earth #PWR2
U 1 1 5D043860
P 3700 5200
F 0 "#PWR2" H 3700 4950 50  0001 C CNN
F 1 "Earth" H 3700 5050 50  0001 C CNN
F 2 "" H 3700 5200 50  0001 C CNN
F 3 "" H 3700 5200 50  0001 C CNN
	1    3700 5200
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR3
U 1 1 5D043866
P 3700 5900
F 0 "#PWR3" H 3700 5650 50  0001 C CNN
F 1 "Earth" H 3700 5750 50  0001 C CNN
F 2 "" H 3700 5900 50  0001 C CNN
F 3 "" H 3700 5900 50  0001 C CNN
	1    3700 5900
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR8
U 1 1 5D04386C
P 4200 4600
F 0 "#PWR8" H 4200 4350 50  0001 C CNN
F 1 "Earth" H 4200 4450 50  0001 C CNN
F 2 "" H 4200 4600 50  0001 C CNN
F 3 "" H 4200 4600 50  0001 C CNN
	1    4200 4600
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR9
U 1 1 5D043872
P 4200 4900
F 0 "#PWR9" H 4200 4650 50  0001 C CNN
F 1 "Earth" H 4200 4750 50  0001 C CNN
F 2 "" H 4200 4900 50  0001 C CNN
F 3 "" H 4200 4900 50  0001 C CNN
	1    4200 4900
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR10
U 1 1 5D043878
P 4200 5400
F 0 "#PWR10" H 4200 5150 50  0001 C CNN
F 1 "Earth" H 4200 5250 50  0001 C CNN
F 2 "" H 4200 5400 50  0001 C CNN
F 3 "" H 4200 5400 50  0001 C CNN
	1    4200 5400
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR11
U 1 1 5D04387E
P 4200 5600
F 0 "#PWR11" H 4200 5350 50  0001 C CNN
F 1 "Earth" H 4200 5450 50  0001 C CNN
F 2 "" H 4200 5600 50  0001 C CNN
F 3 "" H 4200 5600 50  0001 C CNN
	1    4200 5600
	0    -1   -1   0   
$EndComp
Text GLabel 4200 5100 2    60   Input ~ 0
CS
Text GLabel 3700 5400 0    60   Input ~ 0
RESPRDY
Text GLabel 3700 5500 0    60   Input ~ 0
RECVRDY
Text GLabel 3700 5700 0    60   Input ~ 0
GPIO19
Text GLabel 3700 5800 0    60   Input ~ 0
GPIO26
Text GLabel 4200 5700 2    60   Input ~ 0
GPIO16
Text GLabel 4200 4700 2    60   Input ~ 0
GPIO23
Text GLabel 4200 4800 2    60   Input ~ 0
GPIO24
Text GLabel 4200 5800 2    60   Input ~ 0
PWR_INT
Text GLabel 4200 5900 2    60   Input ~ 0
~PWR_KILL
$Comp
L CONN_02X10 J1
U 1 1 5D04388E
P 3950 2950
F 0 "J1" H 3950 3500 50  0000 C CNN
F 1 "CONN_02X10" V 3950 2950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_2x10_Pitch2.54mm" H 3950 1750 50  0001 C CNN
F 3 "" H 3950 1750 50  0001 C CNN
	1    3950 2950
	1    0    0    -1  
$EndComp
Text GLabel 4200 3400 2    60   Input ~ 0
12V
Text GLabel 4200 3300 2    60   Input ~ 0
12V
Text GLabel 4200 3200 2    60   Input ~ 0
12V
Text GLabel 3700 3300 0    60   Input ~ 0
5V
Text GLabel 3700 3200 0    60   Input ~ 0
5V
Text GLabel 3700 3400 0    60   Input ~ 0
5V
Text GLabel 4200 2900 2    60   Input ~ 0
3.3V
Text GLabel 4200 3000 2    60   Input ~ 0
3.3V
Text GLabel 4200 3100 2    60   Input ~ 0
3.3V
$Comp
L Earth #PWR5
U 1 1 5D04389E
P 4200 2700
F 0 "#PWR5" H 4200 2450 50  0001 C CNN
F 1 "Earth" H 4200 2550 50  0001 C CNN
F 2 "" H 4200 2700 50  0001 C CNN
F 3 "" H 4200 2700 50  0001 C CNN
	1    4200 2700
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR4
U 1 1 5D0438A4
P 4200 2600
F 0 "#PWR4" H 4200 2350 50  0001 C CNN
F 1 "Earth" H 4200 2450 50  0001 C CNN
F 2 "" H 4200 2600 50  0001 C CNN
F 3 "" H 4200 2600 50  0001 C CNN
	1    4200 2600
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR6
U 1 1 5D0438AA
P 4200 2800
F 0 "#PWR6" H 4200 2550 50  0001 C CNN
F 1 "Earth" H 4200 2650 50  0001 C CNN
F 2 "" H 4200 2800 50  0001 C CNN
F 3 "" H 4200 2800 50  0001 C CNN
	1    4200 2800
	0    -1   -1   0   
$EndComp
Text GLabel 3700 2500 0    60   Input ~ 0
MOSI
Text GLabel 3700 2600 0    60   Input ~ 0
MISO
Text GLabel 3700 2700 0    60   Input ~ 0
SCK
Text GLabel 3700 2800 0    60   Input ~ 0
CS
Text GLabel 3700 2900 0    60   Input ~ 0
RESPRDY
Text GLabel 3700 3000 0    60   Input ~ 0
RECVRDY
Text GLabel 3700 3100 0    60   Input ~ 0
PWR_INT
Text GLabel 4200 2500 2    60   Input ~ 0
~PWR_KILL
$Comp
L C_Small C3
U 1 1 5D05592F
P 5450 3800
F 0 "C3" H 5460 3870 50  0000 L CNN
F 1 "C_Small" H 5460 3720 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5450 3800 50  0001 C CNN
F 3 "" H 5450 3800 50  0001 C CNN
	1    5450 3800
	0    1    1    0   
$EndComp
$Comp
L C_Small C2
U 1 1 5D055980
P 5450 3550
F 0 "C2" H 5460 3620 50  0000 L CNN
F 1 "C_Small" H 5460 3470 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5450 3550 50  0001 C CNN
F 3 "" H 5450 3550 50  0001 C CNN
	1    5450 3550
	0    1    1    0   
$EndComp
$Comp
L C_Small C1
U 1 1 5D0559B0
P 5450 3300
F 0 "C1" H 5460 3370 50  0000 L CNN
F 1 "C_Small" H 5460 3220 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 5450 3300 50  0001 C CNN
F 3 "" H 5450 3300 50  0001 C CNN
	1    5450 3300
	0    1    1    0   
$EndComp
Text GLabel 5350 3300 0    60   Input ~ 0
12V
Text GLabel 5350 3550 0    60   Input ~ 0
5V
Text GLabel 5350 3800 0    60   Input ~ 0
3.3V
$Comp
L Earth #PWR12
U 1 1 5D055A76
P 5550 3300
F 0 "#PWR12" H 5550 3050 50  0001 C CNN
F 1 "Earth" H 5550 3150 50  0001 C CNN
F 2 "" H 5550 3300 50  0001 C CNN
F 3 "" H 5550 3300 50  0001 C CNN
	1    5550 3300
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR13
U 1 1 5D055A90
P 5550 3550
F 0 "#PWR13" H 5550 3300 50  0001 C CNN
F 1 "Earth" H 5550 3400 50  0001 C CNN
F 2 "" H 5550 3550 50  0001 C CNN
F 3 "" H 5550 3550 50  0001 C CNN
	1    5550 3550
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR14
U 1 1 5D055AAA
P 5550 3800
F 0 "#PWR14" H 5550 3550 50  0001 C CNN
F 1 "Earth" H 5550 3650 50  0001 C CNN
F 2 "" H 5550 3800 50  0001 C CNN
F 3 "" H 5550 3800 50  0001 C CNN
	1    5550 3800
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X02 J3
U 1 1 5D05C351
P 5400 4450
F 0 "J3" H 5400 4600 50  0000 C CNN
F 1 "CONN_01X02" V 5500 4450 50  0000 C CNN
F 2 "Dizzy:2x1.5-conn" H 5400 4450 50  0001 C CNN
F 3 "" H 5400 4450 50  0001 C CNN
	1    5400 4450
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X02 J4
U 1 1 5D05C3A0
P 5400 4850
F 0 "J4" H 5400 5000 50  0000 C CNN
F 1 "CONN_01X02" V 5500 4850 50  0000 C CNN
F 2 "Dizzy:2x1.5-conn" H 5400 4850 50  0001 C CNN
F 3 "" H 5400 4850 50  0001 C CNN
	1    5400 4850
	-1   0    0    1   
$EndComp
$Comp
L CONN_01X02 J5
U 1 1 5D05C3E1
P 5400 5250
F 0 "J5" H 5400 5400 50  0000 C CNN
F 1 "CONN_01X02" V 5500 5250 50  0000 C CNN
F 2 "Dizzy:2x1.5-conn" H 5400 5250 50  0001 C CNN
F 3 "" H 5400 5250 50  0001 C CNN
	1    5400 5250
	-1   0    0    1   
$EndComp
$Comp
L Earth #PWR15
U 1 1 5D05C45F
P 5600 4500
F 0 "#PWR15" H 5600 4250 50  0001 C CNN
F 1 "Earth" H 5600 4350 50  0001 C CNN
F 2 "" H 5600 4500 50  0001 C CNN
F 3 "" H 5600 4500 50  0001 C CNN
	1    5600 4500
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR16
U 1 1 5D05C482
P 5600 4900
F 0 "#PWR16" H 5600 4650 50  0001 C CNN
F 1 "Earth" H 5600 4750 50  0001 C CNN
F 2 "" H 5600 4900 50  0001 C CNN
F 3 "" H 5600 4900 50  0001 C CNN
	1    5600 4900
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR17
U 1 1 5D05C4C5
P 5600 5300
F 0 "#PWR17" H 5600 5050 50  0001 C CNN
F 1 "Earth" H 5600 5150 50  0001 C CNN
F 2 "" H 5600 5300 50  0001 C CNN
F 3 "" H 5600 5300 50  0001 C CNN
	1    5600 5300
	0    -1   -1   0   
$EndComp
Text GLabel 5600 4400 2    60   Input ~ 0
12V
Text GLabel 5600 4800 2    60   Input ~ 0
5V
Text GLabel 5600 5200 2    60   Input ~ 0
3.3V
$EndSCHEMATC