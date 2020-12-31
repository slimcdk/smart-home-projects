EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr User 10630 7874
encoding utf-8
Sheet 1 1
Title "ESP-COVER"
Date "2020-06-23"
Rev "0.2"
Comp "slimc"
Comment1 "github.com/slimcdk/eq3-cover.git"
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Regulator_Linear:AMS1117-3.3 U1
U 1 1 5E2D9ADB
P 5600 1300
F 0 "U1" H 5600 1542 50  0000 C CNN
F 1 "AMS1117-3.3" H 5600 1451 50  0000 C CNN
F 2 "Package_TO_SOT_SMD:SOT-223-3_TabPin2" H 5600 1500 50  0001 C CNN
F 3 "http://www.advanced-monolithic.com/pdf/ds1117.pdf" H 5700 1050 50  0001 C CNN
F 4 "C369933" H 5600 1300 50  0001 C CNN "LCSC"
	1    5600 1300
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR09
U 1 1 5E2E5822
P 6100 1850
F 0 "#PWR09" H 6100 1600 50  0001 C CNN
F 1 "GND" H 6105 1677 50  0000 C CNN
F 2 "" H 6100 1850 50  0001 C CNN
F 3 "" H 6100 1850 50  0001 C CNN
	1    6100 1850
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C1
U 1 1 5E2E8695
P 5050 1550
F 0 "C1" H 5138 1596 50  0000 L CNN
F 1 "10µF" H 5138 1505 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 5050 1550 50  0001 C CNN
F 3 "~" H 5050 1550 50  0001 C CNN
	1    5050 1550
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C2
U 1 1 5E2E9AD6
P 6100 1550
F 0 "C2" H 6188 1596 50  0000 L CNN
F 1 "22µF" H 6188 1505 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 6100 1550 50  0001 C CNN
F 3 "~" H 6100 1550 50  0001 C CNN
	1    6100 1550
	1    0    0    -1  
$EndComp
Wire Wire Line
	5900 1300 6100 1300
Wire Wire Line
	6100 1300 6100 1450
$Comp
L power:GND #PWR05
U 1 1 5E2EDB4D
P 5600 1850
F 0 "#PWR05" H 5600 1600 50  0001 C CNN
F 1 "GND" H 5605 1677 50  0000 C CNN
F 2 "" H 5600 1850 50  0001 C CNN
F 3 "" H 5600 1850 50  0001 C CNN
	1    5600 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 1450 5050 1300
Wire Wire Line
	5050 1300 5300 1300
$Comp
L power:GND #PWR02
U 1 1 5E2F0333
P 5050 1850
F 0 "#PWR02" H 5050 1600 50  0001 C CNN
F 1 "GND" H 5055 1677 50  0000 C CNN
F 2 "" H 5050 1850 50  0001 C CNN
F 3 "" H 5050 1850 50  0001 C CNN
	1    5050 1850
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 1850 5050 1650
Wire Wire Line
	5600 1850 5600 1600
Wire Wire Line
	6100 1650 6100 1850
Wire Wire Line
	5050 1300 5050 1000
Connection ~ 5050 1300
$Comp
L power:+3V3 #PWR08
U 1 1 5E2F1D4E
P 6100 1000
F 0 "#PWR08" H 6100 850 50  0001 C CNN
F 1 "+3V3" H 6115 1173 50  0000 C CNN
F 2 "" H 6100 1000 50  0001 C CNN
F 3 "" H 6100 1000 50  0001 C CNN
	1    6100 1000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6100 1000 6100 1300
Connection ~ 6100 1300
Wire Wire Line
	9150 1900 9700 1900
Text Label 9700 1900 2    50   ~ 0
ESP_ADC
NoConn ~ 9150 2600
NoConn ~ 9150 2500
NoConn ~ 9150 2200
NoConn ~ 9150 2100
Wire Wire Line
	7400 1800 7950 1800
Wire Wire Line
	7400 1600 7950 1600
Text Label 7400 1600 0    50   ~ 0
ESP_IO1
Text Label 7400 1800 0    50   ~ 0
ESP_IO3
Wire Wire Line
	8550 3000 8550 3150
Connection ~ 8550 3000
Wire Wire Line
	9300 3000 8550 3000
Wire Wire Line
	9300 2900 9300 3000
Wire Wire Line
	8550 2800 8550 3000
Wire Wire Line
	9300 1200 9300 2700
Connection ~ 8550 1200
Wire Wire Line
	8550 1300 8550 1200
Wire Wire Line
	7400 1500 7950 1500
Text Label 7400 1500 0    50   ~ 0
ESP_IO0
Text Label 9700 1500 2    50   ~ 0
ESP_RST
Text Label 7400 2000 0    50   ~ 0
ESP_IO5
Text Label 7400 1900 0    50   ~ 0
ESP_IO4
$Comp
L Device:CP_Small C6
U 1 1 5E2E9D8C
P 9300 2800
F 0 "C6" H 9450 2800 50  0000 L CNN
F 1 "100nF" H 9450 2700 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 9300 2800 50  0001 C CNN
F 3 "~" H 9300 2800 50  0001 C CNN
	1    9300 2800
	-1   0    0    -1  
$EndComp
Wire Wire Line
	8550 1200 8550 1050
$Comp
L power:+3V3 #PWR021
U 1 1 5E2DC878
P 8550 1050
F 0 "#PWR021" H 8550 900 50  0001 C CNN
F 1 "+3V3" H 8565 1223 50  0000 C CNN
F 2 "" H 8550 1050 50  0001 C CNN
F 3 "" H 8550 1050 50  0001 C CNN
	1    8550 1050
	-1   0    0    -1  
$EndComp
$Comp
L power:GND #PWR022
U 1 1 5E2DBBB0
P 8550 3150
F 0 "#PWR022" H 8550 2900 50  0001 C CNN
F 1 "GND" H 8555 2977 50  0000 C CNN
F 2 "" H 8550 3150 50  0001 C CNN
F 3 "" H 8550 3150 50  0001 C CNN
	1    8550 3150
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9300 1200 8550 1200
Wire Wire Line
	7950 2200 7400 2200
Wire Wire Line
	7400 2300 7950 2300
Text Label 7400 2300 0    50   ~ 0
ESP_IO14
Text Label 7400 2200 0    50   ~ 0
ESP_IO13
Text Label 7400 2100 0    50   ~ 0
ESP_IO12
Wire Wire Line
	7400 2100 7950 2100
Text Notes 7950 1900 2    39   ~ 0
SDA
Text Notes 7950 2000 2    39   ~ 0
SCL
Text Label 7400 2400 0    50   ~ 0
ESP_IO15
$Comp
L Device:R_Small R9
U 1 1 5E7696C0
P 4000 5350
F 0 "R9" V 3950 5100 50  0000 L CNN
F 1 "10k" V 3950 5450 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 5350 50  0001 C CNN
F 3 "~" H 4000 5350 50  0001 C CNN
F 4 "C365360" H 4000 5350 50  0001 C CNN "LCSC"
	1    4000 5350
	0    1    1    0   
$EndComp
$Comp
L power:+3V3 #PWR023
U 1 1 5E76A72C
P 4400 5100
F 0 "#PWR023" H 4400 4950 50  0001 C CNN
F 1 "+3V3" H 4415 5273 50  0000 C CNN
F 2 "" H 4400 5100 50  0001 C CNN
F 3 "" H 4400 5100 50  0001 C CNN
	1    4400 5100
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4100 5350 4400 5350
Wire Wire Line
	4400 5350 4400 5100
Wire Wire Line
	3150 5350 3900 5350
Text Label 9700 1700 2    50   ~ 0
ESP_EN
Wire Wire Line
	9700 1500 9150 1500
Wire Wire Line
	9150 1700 9700 1700
Text Label 7400 1700 0    50   ~ 0
ESP_IO2
Wire Wire Line
	7400 1700 7950 1700
Wire Wire Line
	7400 1900 7950 1900
Wire Wire Line
	7950 2000 7400 2000
$Comp
L power:GND #PWR024
U 1 1 5E7DF4D0
P 4400 6950
F 0 "#PWR024" H 4400 6700 50  0001 C CNN
F 1 "GND" H 4405 6777 50  0000 C CNN
F 2 "" H 4400 6950 50  0001 C CNN
F 3 "" H 4400 6950 50  0001 C CNN
	1    4400 6950
	-1   0    0    -1  
$EndComp
Text Label 3150 6200 0    50   ~ 0
ESP_IO15
$Comp
L Device:R_Small R17
U 1 1 5E7E0E32
P 4000 6200
F 0 "R17" V 3950 5950 50  0000 L CNN
F 1 "10k" V 3950 6300 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 6200 50  0001 C CNN
F 3 "~" H 4000 6200 50  0001 C CNN
F 4 "C365360" H 4000 6200 50  0001 C CNN "LCSC"
	1    4000 6200
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 6200 3900 6200
Wire Wire Line
	4100 6200 4400 6200
Wire Wire Line
	7950 2400 7400 2400
$Comp
L Device:R_Small R14
U 1 1 5E800F9B
P 4000 5650
F 0 "R14" V 3950 5400 50  0000 L CNN
F 1 "10k" V 3950 5750 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 5650 50  0001 C CNN
F 3 "~" H 4000 5650 50  0001 C CNN
F 4 "C365360" H 4000 5650 50  0001 C CNN "LCSC"
	1    4000 5650
	0    1    1    0   
$EndComp
Text Label 3150 5650 0    50   ~ 0
ESP_IO0
Wire Wire Line
	3150 5650 3900 5650
Wire Wire Line
	4100 5650 4400 5650
Text Notes 3400 4900 0    50   ~ 0
PULL RESISTORS
Text Label 7400 2500 0    50   ~ 0
ESP_IO16
Wire Wire Line
	7400 2500 7950 2500
Text Label 9700 2300 2    50   ~ 0
ESP_IO9
Text Label 9700 2400 2    50   ~ 0
ESP_IO10
Wire Wire Line
	9150 2300 9700 2300
Wire Wire Line
	9700 2400 9150 2400
Connection ~ 4400 5350
$Comp
L RF_Module:ESP-12F U3
U 1 1 5EAA4FB8
P 8550 2100
F 0 "U3" H 9050 3100 50  0000 C CNN
F 1 "ESP-12F" H 9050 3000 50  0000 C CNN
F 2 "RF_Module:ESP-12E" H 8550 2100 50  0001 C CNN
F 3 "http://wiki.ai-thinker.com/_media/esp8266/esp8266_series_modules_user_manual_v1.1.pdf" H 8200 2200 50  0001 C CNN
F 4 "C82891" H 8550 2100 50  0001 C CNN "LCSC"
	1    8550 2100
	-1   0    0    -1  
$EndComp
Text Label 3150 5500 0    50   ~ 0
ESP_EN
$Comp
L Device:R_Small R10
U 1 1 5E7F657B
P 4000 5500
F 0 "R10" V 3950 5250 50  0000 L CNN
F 1 "10k" V 3950 5600 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 5500 50  0001 C CNN
F 3 "~" H 4000 5500 50  0001 C CNN
F 4 "C365360" H 4000 5500 50  0001 C CNN "LCSC"
	1    4000 5500
	0    1    1    0   
$EndComp
Wire Wire Line
	3900 5500 3150 5500
Wire Wire Line
	4100 5500 4400 5500
$Comp
L Driver_Motor:Pololu_Breakout_A4988 A?
U 1 1 5EF2AFB5
P 7850 4700
F 0 "A?" H 7250 5600 50  0000 C CNN
F 1 "Pololu_Breakout_A4988" H 6850 5450 50  0000 C CNN
F 2 "Module:Pololu_Breakout-16_15.2x20.3mm" H 8125 3950 50  0001 L CNN
F 3 "https://www.pololu.com/product/2980/pictures" H 7950 4400 50  0001 C CNN
	1    7850 4700
	-1   0    0    -1  
$EndComp
$Comp
L Switch:SW_DIP_x04 SW?
U 1 1 5EF2C8C6
P 2200 5950
F 0 "SW?" H 2200 6417 50  0000 C CNN
F 1 "SW_DIP_x04" H 2200 6326 50  0000 C CNN
F 2 "" H 2200 5950 50  0001 C CNN
F 3 "~" H 2200 5950 50  0001 C CNN
	1    2200 5950
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EF369AA
P 7750 5700
F 0 "#PWR?" H 7750 5450 50  0001 C CNN
F 1 "GND" H 7755 5527 50  0000 C CNN
F 2 "" H 7750 5700 50  0001 C CNN
F 3 "" H 7750 5700 50  0001 C CNN
	1    7750 5700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	7750 5700 7750 5600
Wire Wire Line
	7750 5600 7650 5600
Wire Wire Line
	7650 5600 7650 5500
Wire Wire Line
	7750 5600 7850 5600
Wire Wire Line
	7850 5600 7850 5500
Connection ~ 7750 5600
Wire Wire Line
	6950 4600 7350 4600
Wire Wire Line
	7350 4700 6950 4700
Wire Wire Line
	6950 4800 7350 4800
Wire Wire Line
	7350 4900 6950 4900
Wire Wire Line
	7650 4000 7650 3750
Wire Wire Line
	7850 3750 7850 4000
Wire Wire Line
	2700 5450 2700 5750
Wire Wire Line
	2700 6050 2500 6050
Wire Wire Line
	2500 5950 2700 5950
Connection ~ 2700 5950
Wire Wire Line
	2700 5950 2700 6050
Wire Wire Line
	2500 5850 2700 5850
Connection ~ 2700 5850
Wire Wire Line
	2700 5850 2700 5950
Wire Wire Line
	2500 5750 2700 5750
Connection ~ 2700 5750
Wire Wire Line
	2700 5750 2700 5850
Wire Wire Line
	4400 6200 4400 6350
Connection ~ 4400 5500
Wire Wire Line
	4400 5350 4400 5500
Wire Wire Line
	4400 5500 4400 5650
$Comp
L Switch:SW_Push SW?
U 1 1 5EF4DECC
P 2200 6500
F 0 "SW?" H 1950 6600 50  0000 C CNN
F 1 "SW_Push" H 2500 6600 50  0000 C CNN
F 2 "" H 2200 6700 50  0001 C CNN
F 3 "~" H 2200 6700 50  0001 C CNN
	1    2200 6500
	1    0    0    -1  
$EndComp
Text Label 1450 6500 0    50   ~ 0
ESP_IO0
Wire Wire Line
	1450 6500 2000 6500
$Comp
L power:GND #PWR?
U 1 1 5EF583AA
P 2700 6950
F 0 "#PWR?" H 2700 6700 50  0001 C CNN
F 1 "GND" H 2705 6777 50  0000 C CNN
F 2 "" H 2700 6950 50  0001 C CNN
F 3 "" H 2700 6950 50  0001 C CNN
	1    2700 6950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2400 6500 2700 6500
Wire Wire Line
	2700 6500 2700 6700
Text Notes 1650 5250 0    50   ~ 0
PROGRAMMING
$Comp
L Switch:SW_Push SW?
U 1 1 5EF7C903
P 2200 6700
F 0 "SW?" H 1950 6800 50  0000 C CNN
F 1 "SW_Push" H 2500 6800 50  0000 C CNN
F 2 "" H 2200 6900 50  0001 C CNN
F 3 "~" H 2200 6900 50  0001 C CNN
	1    2200 6700
	1    0    0    -1  
$EndComp
Text Label 1450 6700 0    50   ~ 0
ESP_RST
Wire Wire Line
	1450 6700 2000 6700
Wire Wire Line
	2400 6700 2700 6700
Connection ~ 2700 6700
Wire Wire Line
	2700 6700 2700 6950
Text Label 8850 4600 2    50   ~ 0
STEPPER_EN
Wire Wire Line
	8250 4600 8850 4600
Wire Wire Line
	1900 5950 1200 5950
Wire Wire Line
	1900 5850 1200 5850
Wire Wire Line
	1900 5750 1200 5750
Text Label 1200 5750 0    50   ~ 0
STEPPER_MS1
Text Label 1200 5850 0    50   ~ 0
STEPPER_MS2
Text Label 1200 5950 0    50   ~ 0
STEPPER_MS3
Text Label 3150 6350 0    50   ~ 0
STEPPER_MS1
Text Label 3150 6500 0    50   ~ 0
STEPPER_MS2
Text Label 3150 6650 0    50   ~ 0
STEPPER_MS3
$Comp
L Device:R_Small R?
U 1 1 5F016040
P 4000 6350
F 0 "R?" V 3950 6100 50  0000 L CNN
F 1 "10k" V 3950 6450 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 6350 50  0001 C CNN
F 3 "~" H 4000 6350 50  0001 C CNN
F 4 "C365360" H 4000 6350 50  0001 C CNN "LCSC"
	1    4000 6350
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F016377
P 4000 6500
F 0 "R?" V 3950 6250 50  0000 L CNN
F 1 "10k" V 3950 6600 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 6500 50  0001 C CNN
F 3 "~" H 4000 6500 50  0001 C CNN
F 4 "C365360" H 4000 6500 50  0001 C CNN "LCSC"
	1    4000 6500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small R?
U 1 1 5F01656C
P 4000 6650
F 0 "R?" V 3950 6400 50  0000 L CNN
F 1 "10k" V 3950 6750 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 6650 50  0001 C CNN
F 3 "~" H 4000 6650 50  0001 C CNN
F 4 "C365360" H 4000 6650 50  0001 C CNN "LCSC"
	1    4000 6650
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 6650 3900 6650
Wire Wire Line
	3150 6500 3900 6500
Wire Wire Line
	3150 6350 3900 6350
Wire Wire Line
	4100 6350 4400 6350
Connection ~ 4400 6350
Wire Wire Line
	4400 6350 4400 6500
Wire Wire Line
	4100 6500 4400 6500
Connection ~ 4400 6500
Wire Wire Line
	4400 6500 4400 6650
Wire Wire Line
	4100 6650 4400 6650
Connection ~ 4400 6650
$Comp
L power:+3V3 #PWR?
U 1 1 5F060122
P 2700 5450
F 0 "#PWR?" H 2700 5300 50  0001 C CNN
F 1 "+3V3" H 2715 5623 50  0000 C CNN
F 2 "" H 2700 5450 50  0001 C CNN
F 3 "" H 2700 5450 50  0001 C CNN
	1    2700 5450
	-1   0    0    -1  
$EndComp
$Comp
L power:+3V3 #PWR?
U 1 1 5F061CB7
P 7850 3750
F 0 "#PWR?" H 7850 3600 50  0001 C CNN
F 1 "+3V3" H 7865 3923 50  0000 C CNN
F 2 "" H 7850 3750 50  0001 C CNN
F 3 "" H 7850 3750 50  0001 C CNN
	1    7850 3750
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4400 6650 4400 6950
Wire Wire Line
	8250 4800 8850 4800
Wire Wire Line
	8250 4700 8850 4700
Wire Wire Line
	8850 4400 8250 4400
$Comp
L power:+3V3 #PWR?
U 1 1 5F07BB31
P 9650 4700
F 0 "#PWR?" H 9650 4550 50  0001 C CNN
F 1 "+3V3" H 9665 4873 50  0000 C CNN
F 2 "" H 9650 4700 50  0001 C CNN
F 3 "" H 9650 4700 50  0001 C CNN
	1    9650 4700
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9650 5000 9650 5100
Connection ~ 9650 5000
Wire Wire Line
	9650 5100 9650 5200
Connection ~ 9650 5100
Wire Wire Line
	9650 4700 9650 5000
Wire Wire Line
	9550 5000 9650 5000
Wire Wire Line
	9550 5100 9650 5100
Wire Wire Line
	9550 5200 9650 5200
Wire Wire Line
	8250 5200 8950 5200
Wire Wire Line
	8250 5100 8950 5100
Wire Wire Line
	8250 5000 8950 5000
$Comp
L Switch:SW_DIP_x03 SW?
U 1 1 5F06C08A
P 9250 5200
F 0 "SW?" H 9250 4850 50  0000 C CNN
F 1 "SW_DIP_x03" H 9250 5000 50  0000 C CNN
F 2 "" H 9250 5200 50  0001 C CNN
F 3 "~" H 9250 5200 50  0001 C CNN
	1    9250 5200
	1    0    0    -1  
$EndComp
Text Label 8850 5000 2    50   ~ 0
STEPPER_MS1
Text Label 8850 5100 2    50   ~ 0
STEPPER_MS2
Text Label 8850 5200 2    50   ~ 0
STEPPER_MS3
Text Label 3150 5350 0    50   ~ 0
ESP_RST
$Comp
L Connector:Conn_01x04_Male J?
U 1 1 5EF53FB6
P 6750 4700
F 0 "J?" H 6750 5050 50  0000 C CNN
F 1 "Conn_01x04_Male" H 6750 4950 50  0000 C CNN
F 2 "" H 6750 4700 50  0001 C CNN
F 3 "~" H 6750 4700 50  0001 C CNN
	1    6750 4700
	1    0    0    -1  
$EndComp
Text Label 8850 4300 2    50   ~ 0
STEPPER_RST
Wire Wire Line
	8250 4300 8850 4300
Text Label 1450 6800 0    50   ~ 0
STEPPER_RST
Wire Wire Line
	1450 6800 2000 6800
Wire Wire Line
	2000 6800 2000 6700
Connection ~ 2000 6700
$Comp
L Interface_USB:FUSB302BMPX U?
U 1 1 5F1034D9
P 3150 1500
F 0 "U?" H 2600 2100 50  0000 C CNN
F 1 "FUSB302BMPX" H 2600 1950 50  0000 C CNN
F 2 "Package_DFN_QFN:WQFN-14-1EP_2.5x2.5mm_P0.5mm_EP1.45x1.45mm" H 3150 1000 50  0001 C CNN
F 3 "http://www.onsemi.com/pub/Collateral/FUSB302B-D.PDF" H 3250 1100 50  0001 C CNN
	1    3150 1500
	-1   0    0    -1  
$EndComp
Wire Wire Line
	1900 1500 2450 1500
Wire Wire Line
	2650 1600 2600 1600
$Comp
L power:GND #PWR?
U 1 1 5F171EA6
P 3150 2900
F 0 "#PWR?" H 3150 2650 50  0001 C CNN
F 1 "GND" H 3155 2727 50  0000 C CNN
F 2 "" H 3150 2900 50  0001 C CNN
F 3 "" H 3150 2900 50  0001 C CNN
	1    3150 2900
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 2900 3150 2250
Wire Wire Line
	4400 1500 3650 1500
Wire Wire Line
	4400 1400 3650 1400
$Comp
L Device:R_Small R?
U 1 1 5F1A611C
P 4000 5800
F 0 "R?" V 3950 5550 50  0000 L CNN
F 1 "10k" V 3950 5900 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 5800 50  0001 C CNN
F 3 "~" H 4000 5800 50  0001 C CNN
F 4 "C365360" H 4000 5800 50  0001 C CNN "LCSC"
	1    4000 5800
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 5800 3900 5800
Wire Wire Line
	4100 5800 4400 5800
Wire Wire Line
	4400 5650 4400 5800
$Comp
L Device:R_Small R?
U 1 1 5F1AA3C3
P 4000 5950
F 0 "R?" V 3950 5700 50  0000 L CNN
F 1 "10k" V 3950 6050 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 4000 5950 50  0001 C CNN
F 3 "~" H 4000 5950 50  0001 C CNN
F 4 "C365360" H 4000 5950 50  0001 C CNN "LCSC"
	1    4000 5950
	0    1    1    0   
$EndComp
Wire Wire Line
	3150 5950 3900 5950
Wire Wire Line
	4100 5950 4400 5950
Wire Wire Line
	4400 5800 4400 5950
Connection ~ 4400 5650
Connection ~ 4400 5800
Text Label 4400 1500 2    50   ~ 0
ESP_IO5
Text Label 4400 1400 2    50   ~ 0
ESP_IO4
Text Label 3150 5950 0    50   ~ 0
ESP_IO5
Text Label 3150 5800 0    50   ~ 0
ESP_IO4
Text Label 8850 4700 2    50   ~ 0
ESP_IO13
Text Label 8850 4800 2    50   ~ 0
ESP_IO14
Text Label 8850 4400 2    50   ~ 0
ESP_IO12
$Comp
L Device:CP_Small C?
U 1 1 5F1FD746
P 2600 1950
F 0 "C?" H 2688 1996 50  0000 L CNN
F 1 "470pF" H 2688 1905 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2600 1950 50  0001 C CNN
F 3 "~" H 2600 1950 50  0001 C CNN
	1    2600 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:CP_Small C?
U 1 1 5F203AB3
P 2450 1950
F 0 "C?" H 2538 1996 50  0000 L CNN
F 1 "470pF" H 2538 1905 50  0000 L CNN
F 2 "Capacitor_SMD:C_1206_3216Metric" H 2450 1950 50  0001 C CNN
F 3 "~" H 2450 1950 50  0001 C CNN
	1    2450 1950
	-1   0    0    -1  
$EndComp
Wire Wire Line
	2600 1850 2600 1600
Connection ~ 2600 1600
Wire Wire Line
	2600 1600 1900 1600
Wire Wire Line
	2450 1850 2450 1500
Connection ~ 2450 1500
Wire Wire Line
	2450 1500 2650 1500
Wire Wire Line
	2600 2050 2600 2100
Wire Wire Line
	2600 2100 3150 2100
Connection ~ 3150 2100
Wire Wire Line
	3150 2100 3150 1900
Wire Wire Line
	2450 2050 2450 2250
Wire Wire Line
	2450 2250 3150 2250
Connection ~ 3150 2250
Wire Wire Line
	3150 2250 3150 2100
Wire Wire Line
	1900 1300 2450 1300
Wire Wire Line
	2450 1300 2450 1400
Wire Wire Line
	2450 1400 2650 1400
Wire Wire Line
	2450 1000 2450 1300
Connection ~ 2450 1300
Wire Wire Line
	4400 1600 3650 1600
$Comp
L power:VBUS #PWR?
U 1 1 5F286D24
P 2450 1000
F 0 "#PWR?" H 2450 850 50  0001 C CNN
F 1 "VBUS" H 2465 1173 50  0000 C CNN
F 2 "" H 2450 1000 50  0001 C CNN
F 3 "" H 2450 1000 50  0001 C CNN
	1    2450 1000
	1    0    0    -1  
$EndComp
$Comp
L Connector:USB_C_Receptacle J?
U 1 1 5F28D75D
P 1300 2300
F 0 "J?" H 1407 3567 50  0000 C CNN
F 1 "USB_C_Receptacle" H 1407 3476 50  0000 C CNN
F 2 "" H 1450 2300 50  0001 C CNN
F 3 "https://www.usb.org/sites/default/files/documents/usb_type-c.zip" H 1450 2300 50  0001 C CNN
	1    1300 2300
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR?
U 1 1 5F2B5329
P 5050 1000
F 0 "#PWR?" H 5050 850 50  0001 C CNN
F 1 "VBUS" H 5065 1173 50  0000 C CNN
F 2 "" H 5050 1000 50  0001 C CNN
F 3 "" H 5050 1000 50  0001 C CNN
	1    5050 1000
	1    0    0    -1  
$EndComp
$Comp
L power:VBUS #PWR?
U 1 1 5F2B5A7C
P 7650 3750
F 0 "#PWR?" H 7650 3600 50  0001 C CNN
F 1 "VBUS" H 7665 3923 50  0000 C CNN
F 2 "" H 7650 3750 50  0001 C CNN
F 3 "" H 7650 3750 50  0001 C CNN
	1    7650 3750
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5F2C3FB4
P 1300 4150
F 0 "#PWR?" H 1300 3900 50  0001 C CNN
F 1 "GND" H 1305 3977 50  0000 C CNN
F 2 "" H 1300 4150 50  0001 C CNN
F 3 "" H 1300 4150 50  0001 C CNN
	1    1300 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	1300 4150 1300 4000
Wire Wire Line
	1000 3900 1000 4000
Wire Wire Line
	1000 4000 1300 4000
Connection ~ 1300 4000
Wire Wire Line
	1300 4000 1300 3900
$EndSCHEMATC
