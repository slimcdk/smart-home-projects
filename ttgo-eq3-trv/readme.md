# WiFi Controlled Thermostatic Radiator Valve


Price: ~18€

---
### Parts list
#### Assembly parts list
- Eqiva Bluetooth Smart Radiator Thermostat
    - 9.95€ [Amazon.de](https://www.amazon.de/-/en/gp/product/B076PNNTC9/ref=ppx_yo_dt_b_asin_image_o00_s00)
- TTGO T-Display CP2104
    - 5.92€ [Banggood](https://www.banggood.com/TTGO-T-Display-ESP32-CP2104-WiFi-bluetooth-Module-1_14-Inch-LCD-Development-Board-LILYGO-for-Arduino-products-that-work-with-official-Arduino-boards-p-1522925.html)
- DRV8833 motor driver (or similar 3V H-Bridge)
    - 7.10€ 10pcs [Banggood](https://www.banggood.com/10pcs-DC-Motor-Driver-Board-2-Way-DRV8833-Motor-Drive-Module-DC-3-10V-p-1619052.html)
- DS18B20 digital temperature sensor (preferable with presoldered extension wire)
    - 1.34€ [Banggood](https://www.banggood.com/2-Wires-Cables-Digital-Temperature-Sensor-Probe-DS18B20-Thermometer-Thermal-p-986819.html)
- 1 Ohm Resistor
- Zipties (Minimum 200mm)
- 3D Printed housing

#### Setup parts lists
- Assembled TRV
- USB adatper (no USB-C DP needed)
- USB-C cable


---
### Assembly guide
1. 3D print housing
2. Dissasembly eQ3 TRV
    2.1 Desolder motor wires
3. Solder parts onto TTGO T-Display
    3.1 Shunt resistor
    3.2 Motor driver
    3.3 Cut wire for DS18B20 to length and solder it
    3.4 Solder motor wires to driver
4. Remove adhesive behind display
5. Fit parts into 3d housing