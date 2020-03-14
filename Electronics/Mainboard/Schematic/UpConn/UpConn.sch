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
LIBS:Dizzy
LIBS:UpConn-cache
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
L CONN_02X10 J2
U 1 1 5D043357
P 6700 3050
F 0 "J2" H 6700 3600 50  0000 C CNN
F 1 "CONN_02X10" V 6700 3050 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Angled_2x10_Pitch2.54mm" H 6700 1850 50  0001 C CNN
F 3 "" H 6700 1850 50  0001 C CNN
	1    6700 3050
	1    0    0    -1  
$EndComp
Text GLabel 6950 3500 2    60   Input ~ 0
12V
Text GLabel 6950 3400 2    60   Input ~ 0
12V
Text GLabel 6950 3300 2    60   Input ~ 0
12V
Text GLabel 6450 3400 0    60   Input ~ 0
5V
Text GLabel 6450 3300 0    60   Input ~ 0
5V
Text GLabel 6450 3500 0    60   Input ~ 0
5V
Text GLabel 6950 3000 2    60   Input ~ 0
3.3V
Text GLabel 6950 3100 2    60   Input ~ 0
3.3V
Text GLabel 6950 3200 2    60   Input ~ 0
3.3V
$Comp
L Earth #PWR01
U 1 1 5D043367
P 6950 2800
F 0 "#PWR01" H 6950 2550 50  0001 C CNN
F 1 "Earth" H 6950 2650 50  0001 C CNN
F 2 "" H 6950 2800 50  0001 C CNN
F 3 "" H 6950 2800 50  0001 C CNN
	1    6950 2800
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR02
U 1 1 5D04336D
P 6950 2700
F 0 "#PWR02" H 6950 2450 50  0001 C CNN
F 1 "Earth" H 6950 2550 50  0001 C CNN
F 2 "" H 6950 2700 50  0001 C CNN
F 3 "" H 6950 2700 50  0001 C CNN
	1    6950 2700
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR03
U 1 1 5D043373
P 6950 2900
F 0 "#PWR03" H 6950 2650 50  0001 C CNN
F 1 "Earth" H 6950 2750 50  0001 C CNN
F 2 "" H 6950 2900 50  0001 C CNN
F 3 "" H 6950 2900 50  0001 C CNN
	1    6950 2900
	0    -1   -1   0   
$EndComp
Text GLabel 6450 2600 0    60   Input ~ 0
MOSI
Text GLabel 6450 2700 0    60   Input ~ 0
MISO
Text GLabel 6450 2800 0    60   Input ~ 0
SCK
Text GLabel 6450 2900 0    60   Input ~ 0
CS
Text GLabel 6450 3000 0    60   Input ~ 0
RESPRDY
Text GLabel 6450 3100 0    60   Input ~ 0
RECVRDY
Text GLabel 6450 3200 0    60   Input ~ 0
PWR_INT
Text GLabel 6950 2600 2    60   Input ~ 0
~PWR_KILL
$Comp
L C_Small C1
U 1 1 5D043388
P 8200 3400
F 0 "C1" H 8210 3470 50  0000 L CNN
F 1 "C_Small" H 8210 3320 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805_HandSoldering" H 8200 3400 50  0001 C CNN
F 3 "" H 8200 3400 50  0001 C CNN
	1    8200 3400
	0    1    1    0   
$EndComp
Text GLabel 8100 3400 0    60   Input ~ 0
12V
$Comp
L Earth #PWR04
U 1 1 5D043391
P 8300 3400
F 0 "#PWR04" H 8300 3150 50  0001 C CNN
F 1 "Earth" H 8300 3250 50  0001 C CNN
F 2 "" H 8300 3400 50  0001 C CNN
F 3 "" H 8300 3400 50  0001 C CNN
	1    8300 3400
	0    -1   -1   0   
$EndComp
$Comp
L CONN_02X50 J1
U 1 1 5D0435BD
P 3150 3550
F 0 "J1" H 3150 5600 50  0000 C CNN
F 1 "CONN_02X50" V 3150 3550 50  0000 C CNN
F 2 "Dizzy:AXK6S-100" H 3150 3550 50  0001 C CNN
F 3 "" H 3150 3550 50  0001 C CNN
	1    3150 3550
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR05
U 1 1 5D0436A7
P 3400 2000
F 0 "#PWR05" H 3400 1750 50  0001 C CNN
F 1 "Earth" H 3400 1850 50  0001 C CNN
F 2 "" H 3400 2000 50  0001 C CNN
F 3 "" H 3400 2000 50  0001 C CNN
	1    3400 2000
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR06
U 1 1 5D0436EB
P 2900 2000
F 0 "#PWR06" H 2900 1750 50  0001 C CNN
F 1 "Earth" H 2900 1850 50  0001 C CNN
F 2 "" H 2900 2000 50  0001 C CNN
F 3 "" H 2900 2000 50  0001 C CNN
	1    2900 2000
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR07
U 1 1 5D0436FF
P 3400 2500
F 0 "#PWR07" H 3400 2250 50  0001 C CNN
F 1 "Earth" H 3400 2350 50  0001 C CNN
F 2 "" H 3400 2500 50  0001 C CNN
F 3 "" H 3400 2500 50  0001 C CNN
	1    3400 2500
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR08
U 1 1 5D043713
P 3400 4000
F 0 "#PWR08" H 3400 3750 50  0001 C CNN
F 1 "Earth" H 3400 3850 50  0001 C CNN
F 2 "" H 3400 4000 50  0001 C CNN
F 3 "" H 3400 4000 50  0001 C CNN
	1    3400 4000
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR09
U 1 1 5D043760
P 3400 4300
F 0 "#PWR09" H 3400 4050 50  0001 C CNN
F 1 "Earth" H 3400 4150 50  0001 C CNN
F 2 "" H 3400 4300 50  0001 C CNN
F 3 "" H 3400 4300 50  0001 C CNN
	1    3400 4300
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR010
U 1 1 5D043774
P 3400 4600
F 0 "#PWR010" H 3400 4350 50  0001 C CNN
F 1 "Earth" H 3400 4450 50  0001 C CNN
F 2 "" H 3400 4600 50  0001 C CNN
F 3 "" H 3400 4600 50  0001 C CNN
	1    3400 4600
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR011
U 1 1 5D043788
P 3400 4900
F 0 "#PWR011" H 3400 4650 50  0001 C CNN
F 1 "Earth" H 3400 4750 50  0001 C CNN
F 2 "" H 3400 4900 50  0001 C CNN
F 3 "" H 3400 4900 50  0001 C CNN
	1    3400 4900
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR012
U 1 1 5D04379C
P 3400 5100
F 0 "#PWR012" H 3400 4850 50  0001 C CNN
F 1 "Earth" H 3400 4950 50  0001 C CNN
F 2 "" H 3400 5100 50  0001 C CNN
F 3 "" H 3400 5100 50  0001 C CNN
	1    3400 5100
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR013
U 1 1 5D0437B0
P 3400 6200
F 0 "#PWR013" H 3400 5950 50  0001 C CNN
F 1 "Earth" H 3400 6050 50  0001 C CNN
F 2 "" H 3400 6200 50  0001 C CNN
F 3 "" H 3400 6200 50  0001 C CNN
	1    3400 6200
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR014
U 1 1 5D04382A
P 2900 2600
F 0 "#PWR014" H 2900 2350 50  0001 C CNN
F 1 "Earth" H 2900 2450 50  0001 C CNN
F 2 "" H 2900 2600 50  0001 C CNN
F 3 "" H 2900 2600 50  0001 C CNN
	1    2900 2600
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR015
U 1 1 5D04383E
P 2900 3200
F 0 "#PWR015" H 2900 2950 50  0001 C CNN
F 1 "Earth" H 2900 3050 50  0001 C CNN
F 2 "" H 2900 3200 50  0001 C CNN
F 3 "" H 2900 3200 50  0001 C CNN
	1    2900 3200
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR016
U 1 1 5D043900
P 2900 3700
F 0 "#PWR016" H 2900 3450 50  0001 C CNN
F 1 "Earth" H 2900 3550 50  0001 C CNN
F 2 "" H 2900 3700 50  0001 C CNN
F 3 "" H 2900 3700 50  0001 C CNN
	1    2900 3700
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR017
U 1 1 5D043920
P 2900 4200
F 0 "#PWR017" H 2900 3950 50  0001 C CNN
F 1 "Earth" H 2900 4050 50  0001 C CNN
F 2 "" H 2900 4200 50  0001 C CNN
F 3 "" H 2900 4200 50  0001 C CNN
	1    2900 4200
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR018
U 1 1 5D043934
P 2900 4500
F 0 "#PWR018" H 2900 4250 50  0001 C CNN
F 1 "Earth" H 2900 4350 50  0001 C CNN
F 2 "" H 2900 4500 50  0001 C CNN
F 3 "" H 2900 4500 50  0001 C CNN
	1    2900 4500
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR019
U 1 1 5D043948
P 2900 4800
F 0 "#PWR019" H 2900 4550 50  0001 C CNN
F 1 "Earth" H 2900 4650 50  0001 C CNN
F 2 "" H 2900 4800 50  0001 C CNN
F 3 "" H 2900 4800 50  0001 C CNN
	1    2900 4800
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR020
U 1 1 5D04395C
P 2900 5100
F 0 "#PWR020" H 2900 4850 50  0001 C CNN
F 1 "Earth" H 2900 4950 50  0001 C CNN
F 2 "" H 2900 5100 50  0001 C CNN
F 3 "" H 2900 5100 50  0001 C CNN
	1    2900 5100
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR021
U 1 1 5D043A4B
P 2900 5700
F 0 "#PWR021" H 2900 5450 50  0001 C CNN
F 1 "Earth" H 2900 5550 50  0001 C CNN
F 2 "" H 2900 5700 50  0001 C CNN
F 3 "" H 2900 5700 50  0001 C CNN
	1    2900 5700
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR022
U 1 1 5D043A5F
P 2900 6000
F 0 "#PWR022" H 2900 5750 50  0001 C CNN
F 1 "Earth" H 2900 5850 50  0001 C CNN
F 2 "" H 2900 6000 50  0001 C CNN
F 3 "" H 2900 6000 50  0001 C CNN
	1    2900 6000
	0    1    1    0   
$EndComp
Text GLabel 2900 2700 0    60   Input ~ 0
MOSI
Text GLabel 2900 2800 0    60   Input ~ 0
MISO
Text GLabel 2900 2900 0    60   Input ~ 0
SCK
Text GLabel 2900 3000 0    60   Input ~ 0
CS
Text GLabel 3400 3100 2    60   Input ~ 0
RESPRDY
Text GLabel 3400 3200 2    60   Input ~ 0
RECVRDY
$Comp
L CONN_01X02 J3
U 1 1 5D044A58
P 6800 4300
F 0 "J3" H 6800 4450 50  0000 C CNN
F 1 "CONN_01X02" V 6900 4300 50  0000 C CNN
F 2 "Dizzy:2x2.1-conn" H 6800 4300 50  0001 C CNN
F 3 "" H 6800 4300 50  0001 C CNN
	1    6800 4300
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR023
U 1 1 5D044ACF
P 6600 4350
F 0 "#PWR023" H 6600 4100 50  0001 C CNN
F 1 "Earth" H 6600 4200 50  0001 C CNN
F 2 "" H 6600 4350 50  0001 C CNN
F 3 "" H 6600 4350 50  0001 C CNN
	1    6600 4350
	0    1    1    0   
$EndComp
Text GLabel 6600 4250 0    60   Input ~ 0
12V
$EndSCHEMATC