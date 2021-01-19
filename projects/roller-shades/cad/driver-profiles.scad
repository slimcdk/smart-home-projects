use <../../../utils/cad/draw-profiles.scad>;
use <settings.scad>;
use <common-profiles.scad>;

use <parametricPulley_v3.scad>;



driver_belt_cutout(true);



module driver_electronic_compartment(debug=false) {
       
    /** lines are drawn counter clockwise **/
    path = [
        [bounding_box(x()), wall(y())],
        [roller_center(x()), wall(y())],
        roller_center([x(), y()]),
        motor_center([x(), y()]) + [-nema(x())/2, -nema(y())/2],
        motor_center([x(), y()]) + [nema(x())/2, -nema(y())/2]
    ];
              
    difference() {
        draw(path, debug); 
        offset(1) driver_belt_cutout(false);
        offset(1) roller_cutout(false);
    }       
}


module driver_belt_cutout(debug=false) {
    
    /* common tangents */
    // Triangle ABC https://cp-algorithms.com/geometry/tangents-to-two-circles.html
    // Point A = 'motor center'.
    // B = 'roller center'.
    // C = Tanget point on circle with perimeter of 'motor pulley' and center as 'roller center'
   
    /** lines are drawn counter clockwise **/
    path = [
   
        /* roller cutout */
        [
            roller_center(x())-cos(50)*(roller_pulley(r())+belt_clearance(dist())), // x
            roller_center(y())+sin(50)*(roller_pulley(r())+belt_clearance(dist())) // y
        ],
        for (a=[-50:5:170]) [
            roller_center(x()) + cos(180+a)*(roller_pulley(r())+belt_clearance(dist())), // x
            roller_center(y()) + sin(180+a)*(roller_pulley(r())+belt_clearance(dist())) // y
        ],
        // arc end point for roller pulley cutout
        [
            roller_center(x())+cos(-10)*(roller_pulley(r())+belt_clearance(dist())), // x
            roller_center(y())+sin(-10)*(roller_pulley(r())+belt_clearance(dist())) // y
        ],
        /* */
        
        
        /* motor cutout */
        // arc start point for motor pulley cutout
        [
            motor_center(x())+cos(10)*(motor_pulley(r())+belt_clearance(dist())), // x
            motor_center(y())+sin(10)*(motor_pulley(r())+belt_clearance(dist())) // y
        ],
        for (a=[0:5:135]) [
            motor_center(x()) + cos(a)*(motor_pulley(r())+belt_clearance(dist())), // x
            motor_center(y()) + sin(a)*(motor_pulley(r())+belt_clearance(dist())) // y
        ],
        // arc end point for motor pulley cutout
        [
            motor_center(x())-cos(45)*(motor_pulley(r())+belt_clearance(dist())), // x
            motor_center(y())+sin(45)*(motor_pulley(r())+belt_clearance(dist())) // y
        ],
        /* */
    ];
        
    // draw profile
    draw(path, debug); 
}


module spring_tension_driver(wall, debug=false) {

    /** lines are drawn counter clockwise **/
    path = [
        [0,0],
        //[cos(0)*(spring_locked_position(R())+0.2+wall), sin(0)*(spring_locked_position(R())+0.2+wall)],
        for (a=[0:10:spring_locked_position(angle())]) [
            cos(a-spring_locked_position(angle())/2-180)*(spring_locked_position(R())+0.2+wall), // x
            sin(a-spring_locked_position(angle())/2-180)*(spring_locked_position(R())+0.2+wall) // y
        ],
        //[cos(spring_locked_position(angle()))*(spring_locked_position(R())+0.2+wall), sin(spring_locked_position(angle()))*(spring_locked_position(R())+0.2+wall)],
    ];
        
    // draw profile
    draw(path, debug); 
    
}

module spring_tension_driver_negative(wall, debug=false) {
    
    angle = spring_locked_position(angle()) + 10 * 2;
    
    /** lines are drawn counter clockwise **/
    path = [
        [0,0],
        //[cos(0)*(spring_locked_position(R())+0.2+wall), sin(0)*(spring_locked_position(R())+0.2+wall)],
        for (a=[angle:10:360]) [
            cos(a-angle/2-180)*(spring_locked_position(R())+0.2+wall), // x
            sin(a-angle/2-180)*(spring_locked_position(R())+0.2+wall) // y
        ],
        //[cos(spring_locked_position(angle()))*(spring_locked_position(R())+0.2+wall), sin(spring_locked_position(angle()))*(spring_locked_position(R())+0.2+wall)],
    ];
        
    // draw profile
    draw(path, debug); 
    
}



module driver_pully_profile() {
    projection() pulley("GT2 2mm", tooth_spacing(2,0.254), 0.764, 1.494 );
}
