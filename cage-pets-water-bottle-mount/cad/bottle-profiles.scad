

use <settings.scad>;
use <../../utils/cad/draw-profiles.scad>;

pipe_bottom_cutout_profile(true);


module bottle_cup_base(debug=false) {
    
    /** lines are drawn clockwise **/
    path = [
        [0,0],
        [bottle_cap(r()), 0],
        [bottle_cap(R())-(bottle_cap(R())-bottle_cap(r()))*2,  -bottle_cap(h())],
        [0,  -bottle_cap(h())],
    ];
    // draw profile
    draw(path, debug);
}


module bottle_cup_profile(debug=false) {
    intersection() {
        translate([0, wall(t())]) {
            offset(delta=wall(t())) bottle_profile(debug);
            offset(delta=wall(t())) bottle_cup_base(false);
        }
        translate([0,-bottle_cap(r())]) square([bottle(r())+wall(t()), wall(t())+bottle_cap(h())+bottle_cap_delta(z())+wall(h())+bottle_cap(r())]);
    }
}

module bottle_profile(debug=false) {

    /** lines are drawn clockwise **/
    path = [
        [0,0],
        [bottle_cap(r()), 0],
        [bottle_cap(R()),  bottle_cap(h())],
        [bottle(r()), bottle_cap(h())+ bottle_cap_delta(z())], 
        [bottle(r()), bottle_cap(h())+ bottle_cap_delta(z())+bottle(h())],
        [0, bottle_cap(h())+ bottle_cap_delta(z())+bottle(h())],
    ];
    // draw profile
    draw(path, debug); 
}


module pipe_bottom_cutout_profile(debug=false) {

    angle = 90;
    ledge_size = 5;

    /** lines are drawn clockwise **/
    path = [
        [cos(0-angle/2)*(bottle_cap(r())-ledge_size), sin(0-angle/2)*(bottle_cap(r())-ledge_size)],
        for (a=[0:5:angle]) [
            cos(a-angle/2)*bottle_cap(r()), // x
            sin(a-angle/2)*bottle_cap(r()) // y
        ],
        [cos(angle-angle/2)*(bottle_cap(r())-ledge_size), sin(angle-angle/2)*(bottle_cap(r())-ledge_size)],
        
        for (a=[angle:5:360]) [
            cos(a-angle/2)*(bottle_cap(r())-ledge_size), // x
            sin(a-angle/2)*(bottle_cap(r())-ledge_size) // y
        ],
    ];
    // draw profile
    draw(path, debug); 
}
