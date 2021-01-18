    
diameter=180;
outer_wall = 2;
top_wall = 1;
bottom_wall=2;

height=12;
extrusion_origin = [-18/2, -18/2];
extrusion_wall = 3;

switch_angle=-45-90;
power_port_angle=-45;

inner_mounting_holes_d = 18;
outer_mounting_holes_d = diameter/2-6;
inner_mounting_holes = [for(a=[0:360/4:360]) [cos(a),sin(a)]*inner_mounting_holes_d];
outer_mounting_holes = [for(a=[0:360/8:360]) [cos(a+360/8/2),sin(a+360/8/2)]*outer_mounting_holes_d];    

sw_pcb_mounting_holes = [for(i=[1,-1]) for(ii=[1,-1]) [i*(40-4)/2, ii*(60-4)/2]];




!base_top($fn=120);
translate([0,0,bottom_wall]) center_hub($fn=120);
base_plate($fn=120);

rotate([0,0,switch_angle]) translate([0,0,2]) switch_pcb_holder($fn=120);
rotate([0,0,power_port_angle]) translate([0,0,2]) power_pcb_holder($fn=120);



module module_insert_profile() intersection() {
    difference() {
        polygon([[10, 0],[30, diameter/2],[-30,diameter/2],[-10, 0]]);
        circle(d=50.4);
        translate([0,25]) square([10,3], true);
        for(pos=outer_mounting_holes) translate(pos) circle(d=16.4);
    }
    circle(d=diameter-2*outer_wall-0.4);
}


module switch_pcb_holder() difference() {
    linear_extrude(height-bottom_wall-top_wall-0.2) module_insert_profile();
    linear_extrude(height) intersection() {
        offset(delta=-2.4) module_insert_profile();
        translate([0,55]) square([40,60]-[3,3], true);
    }
    translate([0,55,1+1]) linear_extrude(height) square([40,60]+[0.4,0.4], true);
    translate([0,55,1]) linear_extrude(height) square([40,60]-[3,3], true);
}


module power_pcb_holder() difference() {
    linear_extrude(height-bottom_wall-top_wall-0.2) module_insert_profile();
    translate([0,30,2]) linear_extrude(height) square([40,20], true);
    translate([0, (diameter)/2-29/2-2, 2-1.6]) linear_extrude(height) square([17.2,29]+[0.4,0.4], true);
    translate([0, (diameter)/2-40, 2]) linear_extrude(height) square([12,30], true);
}


module base_plate() difference() {
    linear_extrude(bottom_wall) circle(d=diameter-2*outer_wall-0.4);
    for(pos=concat(inner_mounting_holes,outer_mounting_holes)) translate(pos) cylinder(d1=3+2*cos(45)*2, d2=3, h=2);
}


module center_hub() {
    support_wall_height=20;
    difference() {
        union() {
            linear_extrude(height-top_wall-bottom_wall) circle(d=50);
            translate(extrusion_origin) linear_extrude(height-top_wall-bottom_wall+support_wall_height) offset(r=extrusion_wall) extrusion_profile();
            translate(concat(extrusion_origin, height-top_wall-bottom_wall+support_wall_height))  {
                h=2*extrusion_wall;
                translate([0,0]) rotate([90,0,180]) linear_extrude(18) triangle_profile(h=h, b=extrusion_wall);
                translate([18,0]) rotate([90,0,-90]) linear_extrude(18) triangle_profile(h=h, b=extrusion_wall);
                translate([18,5]) rotate([90,0,0]) linear_extrude(5) triangle_profile(h=h, b=extrusion_wall);
                translate([0,18]) rotate([90,0,90]) linear_extrude(5) triangle_profile(h=h, b=extrusion_wall);
                translate([5,5]) rotate_extrude(angle=90) translate([18-5,0]) triangle_profile(h=h, b=extrusion_wall);
                translate([0,0]) rotate([0,0,180]) rotate_extrude(angle=90) triangle_profile(h=h, b=extrusion_wall);
                translate([18,0]) rotate([0,0,-90]) rotate_extrude(angle=90) triangle_profile(h=h, b=extrusion_wall);
                translate([0,18]) rotate([0,0,90]) rotate_extrude(angle=90) triangle_profile(h=h, b=extrusion_wall);
            }
        }
        translate(concat(extrusion_origin,2)) linear_extrude(50) extrusion_profile();
        translate(concat(extrusion_origin,height-bottom_wall-top_wall)) linear_extrude(50) extrusion_opening();
        translate(extrusion_origin) linear_extrude(height-bottom_wall-1) {
            offset(delta=-2) extrusion_profile();
            rotate([0,0,-45]) translate([0,28]) square([10,25], true);
        }
        
        for (a=[0:90:360]) translate([0, 0, 2+(height-top_wall-bottom_wall)/2]) rotate([90,0,a+45]) linear_extrude(30) circle(d=3);
        for(pos=inner_mounting_holes) translate(pos) linear_extrude(height) circle(d=2.9);
    }
}

module base_top() {
    difference() {
        linear_extrude(height) circle(d=diameter);
        linear_extrude(height-top_wall) circle(d=diameter-2*outer_wall);
        translate(extrusion_origin) linear_extrude(height) offset(delta=extrusion_wall+0.2) extrusion_profile();
        rotate([0,0,switch_angle]) translate([0,diameter/2-14]) linear_extrude(height) switch_tap();
        translate([0,0,height/2+0.5]) rotate([-90,0,power_port_angle]) linear_extrude(diameter/2) square([10,height-top_wall-bottom_wall], true);
    }
    difference() {
        intersection() {
            for(pos=outer_mounting_holes) translate(pos) linear_extrude(height) circle(d=16);
            translate([0,0,outer_wall+0.2]) linear_extrude(height) circle(d=diameter);
        }
        for(pos=outer_mounting_holes) translate(pos) linear_extrude(height) circle(d=2.9);
    }
}


module extrusion_profile() polygon([[0,0],[18,0],[18,6.5],for (a=[0:5:90]) [5,5]+[cos(a), sin(a)]*(18-5),[6.5, 18],[0, 18]]);
module extrusion_opening() polygon([[10,10],[18*2,0],[0,18*2]]);
module triangle_profile(h, b) polygon([[0,0], [b,0], [0,h]]);

module switch_tap() intersection() {
    difference() {
        offset(delta=0.2) switch_tap_profile();
        switch_tap_profile();
    }
    square([15,15], true);
}


module switch_tap_profile() {
    d=5;
    tap_length=8;
    polygon([
        [cos(180+45)*(d),-tap_length],
        [cos(-45)*(d),-tap_length],
        [cos(-45)*(d), sin(-45)*(d)],
        for (a=[-45:5:180+45]) [cos(a)*(d), sin(a)*(d)]
    ]);
}

