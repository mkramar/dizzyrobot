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
L TLE5012B U1
U 1 1 59CE2BA3
P 4800 3700
F 0 "U1" H 4900 3650 60  0000 C CNN
F 1 "TLE5012B" H 4900 4350 60  0000 C CNN
F 2 "Housings_SOIC:SOIC-8_3.9x4.9mm_Pitch1.27mm" H 4800 3700 60  0001 C CNN
F 3 "" H 4800 3700 60  0001 C CNN
	1    4800 3700
	1    0    0    -1  
$EndComp
$Comp
L C_Small C1
U 1 1 59CE2C26
P 5600 3400
F 0 "C1" H 5610 3470 50  0000 L CNN
F 1 "1uF" H 5610 3320 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5600 3400 50  0001 C CNN
F 3 "" H 5600 3400 50  0001 C CNN
	1    5600 3400
	1    0    0    -1  
$EndComp
$Comp
L CONN_01X06 J1
U 1 1 59CE2C77
P 3550 3400
F 0 "J1" H 3550 3750 50  0000 C CNN
F 1 "CONN_01X06" V 3650 3400 50  0000 C CNN
F 2 "Dizzy:SPI_CONN" H 3550 3400 50  0001 C CNN
F 3 "" H 3550 3400 50  0001 C CNN
	1    3550 3400
	-1   0    0    1   
$EndComp
$Comp
L +3.3V #PWR01
U 1 1 59CE2D09
P 3750 3650
F 0 "#PWR01" H 3750 3500 50  0001 C CNN
F 1 "+3.3V" H 3750 3790 50  0000 C CNN
F 2 "" H 3750 3650 50  0001 C CNN
F 3 "" H 3750 3650 50  0001 C CNN
	1    3750 3650
	0    1    1    0   
$EndComp
$Comp
L Earth #PWR02
U 1 1 59CE2D23
P 3750 3550
F 0 "#PWR02" H 3750 3300 50  0001 C CNN
F 1 "Earth" H 3750 3400 50  0001 C CNN
F 2 "" H 3750 3550 50  0001 C CNN
F 3 "" H 3750 3550 50  0001 C CNN
	1    3750 3550
	0    -1   -1   0   
$EndComp
Text GLabel 3750 3450 2    60   Input ~ 0
CS
Text GLabel 3750 3350 2    60   Input ~ 0
CSK
Text GLabel 3750 3250 2    60   Input ~ 0
MISO
Text GLabel 3750 3150 2    60   Input ~ 0
MOSI
$Comp
L Earth #PWR03
U 1 1 59CE2D8E
P 5850 3350
F 0 "#PWR03" H 5850 3100 50  0001 C CNN
F 1 "Earth" H 5850 3200 50  0001 C CNN
F 2 "" H 5850 3350 50  0001 C CNN
F 3 "" H 5850 3350 50  0001 C CNN
	1    5850 3350
	0    -1   -1   0   
$EndComp
$Comp
L +3.3V #PWR04
U 1 1 59CE2DA2
P 5900 3500
F 0 "#PWR04" H 5900 3350 50  0001 C CNN
F 1 "+3.3V" H 5900 3640 50  0000 C CNN
F 2 "" H 5900 3500 50  0001 C CNN
F 3 "" H 5900 3500 50  0001 C CNN
	1    5900 3500
	0    1    1    0   
$EndComp
Wire Wire Line
	5300 3350 5300 3300
Wire Wire Line
	5300 3300 5800 3300
Wire Wire Line
	5800 3300 5800 3350
Wire Wire Line
	5800 3350 5850 3350
Connection ~ 5600 3300
Wire Wire Line
	5300 3500 5900 3500
Connection ~ 5600 3500
NoConn ~ 5300 3200
NoConn ~ 4500 3200
NoConn ~ 5300 3650
Text GLabel 4500 3650 0    60   Input ~ 0
MOSI
Text GLabel 4500 3500 0    60   Input ~ 0
CS
Text GLabel 4500 3350 0    60   Input ~ 0
CSK
$EndSCHEMATC
