

use <settings.scad>;
use <../../../utils/cad/draw-profiles.scad>;
use <driver-profiles.scad>;


//roller_boom_cover_slot(true);
inside_bar_profile();
//#circle(d=bearing_19105(D()));


module roller_boom_cover_slot(debug=false) {
    /** lines are drawn clockwise **/

    width = 3;

    path = [
        /* cover slot */
        [boom_center(x())-width/2, roller_center(y())+cos(45)*roller(r())],
        [boom_center(x())-width/2, boom_center(y())-boom(r())+0.5],
        [boom_center(x())+width/2, boom_center(y())-boom(r())+0.5],
        [boom_center(x())+width/2, roller_center(y())+cos(45)*roller(r())],
        /* */
    ];

    // draw profile
    draw(path, debug); 
}


module roller_cutout(debug=false) {
    /** lines are drawn clockwise **/

    path = [
        /* roller cutout */
        for (a=[-180:5:180]) [
            roller_center(x()) + cos(180+a+pulley_cc(angle()))*(roller(r())+0.3), // x
            roller_center(y()) + sin(180+a+pulley_cc(angle()))*(roller(r())+0.3) // y
        ],
        /* */
    ];

    // draw profile
    draw(path, debug);
}



module inside_bar_profile(debug=false) {
    /** lines are drawn counter clockwise **/
    
    mouth_angle=65;
    
    start_angle = 0 + mouth_angle / 2;
    end_angle = 360 - mouth_angle / 2;
    
    echo("roller_bar(R())", roller_bar(R()));
    echo("roller_bar(r())", roller_bar(r()));
    
    path = [
        
        // outer perimeter
        [cos(start_angle)*roller_bar(R()), sin(start_angle)*roller_bar(R())],
        for (a=[start_angle:10:end_angle]) [
            cos(a)*roller_bar(R()), // x
            sin(a)*roller_bar(R()) // y
        ],
        [cos(end_angle)*roller_bar(R()), sin(end_angle)*roller_bar(R())],

        // inner perimeter
        [cos(end_angle)*roller_bar(r()), sin(end_angle)*roller_bar(r())],
        for (a=[end_angle:10:360+start_angle]) [
            cos(a)*roller_bar(r()), // x
            sin(a)*roller_bar(r()) // y
        ],
        [cos(start_angle)*roller_bar(r()), sin(start_angle)*roller_bar(r())],
    ];
       
     // draw profile
    draw(path, debug);
}


module housing_profile(debug=false) {
    
    flange_fillet_radius = 3;
    
    /** lines are drawn clockwise **/
    path = [
        [0,0],
    
        /* cleat screw cutout */
        [0, wall(y()) + cleat_screw_head(r())-cleat_screw_body(r())],
        [wall(x()), wall(y()) + cleat_screw_head(r())-cleat_screw_body(r())],
        [wall(x()), wall(y())],
        [wall(x())+cleat_screw_head(h()), wall(y())],
        [wall(x())+cleat_screw_head(h())-2+cos(0)*2, wall(y())+cleat_screw_head(d())-2+sin(0)*2],
        for (a=[0:20:90]) [
            wall(x())+cleat_screw_head(h())-2+cos(a)*2, // x
            wall(y())+cleat_screw_head(d())-2+sin(a)*2 // y
        ],
        [wall(x())+cleat_screw_head(h())-2+cos(90)*2, wall(y())+cleat_screw_head(d())-2+sin(90)*2],
        [0, wall(y()) + cleat_screw_head(r()) + cleat_screw_head(r())],
        /* */

        /* bottom flange */
        //[0, motor_center(y()) + nema(y())/2],
        [0, motor_center(y()) + nema(y())/2+cleat_screw_head(r())],
        [wall(x()), motor_center(y()) + nema(y())/2+cleat_screw_head(r())],        
        /**/

        /* slot for guiding curtain boom */
        for (a=[0:10:180]) [
            boom_center(x())+cos(180+a)*boom(r()), // x
            boom_center(y())+sin(180+a)*boom(r()) // y
        ],
        [boom_center(x())+boom(r()), motor_center(y())+nema(y())/2],
        /* */
        
        [bounding_box(x()), motor_center(y())+nema(y())/2],
        [bounding_box(x()), 0],
    ];

    // draw profile
    draw(path, debug); 
}



module magnet_circluar_array(debug=false) {
    for (a=[0:magnet_array(angle()):360]) rotate([0,0,a]) translate([magnet_array(r()),0]) magnet_profile(debug);
}




module magnet_profile(debug=false) {
    
    path = [
        for (a=[0:15:360]) [
            cos(a)*magnet(r()), // x
            sin(a)*magnet(r()) // y
        ]
    ];
    
    // draw profile
    draw(path, debug);
}



