# Halo Clock Light

### " Levitating" wall mounted ring light which can function as a clock.

<img src="static/images/image1.jpg" style="width: 49%; height: 600px; object-fit: cover; object-position: 0 35%;">
<img src="static/images/image2.jpg" style="width: 49%; height: 600px; object-fit: cover; object-position: 0 50%;">


---
## Parts list

Total price: ~20€

- [3D printed parts](./exports/)
    - 12x frame pieces
    - 3x wall stud foots
- 5V 5A PSU (MeanWall RS-25-5 works well)
- Wemos D1 Mini
- 8mm rods
    - 3x 80-100mm rods.
- 24x M4 20mm flat head screws
- 24x M4 hexagonal nuts
- Addressable LED strip
    - 1x 233cm (corrosponds to 70 LEDs on a 30 LED/m strip)
    - 1x 213cm (corrosponds to 64 LEDs on a 30 LED/m strip)
- Wire
  - 50cm red wire
  - 50cm black wire
  - 50cm colored wire
  - 100-200cm dual core wire


---
## Assembly guide

### Tools
  - Screwdriver
  - Hot glue gun
  - Solder iron
  - Wire cupper / stripper
  - Angle grinder or hacksaw
  - 8mm drill and drilling machine

### Guide
1) Assembly the frame by screwing all sections together using the screws.
2) Remove the adhesive from the back of the strips, as it won't stick on the plastic for long.
3) Place each LED strips on the inside walls. Attach them using hot glue on the back.
   - Start both strips from the same place.
   - Make sure to place the LEDs flat/parallel to the wall.
4) Hot glue the Wemos D1 to the inside frame.
   - Don't forget to program the Wemos beforehand.
   - Make sure connections don't short with the LED strips.
5) Solder on wires for power and signals.
   - Complete the power loop by soldering wires from the end to the start of the LED strip.
   - Add cross wires on the opposite site to distribute power between the strips.
   - Solder wires to the Wemos D1 mini.
   - Solder thick wires to the LEDs strips.
6) Cut the rods into appropriate lengths.
   - Distance the frame about 7cm from the wall to get an even coverage inside the circle.
