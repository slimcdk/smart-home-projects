EESchema Schematic File Version 4
EELAYER 30 0
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
L SHP_Deps:2061-602_998-404 J1
U 1 1 6044C53D
P 3200 3050
F 0 "J1" H 3728 2953 60  0000 L CNN
F 1 "2061-602_998-404" H 3728 2847 60  0000 L CNN
F 2 "SHP_Deps:2061-602_998-404" H 3600 2790 60  0001 C CNN
F 3 "" H 3200 3050 60  0000 C CNN
	1    3200 3050
	1    0    0    -1  
$EndComp
$Comp
L SHP_Deps:AS5601-ASOM U1
U 1 1 6044CE0A
P 2350 4100
F 0 "U1" H 2900 4365 50  0000 C CNN
F 1 "AS5601-ASOM" H 2900 4274 50  0000 C CNN
F 2 "SHP_Deps:Taos-AS5601-ASOM-0-0-0" H 2350 4500 50  0001 L CNN
F 3 "http://ams.com/documents/20143/36005/AS5601_DS000395_3-00.pdf" H 2350 4600 50  0001 L CNN
F 4 "IC" H 2350 4700 50  0001 L CNN "category"
F 5 "Sensors" H 2350 4800 50  0001 L CNN "device class L1"
F 6 "Magnetic Sensors" H 2350 4900 50  0001 L CNN "device class L2"
F 7 "unset" H 2350 5000 50  0001 L CNN "device class L3"
F 8 "ENCODER 12BIT PROGR A/B 8SOIC" H 2350 5100 50  0001 L CNN "digikey description"
F 9 "AS5601-ASOMCT-ND" H 2350 5200 50  0001 L CNN "digikey part number"
F 10 "1.75mm" H 2350 5300 50  0001 L CNN "height"
F 11 "SOIC127P600X175-8" H 2350 5400 50  0001 L CNN "ipc land pattern name"
F 12 "yes" H 2350 5500 50  0001 L CNN "lead free"
F 13 "d6d5ca165b48b34d" H 2350 5600 50  0001 L CNN "library id"
F 14 "Taos" H 2350 5700 50  0001 L CNN "manufacturer"
F 15 "Board Mount Hall Effect / Magnetic Sensors SOIC 8" H 2350 5800 50  0001 L CNN "mouser description"
F 16 "985-AS5601-ASOM" H 2350 5900 50  0001 L CNN "mouser part number"
F 17 "SOIC8" H 2350 6000 50  0001 L CNN "package"
F 18 "yes" H 2350 6100 50  0001 L CNN "rohs"
F 19 "Magnetic" H 2350 6200 50  0001 L CNN "sensing method"
F 20 "I2C,Quadrature,Incremental" H 2350 6300 50  0001 L CNN "sensor output"
F 21 "0.1mm" H 2350 6400 50  0001 L CNN "standoff height"
F 22 "+125°C" H 2350 6500 50  0001 L CNN "temperature range high"
F 23 "-40°C" H 2350 6600 50  0001 L CNN "temperature range low"
	1    2350 4100
	1    0    0    -1  
$EndComp
$Comp
L SHP_Deps:TTGO_ESP32 U2
U 1 1 6044D61A
P 7850 2700
F 0 "U2" H 8200 4737 60  0000 C CNN
F 1 "TTGO_ESP32" H 8200 4631 60  0000 C CNN
F 2 "SHP_Deps:TTGO_ESP32" H 7850 2700 60  0001 C CNN
F 3 "" H 7850 2700 60  0001 C CNN
	1    7850 2700
	1    0    0    -1  
$EndComp
$Comp
L SHP_Deps:TTGO_ESP32_TDISPLAY_V1.1 TTGO1
U 1 1 6044DD5C
P 6150 2450
F 0 "TTGO1" H 6500 3887 60  0000 C CNN
F 1 "TTGO_ESP32_TDISPLAY_V1.1" H 6500 3781 60  0000 C CNN
F 2 "SHP_Deps:TTGO_ESP32_TDisplay_v1.1" H 6150 2450 60  0001 C CNN
F 3 "" H 6150 2450 60  0001 C CNN
	1    6150 2450
	1    0    0    -1  
$EndComp
$Comp
L SHP_Deps:WS2812C-2020 LED1
U 1 1 6044E474
P 6000 4600
F 0 "LED1" H 6500 4865 50  0000 C CNN
F 1 "WS2812C-2020" H 6500 4774 50  0000 C CNN
F 2 "SHP_Deps:WS2812C2020" H 6850 4700 50  0001 L CNN
F 3 "http://www.world-semi.com/DownLoadFile/139" H 6850 4600 50  0001 L CNN
F 4 "Intelligent control LED integrated light source" H 6850 4500 50  0001 L CNN "Description"
F 5 "0.84" H 6850 4400 50  0001 L CNN "Height"
F 6 "Worldsemi" H 6850 4300 50  0001 L CNN "Manufacturer_Name"
F 7 "WS2812C-2020" H 6850 4200 50  0001 L CNN "Manufacturer_Part_Number"
	1    6000 4600
	1    0    0    -1  
$EndComp
$EndSCHEMATC
