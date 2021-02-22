#include "Arduino.h"
#include <Wire.h>
#include <AS5600.h>

#define SYS_VOL 3.3


AMS_5600 ams5600;

int8_t prev_quad = 0;
int32_t revs = 0, initial_position = 0;


void setup()
{
    Serial.begin(9600);
    Wire.begin(5, 4);

    if (ams5600.detectMagnet()) initial_position = (uint32_t) ams5600.getRawAngle();  
}


void loop()
{
    if (ams5600.detectMagnet()) {
        uint32_t raw_angle = (uint32_t) ams5600.getRawAngle();

        // Compute quadratic position
        int8_t _quad = floor(raw_angle / (4096/4));
        if (_quad != prev_quad) {
            if (prev_quad == 3 && _quad == 0) revs++;
            if (prev_quad == 0 && _quad == 3) revs--;
        }
        prev_quad = _quad;

        int32_t pos = (4096 * revs + raw_angle) - initial_position;
        Serial.print(raw_angle * 0.087890625);
        Serial.print(" ");
        Serial.println(pos);

    }
}