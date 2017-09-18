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
LIBS:Misha
LIBS:v3-cache
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
L STSPIN32F0 U1
U 1 1 5977507E
P 3550 3000
F 0 "U1" H 3800 3100 60  0000 C CNN
F 1 "STSPIN32F0" H 3900 2900 60  0000 C CNN
F 2 "Housings_DFN_QFN:QFN-48-1EP_7x7mm_Pitch0.5mm" H 3550 3000 60  0001 C CNN
F 3 "" H 3550 3000 60  0001 C CNN
	1    3550 3000
	1    0    0    -1  
$EndComp
$Comp
L L9616 U2
U 1 1 59775190
P 3900 6400
F 0 "U2" H 3900 6400 60  0000 C CNN
F 1 "L9616" H 3900 6600 60  0000 C CNN
F 2 "Housings_SOIC:SOIC-8_3.9x4.9mm_Pitch1.27mm" H 3900 6400 60  0001 C CNN
F 3 "" H 3900 6400 60  0001 C CNN
	1    3900 6400
	1    0    0    -1  
$EndComp
$Comp
L L L1
U 1 1 59775315
P 1750 3350
F 0 "L1" V 1700 3350 50  0000 C CNN
F 1 "22uH" V 1825 3350 50  0000 C CNN
F 2 "Inductors_SMD:L_1812" H 1750 3350 50  0001 C CNN
F 3 "" H 1750 3350 50  0001 C CNN
	1    1750 3350
	0    1    1    0   
$EndComp
$Comp
L D D1
U 1 1 597753DE
P 1900 3500
F 0 "D1" H 1900 3600 50  0000 C CNN
F 1 "D" H 1900 3400 50  0000 C CNN
F 2 "Diodes_SMD:D_0805" H 1900 3500 50  0001 C CNN
F 3 "" H 1900 3500 50  0001 C CNN
	1    1900 3500
	0    1    1    0   
$EndComp
$Comp
L +3.3V #PWR01
U 1 1 597754F3
P 1150 3350
F 0 "#PWR01" H 1150 3200 50  0001 C CNN
F 1 "+3.3V" H 1150 3490 50  0000 C CNN
F 2 "" H 1150 3350 50  0001 C CNN
F 3 "" H 1150 3350 50  0001 C CNN
	1    1150 3350
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR02
U 1 1 5977551C
P 1900 3650
F 0 "#PWR02" H 1900 3400 50  0001 C CNN
F 1 "Earth" H 1900 3500 50  0001 C CNN
F 2 "" H 1900 3650 50  0001 C CNN
F 3 "" H 1900 3650 50  0001 C CNN
	1    1900 3650
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR03
U 1 1 5977553A
P 1400 3650
F 0 "#PWR03" H 1400 3400 50  0001 C CNN
F 1 "Earth" H 1400 3500 50  0001 C CNN
F 2 "" H 1400 3650 50  0001 C CNN
F 3 "" H 1400 3650 50  0001 C CNN
	1    1400 3650
	1    0    0    -1  
$EndComp
$Comp
L PSMN014-40YS Q1
U 1 1 59775678
P 7800 2000
F 0 "Q1" H 7830 2150 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 2000 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 2000 50  0001 L BNN
F 3 "Good" H 7800 2000 50  0001 L BNN
F 4 "None" H 7800 2000 50  0001 L BNN "Package"
	1    7800 2000
	1    0    0    -1  
$EndComp
$Comp
L PSMN014-40YS Q2
U 1 1 59775732
P 7800 2400
F 0 "Q2" H 7830 2550 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 2400 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 2400 50  0001 L BNN
F 3 "Good" H 7800 2400 50  0001 L BNN
F 4 "None" H 7800 2400 50  0001 L BNN "Package"
	1    7800 2400
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 59775781
P 7450 1900
F 0 "R3" V 7530 1900 50  0000 C CNN
F 1 "10" V 7450 1900 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 1900 50  0001 C CNN
F 3 "" H 7450 1900 50  0001 C CNN
	1    7450 1900
	0    1    1    0   
$EndComp
Wire Wire Line
	1900 3350 2650 3350
Connection ~ 1900 3350
Wire Wire Line
	1150 3350 1600 3350
Connection ~ 1400 3350
Wire Wire Line
	1400 3650 1400 3550
Wire Wire Line
	7800 2200 7800 2000
Wire Wire Line
	7600 1900 7700 1900
$Comp
L R R4
U 1 1 59775844
P 7450 2300
F 0 "R4" V 7530 2300 50  0000 C CNN
F 1 "10" V 7450 2300 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 2300 50  0001 C CNN
F 3 "" H 7450 2300 50  0001 C CNN
	1    7450 2300
	0    1    1    0   
$EndComp
Wire Wire Line
	7600 2300 7700 2300
$Comp
L Earth #PWR04
U 1 1 59775888
P 7800 2500
F 0 "#PWR04" H 7800 2250 50  0001 C CNN
F 1 "Earth" H 7800 2350 50  0001 C CNN
F 2 "" H 7800 2500 50  0001 C CNN
F 3 "" H 7800 2500 50  0001 C CNN
	1    7800 2500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 2500 7800 2400
$Comp
L +12V #PWR05
U 1 1 597758C6
P 7800 1700
F 0 "#PWR05" H 7800 1550 50  0001 C CNN
F 1 "+12V" H 7800 1840 50  0000 C CNN
F 2 "" H 7800 1700 50  0001 C CNN
F 3 "" H 7800 1700 50  0001 C CNN
	1    7800 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 1700 7800 1800
$Comp
L C_Small C4
U 1 1 59775905
P 7200 1750
F 0 "C4" H 7210 1820 50  0000 L CNN
F 1 "1uF" H 7210 1670 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7200 1750 50  0001 C CNN
F 3 "" H 7200 1750 50  0001 C CNN
	1    7200 1750
	1    0    0    -1  
$EndComp
Text GLabel 6950 1600 0    60   Input ~ 0
BOOT1
Wire Wire Line
	6950 1600 7200 1600
Wire Wire Line
	7200 1600 7200 1650
Text GLabel 6950 1900 0    60   Input ~ 0
H1
Wire Wire Line
	6950 1900 7300 1900
Text GLabel 6950 2100 0    60   Input ~ 0
O1
Text GLabel 6950 2300 0    60   Input ~ 0
L1
Wire Wire Line
	6950 2100 7800 2100
Connection ~ 7800 2100
Wire Wire Line
	6950 2300 7300 2300
Text GLabel 5100 2150 2    60   Input ~ 0
L1
Text GLabel 5100 2300 2    60   Input ~ 0
BOOT1
Text GLabel 5100 2450 2    60   Input ~ 0
O1
Text GLabel 5100 2600 2    60   Input ~ 0
H1
Text GLabel 5100 2750 2    60   Input ~ 0
L2
Text GLabel 5100 2900 2    60   Input ~ 0
BOOT2
Text GLabel 5100 3050 2    60   Input ~ 0
O2
Text GLabel 5100 3200 2    60   Input ~ 0
H2
Text GLabel 5100 3350 2    60   Input ~ 0
L3
Text GLabel 5100 3500 2    60   Input ~ 0
BOOT3
Text GLabel 5100 3650 2    60   Input ~ 0
O3
Text GLabel 5100 3800 2    60   Input ~ 0
H3
Wire Wire Line
	7200 1850 7200 2100
Connection ~ 7200 2100
$Comp
L +12V #PWR06
U 1 1 597768BB
P 2050 2900
F 0 "#PWR06" H 2050 2750 50  0001 C CNN
F 1 "+12V" H 2050 3040 50  0000 C CNN
F 2 "" H 2050 2900 50  0001 C CNN
F 3 "" H 2050 2900 50  0001 C CNN
	1    2050 2900
	0    -1   -1   0   
$EndComp
Wire Wire Line
	2050 2900 2650 2900
Wire Wire Line
	2400 2900 2400 3200
$Comp
L Earth #PWR07
U 1 1 59776BCA
P 3650 1750
F 0 "#PWR07" H 3650 1500 50  0001 C CNN
F 1 "Earth" H 3650 1600 50  0001 C CNN
F 2 "" H 3650 1750 50  0001 C CNN
F 3 "" H 3650 1750 50  0001 C CNN
	1    3650 1750
	-1   0    0    1   
$EndComp
$Comp
L Earth #PWR08
U 1 1 59776BF2
P 4100 4200
F 0 "#PWR08" H 4100 3950 50  0001 C CNN
F 1 "Earth" H 4100 4050 50  0001 C CNN
F 2 "" H 4100 4200 50  0001 C CNN
F 3 "" H 4100 4200 50  0001 C CNN
	1    4100 4200
	1    0    0    -1  
$EndComp
Text GLabel 4400 1750 1    60   Input ~ 0
TX
Text GLabel 4250 1750 1    60   Input ~ 0
RX
$Comp
L +3.3V #PWR09
U 1 1 59777054
P 2650 3500
F 0 "#PWR09" H 2650 3350 50  0001 C CNN
F 1 "+3.3V" H 2650 3640 50  0000 C CNN
F 2 "" H 2650 3500 50  0001 C CNN
F 3 "" H 2650 3500 50  0001 C CNN
	1    2650 3500
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR010
U 1 1 5977764D
P 3300 6300
F 0 "#PWR010" H 3300 6150 50  0001 C CNN
F 1 "+3.3V" H 3300 6440 50  0000 C CNN
F 2 "" H 3300 6300 50  0001 C CNN
F 3 "" H 3300 6300 50  0001 C CNN
	1    3300 6300
	0    -1   -1   0   
$EndComp
$Comp
L Earth #PWR011
U 1 1 5977767B
P 3300 6150
F 0 "#PWR011" H 3300 5900 50  0001 C CNN
F 1 "Earth" H 3300 6000 50  0001 C CNN
F 2 "" H 3300 6150 50  0001 C CNN
F 3 "" H 3300 6150 50  0001 C CNN
	1    3300 6150
	0    1    1    0   
$EndComp
Text GLabel 5200 6150 2    60   Input ~ 0
CANH
Text GLabel 5200 6300 2    60   Input ~ 0
CANL
Text GLabel 1250 5950 2    60   Input ~ 0
CANH
$Comp
L CONN_01X02 J3
U 1 1 59777EAC
P 1050 6000
F 0 "J3" H 1050 6150 50  0000 C CNN
F 1 "CAN" V 1150 6000 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 1050 6000 50  0001 C CNN
F 3 "" H 1050 6000 50  0001 C CNN
	1    1050 6000
	-1   0    0    1   
$EndComp
Text GLabel 1250 6050 2    60   Input ~ 0
CANL
Text GLabel 3300 6450 0    60   Input ~ 0
RX
Text GLabel 3300 6000 0    60   Input ~ 0
TX
$Comp
L CONN_01X03 J2
U 1 1 5977A1A0
P 1000 4800
F 0 "J2" H 1000 5000 50  0000 C CNN
F 1 "SENSOR" V 1100 4800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 1000 4800 50  0001 C CNN
F 3 "" H 1000 4800 50  0001 C CNN
	1    1000 4800
	-1   0    0    1   
$EndComp
$Comp
L Earth #PWR012
U 1 1 5977A246
P 1200 4900
F 0 "#PWR012" H 1200 4650 50  0001 C CNN
F 1 "Earth" H 1200 4750 50  0001 C CNN
F 2 "" H 1200 4900 50  0001 C CNN
F 3 "" H 1200 4900 50  0001 C CNN
	1    1200 4900
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR013
U 1 1 5977A272
P 1200 4700
F 0 "#PWR013" H 1200 4550 50  0001 C CNN
F 1 "+3.3V" H 1200 4840 50  0000 C CNN
F 2 "" H 1200 4700 50  0001 C CNN
F 3 "" H 1200 4700 50  0001 C CNN
	1    1200 4700
	0    1    1    0   
$EndComp
Text GLabel 1200 4800 2    60   Input ~ 0
SENS
Text GLabel 2650 3650 0    60   Input ~ 0
SENS
$Comp
L Earth #PWR014
U 1 1 5977E3C4
P 1200 1750
F 0 "#PWR014" H 1200 1500 50  0001 C CNN
F 1 "Earth" H 1200 1600 50  0001 C CNN
F 2 "" H 1200 1750 50  0001 C CNN
F 3 "" H 1200 1750 50  0001 C CNN
	1    1200 1750
	0    -1   -1   0   
$EndComp
Text GLabel 1200 1850 2    60   Input ~ 0
SWDCLK
Text GLabel 1200 1950 2    60   Input ~ 0
SWDIO
Text GLabel 4550 1750 1    60   Input ~ 0
SWDCLK
Text GLabel 4700 1750 1    60   Input ~ 0
SWDIO
$Comp
L Earth #PWR015
U 1 1 5977FEFC
P 4400 6000
F 0 "#PWR015" H 4400 5750 50  0001 C CNN
F 1 "Earth" H 4400 5850 50  0001 C CNN
F 2 "" H 4400 6000 50  0001 C CNN
F 3 "" H 4400 6000 50  0001 C CNN
	1    4400 6000
	0    -1   -1   0   
$EndComp
$Comp
L CONN_01X04 J1
U 1 1 59780882
P 1000 1800
F 0 "J1" H 1000 2050 50  0000 C CNN
F 1 "SWD" V 1100 1800 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x04_Pitch2.54mm" H 1000 1800 50  0001 C CNN
F 3 "" H 1000 1800 50  0001 C CNN
	1    1000 1800
	-1   0    0    1   
$EndComp
Text GLabel 1200 1650 2    60   Input ~ 0
NRST
Text GLabel 2650 3050 0    60   Input ~ 0
NRST
Wire Wire Line
	2400 3200 2650 3200
Connection ~ 2400 2900
Connection ~ 2200 2900
$Comp
L Earth #PWR016
U 1 1 59781423
P 2200 3100
F 0 "#PWR016" H 2200 2850 50  0001 C CNN
F 1 "Earth" H 2200 2950 50  0001 C CNN
F 2 "" H 2200 3100 50  0001 C CNN
F 3 "" H 2200 3100 50  0001 C CNN
	1    2200 3100
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR017
U 1 1 59781569
P 3050 1750
F 0 "#PWR017" H 3050 1600 50  0001 C CNN
F 1 "+3.3V" H 3050 1890 50  0000 C CNN
F 2 "" H 3050 1750 50  0001 C CNN
F 3 "" H 3050 1750 50  0001 C CNN
	1    3050 1750
	1    0    0    -1  
$EndComp
$Comp
L C_Small C3
U 1 1 59781C6F
P 2650 4650
F 0 "C3" H 2660 4720 50  0000 L CNN
F 1 "1uF" H 2660 4570 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2650 4650 50  0001 C CNN
F 3 "" H 2650 4650 50  0001 C CNN
	1    2650 4650
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 59781CD6
P 2400 4650
F 0 "R2" V 2480 4650 50  0000 C CNN
F 1 "10K" V 2400 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 2330 4650 50  0001 C CNN
F 3 "" H 2400 4650 50  0001 C CNN
	1    2400 4650
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 59781D39
P 2400 4250
F 0 "R1" V 2480 4250 50  0000 C CNN
F 1 "47K" V 2400 4250 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 2330 4250 50  0001 C CNN
F 3 "" H 2400 4250 50  0001 C CNN
	1    2400 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 3800 2650 4550
Wire Wire Line
	2400 4400 2400 4500
Wire Wire Line
	2400 4450 2650 4450
Connection ~ 2650 4450
Connection ~ 2400 4450
$Comp
L Earth #PWR018
U 1 1 59781E47
P 2400 4800
F 0 "#PWR018" H 2400 4550 50  0001 C CNN
F 1 "Earth" H 2400 4650 50  0001 C CNN
F 2 "" H 2400 4800 50  0001 C CNN
F 3 "" H 2400 4800 50  0001 C CNN
	1    2400 4800
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR019
U 1 1 59781E8E
P 2650 4800
F 0 "#PWR019" H 2650 4550 50  0001 C CNN
F 1 "Earth" H 2650 4650 50  0001 C CNN
F 2 "" H 2650 4800 50  0001 C CNN
F 3 "" H 2650 4800 50  0001 C CNN
	1    2650 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	2650 4750 2650 4800
$Comp
L +12V #PWR020
U 1 1 597821F1
P 2400 4100
F 0 "#PWR020" H 2400 3950 50  0001 C CNN
F 1 "+12V" H 2400 4240 50  0000 C CNN
F 2 "" H 2400 4100 50  0001 C CNN
F 3 "" H 2400 4100 50  0001 C CNN
	1    2400 4100
	1    0    0    -1  
$EndComp
$Comp
L C_Small C2
U 1 1 59782767
P 2200 3000
F 0 "C2" H 2210 3070 50  0000 L CNN
F 1 "1uF" H 2210 2920 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2200 3000 50  0001 C CNN
F 3 "" H 2200 3000 50  0001 C CNN
	1    2200 3000
	1    0    0    -1  
$EndComp
$Comp
L PSMN014-40YS Q3
U 1 1 59785356
P 7800 3450
F 0 "Q3" H 7830 3600 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 3450 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 3450 50  0001 L BNN
F 3 "Good" H 7800 3450 50  0001 L BNN
F 4 "None" H 7800 3450 50  0001 L BNN "Package"
	1    7800 3450
	1    0    0    -1  
$EndComp
$Comp
L PSMN014-40YS Q4
U 1 1 5978535E
P 7800 3850
F 0 "Q4" H 7830 4000 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 3850 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 3850 50  0001 L BNN
F 3 "Good" H 7800 3850 50  0001 L BNN
F 4 "None" H 7800 3850 50  0001 L BNN "Package"
	1    7800 3850
	1    0    0    -1  
$EndComp
$Comp
L R R5
U 1 1 59785365
P 7450 3350
F 0 "R5" V 7530 3350 50  0000 C CNN
F 1 "10" V 7450 3350 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 3350 50  0001 C CNN
F 3 "" H 7450 3350 50  0001 C CNN
	1    7450 3350
	0    1    1    0   
$EndComp
Wire Wire Line
	7800 3650 7800 3450
Wire Wire Line
	7600 3350 7700 3350
$Comp
L R R6
U 1 1 5978536E
P 7450 3750
F 0 "R6" V 7530 3750 50  0000 C CNN
F 1 "10" V 7450 3750 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 3750 50  0001 C CNN
F 3 "" H 7450 3750 50  0001 C CNN
	1    7450 3750
	0    1    1    0   
$EndComp
Wire Wire Line
	7600 3750 7700 3750
$Comp
L Earth #PWR021
U 1 1 59785376
P 7800 3950
F 0 "#PWR021" H 7800 3700 50  0001 C CNN
F 1 "Earth" H 7800 3800 50  0001 C CNN
F 2 "" H 7800 3950 50  0001 C CNN
F 3 "" H 7800 3950 50  0001 C CNN
	1    7800 3950
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 3950 7800 3850
$Comp
L +12V #PWR022
U 1 1 5978537D
P 7800 3150
F 0 "#PWR022" H 7800 3000 50  0001 C CNN
F 1 "+12V" H 7800 3290 50  0000 C CNN
F 2 "" H 7800 3150 50  0001 C CNN
F 3 "" H 7800 3150 50  0001 C CNN
	1    7800 3150
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 3150 7800 3250
$Comp
L C_Small C5
U 1 1 59785384
P 7200 3200
F 0 "C5" H 7210 3270 50  0000 L CNN
F 1 "1uF" H 7210 3120 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7200 3200 50  0001 C CNN
F 3 "" H 7200 3200 50  0001 C CNN
	1    7200 3200
	1    0    0    -1  
$EndComp
Text GLabel 6950 3050 0    60   Input ~ 0
BOOT2
Wire Wire Line
	6950 3050 7200 3050
Wire Wire Line
	7200 3050 7200 3100
Text GLabel 6950 3350 0    60   Input ~ 0
H2
Wire Wire Line
	6950 3350 7300 3350
Text GLabel 6950 3550 0    60   Input ~ 0
O2
Text GLabel 6950 3750 0    60   Input ~ 0
L2
Wire Wire Line
	6950 3550 7800 3550
Connection ~ 7800 3550
Wire Wire Line
	6950 3750 7300 3750
Wire Wire Line
	7200 3300 7200 3550
Connection ~ 7200 3550
$Comp
L PSMN014-40YS Q5
U 1 1 597854E4
P 7800 4800
F 0 "Q5" H 7830 4950 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 4800 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 4800 50  0001 L BNN
F 3 "Good" H 7800 4800 50  0001 L BNN
F 4 "None" H 7800 4800 50  0001 L BNN "Package"
	1    7800 4800
	1    0    0    -1  
$EndComp
$Comp
L PSMN014-40YS Q6
U 1 1 597854EC
P 7800 5200
F 0 "Q6" H 7830 5350 50  0000 L BNN
F 1 "PSMN3R3-40YS" H 7800 5200 50  0001 L BNN
F 2 "Misha:LFPAK" H 7800 5200 50  0001 L BNN
F 3 "Good" H 7800 5200 50  0001 L BNN
F 4 "None" H 7800 5200 50  0001 L BNN "Package"
	1    7800 5200
	1    0    0    -1  
$EndComp
$Comp
L R R7
U 1 1 597854F3
P 7450 4700
F 0 "R7" V 7530 4700 50  0000 C CNN
F 1 "10" V 7450 4700 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 4700 50  0001 C CNN
F 3 "" H 7450 4700 50  0001 C CNN
	1    7450 4700
	0    1    1    0   
$EndComp
Wire Wire Line
	7800 5000 7800 4800
Wire Wire Line
	7600 4700 7700 4700
$Comp
L R R8
U 1 1 597854FC
P 7450 5100
F 0 "R8" V 7530 5100 50  0000 C CNN
F 1 "10" V 7450 5100 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 7380 5100 50  0001 C CNN
F 3 "" H 7450 5100 50  0001 C CNN
	1    7450 5100
	0    1    1    0   
$EndComp
Wire Wire Line
	7600 5100 7700 5100
$Comp
L Earth #PWR023
U 1 1 59785504
P 7800 5300
F 0 "#PWR023" H 7800 5050 50  0001 C CNN
F 1 "Earth" H 7800 5150 50  0001 C CNN
F 2 "" H 7800 5300 50  0001 C CNN
F 3 "" H 7800 5300 50  0001 C CNN
	1    7800 5300
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 5300 7800 5200
$Comp
L +12V #PWR024
U 1 1 5978550B
P 7800 4500
F 0 "#PWR024" H 7800 4350 50  0001 C CNN
F 1 "+12V" H 7800 4640 50  0000 C CNN
F 2 "" H 7800 4500 50  0001 C CNN
F 3 "" H 7800 4500 50  0001 C CNN
	1    7800 4500
	1    0    0    -1  
$EndComp
Wire Wire Line
	7800 4500 7800 4600
$Comp
L C_Small C6
U 1 1 59785512
P 7200 4550
F 0 "C6" H 7210 4620 50  0000 L CNN
F 1 "1uF" H 7210 4470 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 7200 4550 50  0001 C CNN
F 3 "" H 7200 4550 50  0001 C CNN
	1    7200 4550
	1    0    0    -1  
$EndComp
Text GLabel 6950 4400 0    60   Input ~ 0
BOOT3
Wire Wire Line
	6950 4400 7200 4400
Wire Wire Line
	7200 4400 7200 4450
Text GLabel 6950 4700 0    60   Input ~ 0
H3
Wire Wire Line
	6950 4700 7300 4700
Text GLabel 6950 4900 0    60   Input ~ 0
O3
Text GLabel 6950 5100 0    60   Input ~ 0
L3
Wire Wire Line
	6950 4900 7800 4900
Connection ~ 7800 4900
Wire Wire Line
	6950 5100 7300 5100
Wire Wire Line
	7200 4650 7200 4900
Connection ~ 7200 4900
$Comp
L LED D2
U 1 1 5978721B
P 3050 4350
F 0 "D2" H 3050 4450 50  0000 C CNN
F 1 "LED" H 3050 4250 50  0000 C CNN
F 2 "LEDs:LED_0805" H 3050 4350 50  0001 C CNN
F 3 "" H 3050 4350 50  0001 C CNN
	1    3050 4350
	0    -1   -1   0   
$EndComp
$Comp
L R R9
U 1 1 5978734F
P 3050 4650
F 0 "R9" V 3130 4650 50  0000 C CNN
F 1 "120" V 3050 4650 50  0000 C CNN
F 2 "Resistors_SMD:R_0805" V 2980 4650 50  0001 C CNN
F 3 "" H 3050 4650 50  0001 C CNN
	1    3050 4650
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR025
U 1 1 597873D4
P 3050 4800
F 0 "#PWR025" H 3050 4550 50  0001 C CNN
F 1 "Earth" H 3050 4650 50  0001 C CNN
F 2 "" H 3050 4800 50  0001 C CNN
F 3 "" H 3050 4800 50  0001 C CNN
	1    3050 4800
	1    0    0    -1  
$EndComp
NoConn ~ 3200 4200
NoConn ~ 3350 4200
NoConn ~ 3500 4200
NoConn ~ 3650 4200
NoConn ~ 3800 4200
NoConn ~ 3950 4200
NoConn ~ 3200 1750
NoConn ~ 3350 1750
NoConn ~ 3500 1750
NoConn ~ 3800 1750
NoConn ~ 3950 1750
NoConn ~ 4100 1750
NoConn ~ 2650 2150
NoConn ~ 2650 2300
NoConn ~ 2650 2450
NoConn ~ 2650 2600
NoConn ~ 2650 2750
NoConn ~ 4400 6450
NoConn ~ 4250 4200
NoConn ~ 4400 4200
NoConn ~ 4550 4200
NoConn ~ 4700 4200
$Comp
L R R10
U 1 1 5979C6A0
P 4850 6200
F 0 "R10" V 4930 6200 50  0000 C CNN
F 1 "120" V 4850 6200 50  0000 C CNN
F 2 "Resistors_SMD:R_0805_HandSoldering" V 4780 6200 50  0001 C CNN
F 3 "" H 4850 6200 50  0001 C CNN
	1    4850 6200
	1    0    0    -1  
$EndComp
Wire Wire Line
	4400 6150 4600 6150
Wire Wire Line
	4600 6150 4600 6050
Wire Wire Line
	4600 6050 5100 6050
Wire Wire Line
	5100 6050 5100 6150
Wire Wire Line
	5100 6150 5200 6150
Wire Wire Line
	5200 6300 5100 6300
Wire Wire Line
	5100 6300 5100 6350
Wire Wire Line
	5100 6350 4600 6350
Wire Wire Line
	4600 6350 4600 6300
Wire Wire Line
	4600 6300 4400 6300
Connection ~ 4850 6050
Connection ~ 4850 6350
$Comp
L C_Small C1
U 1 1 597BE295
P 1400 3450
F 0 "C1" H 1410 3520 50  0000 L CNN
F 1 "47uF" H 1410 3370 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 1400 3450 50  0001 C CNN
F 3 "" H 1400 3450 50  0001 C CNN
	1    1400 3450
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR026
U 1 1 597C6786
P 4000 2600
F 0 "#PWR026" H 4000 2350 50  0001 C CNN
F 1 "Earth" H 4000 2450 50  0001 C CNN
F 2 "" H 4000 2600 50  0001 C CNN
F 3 "" H 4000 2600 50  0001 C CNN
	1    4000 2600
	0    -1   -1   0   
$EndComp
$EndSCHEMATC