
use <../parametricPulley_v3.scad>;


belt_pulley($fn=60);


module belt_pulley() {
    difference() {
        union() {
            !pulley_adjusted();
            linear_extrude(30) inside_bar_profile();
        }
        linear_extrude(40) circle(d=5);

        // encoder slots
        radius=16;
        n_slots=32;
        slot = [4, radius*sin(360/n_slots)*0.5];

        linear_extrude(40) difference() {
            circle( r=radius+(slot[0]/2) );
            circle( r=radius-(slot[0]/2) );
            for (a=[0:360/n_slots:360]) rotate([0,0,a]) translate([radius,0]) square([slot[0],slot[1]], center=true);
        }
    }
}


module inside_bar_profile() {
    a = 36;
    d = 24.8;
    difference() {
        circle(d=d);
        polygon([[0,0], [d*cos(a),d*sin(a)], [d*cos(a),-d*sin(a)]]);
    }
    circle(d=d/2);
    
    echo("lip to lip (packman mouth) dist:", d*sin(a));
}


module pulley_adjusted() {
    GT2_2mm_pulley_dia = tooth_spacing (1.5,0.254);
    translate ([0,0,-8]) intersection() {
        pulley("GT2 2mm" , GT2_2mm_pulley_dia , 2 , 0.3 );
        translate ([0,0,8]) linear_extrude(9.2) circle(d=GT2_2mm_pulley_dia*1.1);
    }
    linear_extrude(9.2) circle(d=10);
}