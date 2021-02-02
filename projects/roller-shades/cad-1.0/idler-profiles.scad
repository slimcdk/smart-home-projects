use <../../../utils/cad/draw-profiles.scad>;
use <settings.scad>;
use <common-profiles.scad>;
use <driver-profiles.scad>;



module cord_pulley_profile(debug=false) {
    
    maximum_radius = (roller(r())+0.3) - cord_balls(r())*4; // give three radii of clearance
    maximum_circumference = maximum_radius * 2 * PI;
    maximum_n_balls = floor(maximum_circumference / cord_balls(dist()));
    adjusted_circumference = maximum_n_balls * cord_balls(dist());
    adjusted_radius = adjusted_circumference / PI / 2 -  cord(r());
    
    difference() {
        circle(r=adjusted_radius-cord(r()));
        for (a=[0:360/maximum_n_balls:360]) {
            rotate([0,0,a]) translate([adjusted_radius,0]) circle(d=cord_balls(d()), $fn=30);
        }
    }
}

module idler_cord_cutout_profile(debug=false) {
    /** lines are drawn counter clockwise **/
    
    maximum_radius = (roller(r())+0.3) - cord_balls(r())*4; // give three radii of clearance
    maximum_circumference = maximum_radius * 2 * PI;
    maximum_n_balls = floor(maximum_circumference / cord_balls(dist()));
    adjusted_circumference = maximum_n_balls * cord_balls(dist());
    adjusted_radius = adjusted_circumference / PI / 2;
    radius_w_clearance = adjusted_radius + cord_balls(r()) - 0.2;
    
    resting_wall_orign_x = (bounding_box(x())/2-roller_center(x())/2);
    resting_wall_orign_y = (bounding_box(y())/2-roller_center(y())/2);
    
    path = [
        
        // circular cutout for gear
        [roller_center(x())+cos(180)*radius_w_clearance, roller_center(y())+sin(180)*radius_w_clearance],
        for (a=[180:10:360]) [
            roller_center(x())+cos(a)*radius_w_clearance, // x
            roller_center(y())+sin(a)*radius_w_clearance // y
        ],
        [roller_center(x())+cos(360)*radius_w_clearance, roller_center(y())+sin(360)*radius_w_clearance],
        /*
        for (a=[162:2:180]) [
            roller_center(x())+111+cos(a)*100, // x
            roller_center(y())+resting_wall_orign_y+sin(180+a)*100 // y
        ],*/

        [boom_center(x())-boom(r())-wall(x()), boom_center(y())],
        [motor_center(x())+nema(sl())/2-wall(x()), bounding_box(y())-cleat_screw_head(d())],
        [roller_center(x())+cos(180)*radius_w_clearance, bounding_box(y())-cleat_screw_head(d())],
        
    ];


    // draw profile
    draw(path, debug); 
}
