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
LIBS:Sensor-cache
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
L CONN_01X06 J1
U 1 1 59CE2C77
P 2500 3400
F 0 "J1" H 2500 3750 50  0000 C CNN
F 1 "CONN_01X06" V 2600 3400 50  0000 C CNN
F 2 "Dizzy:SPI_cable" H 2500 3400 50  0001 C CNN
F 3 "" H 2500 3400 50  0001 C CNN
	1    2500 3400
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR01
U 1 1 59CE2D09
P 3600 3100
F 0 "#PWR01" H 3600 2950 50  0001 C CNN
F 1 "+3.3V" H 3600 3240 50  0000 C CNN
F 2 "" H 3600 3100 50  0001 C CNN
F 3 "" H 3600 3100 50  0001 C CNN
	1    3600 3100
	1    0    0    -1  
$EndComp
$Comp
L Earth #PWR02
U 1 1 59CE2D23
P 3600 3300
F 0 "#PWR02" H 3600 3050 50  0001 C CNN
F 1 "Earth" H 3600 3150 50  0001 C CNN
F 2 "" H 3600 3300 50  0001 C CNN
F 3 "" H 3600 3300 50  0001 C CNN
	1    3600 3300
	1    0    0    -1  
$EndComp
Text GLabel 2700 3350 2    60   Input ~ 0
CS
Text GLabel 2700 3450 2    60   Input ~ 0
CSK
Text GLabel 2700 3550 2    60   Input ~ 0
MISO
Text GLabel 2700 3650 2    60   Input ~ 0
MOSI
Text GLabel 4750 3450 0    60   Input ~ 0
MOSI
Text GLabel 4750 3600 0    60   Input ~ 0
CS
Text GLabel 5700 3450 2    60   Input ~ 0
CSK
$Comp
L MA700 U1
U 1 1 59CE37DE
P 5250 3800
F 0 "U1" H 5250 4750 60  0000 C CNN
F 1 "MA700" H 5200 3400 60  0000 C CNN
F 2 "Housings_DFN_QFN:QFN-16-1EP_3x3mm_Pitch0.5mm" H 5250 3800 60  0001 C CNN
F 3 "" H 5250 3800 60  0001 C CNN
	1    5250 3800
	1    0    0    -1  
$EndComp
$Comp
L +3.3V #PWR03
U 1 1 59CE388D
P 5700 3600
F 0 "#PWR03" H 5700 3450 50  0001 C CNN
F 1 "+3.3V" H 5700 3740 50  0000 C CNN
F 2 "" H 5700 3600 50  0001 C CNN
F 3 "" H 5700 3600 50  0001 C CNN
	1    5700 3600
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR04
U 1 1 59CE38A1
P 4750 4050
F 0 "#PWR04" H 4750 3800 50  0001 C CNN
F 1 "Earth" H 4750 3900 50  0001 C CNN
F 2 "" H 4750 4050 50  0001 C CNN
F 3 "" H 4750 4050 50  0001 C CNN
	1    4750 4050
	0    1    1    0   
$EndComp
Text GLabel 4750 3900 0    60   Input ~ 0
MISO
NoConn ~ 4750 3000
NoConn ~ 4750 3150
NoConn ~ 4750 3300
NoConn ~ 5700 3000
NoConn ~ 5700 3150
NoConn ~ 5700 3300
NoConn ~ 5700 3750
NoConn ~ 5700 3900
NoConn ~ 5700 4050
$Comp
L C_Small C1
U 1 1 59CE39D3
P 3600 3200
F 0 "C1" H 3610 3270 50  0000 L CNN
F 1 "1uF" H 3610 3120 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 3600 3200 50  0001 C CNN
F 3 "" H 3600 3200 50  0001 C CNN
	1    3600 3200
	1    0    0    -1  
$EndComp
Wire Wire Line
	3600 3300 3250 3300
Wire Wire Line
	3250 3300 3250 3250
Wire Wire Line
	3250 3250 2700 3250
Wire Wire Line
	2700 3150 3250 3150
Wire Wire Line
	3250 3150 3250 3100
Wire Wire Line
	3250 3100 3600 3100
Connection ~ 3600 3100
Connection ~ 3600 3300
NoConn ~ 4750 3750
$Comp
L Earth #PWR05
U 1 1 59CE3E26
P 5200 4300
F 0 "#PWR05" H 5200 4050 50  0001 C CNN
F 1 "Earth" H 5200 4150 50  0001 C CNN
F 2 "" H 5200 4300 50  0001 C CNN
F 3 "" H 5200 4300 50  0001 C CNN
	1    5200 4300
	1    0    0    -1  
$EndComp
$EndSCHEMATC
