    
diameter=180;
outer_wall = 2;
top_wall = 1;
bottom_wall=2;

height=10;
extrusion_origin = [-18/2, -18/2];
extrusion_wall = 3;
center_hub_diameter=50;

switch_angle=90;
power_port_angle=-90;

inner_mounting_holes_d = 18;
outer_mounting_holes_d = diameter/2-6;
inner_mounting_holes = [for(a=[0:360/4:360]) [cos(a),sin(a)]*inner_mounting_holes_d];
outer_mounting_holes = [for(a=[0:360/8:360]) [cos(a+360/8/2),sin(a+360/8/2)]*outer_mounting_holes_d];    

sw_pcb_mounting_holes = [for(i=[1,-1]) for(ii=[1,-1]) [i*(40-4)/2, ii*(60-4)/2]];

base_top($fn=120);
*base_plate($fn=60);



module module_insert_profile() intersection() {
    difference() {
        polygon([[10, 0],[35, diameter/2],[-35,diameter/2],[-10, 0]]);
        circle(d=center_hub_diameter);
        for(pos=outer_mounting_holes) translate(pos) circle(d=16.4);
    }
    circle(d=diameter-2*outer_wall-0.4);
}


module base_plate() {
    translate([0,0,bottom_wall]) center_hub($fn=120);
    difference() {
        union() {
            linear_extrude(bottom_wall) circle(d=diameter-2*outer_wall-0.4);
            for (module_angle=[power_port_angle,switch_angle]) rotate([0,0,module_angle]) linear_extrude(height-top_wall) module_insert_profile();
        }
        
        // USB-C PCB cutout
        rotate([0,0,power_port_angle]) {
            translate([0,35,bottom_wall]) linear_extrude(height) square([60,40], true);
            translate([0, (diameter)/2-25/2-5, 2+3]) linear_extrude(height) square([40,25]+[0.4,0.4], true);
            translate([0, (diameter)/2-10/2-5+2, 2]) linear_extrude(10) square([10.4,12.4], true);
            translate([0, (diameter)/2-10/2-20+2, 2]) linear_extrude(10) square([40,14]+[0.4,0.4], true);
            translate([0, (diameter)/2-33, 2]) linear_extrude(height) square([34,10], true);
        }
        
        // Switch PCB cutout
        rotate([0,0,switch_angle]) translate([0,55.2]) {
            translate([0,0,bottom_wall+0.5]) linear_extrude(height) square([40,60]+[0.4,0.4], true);
            translate([0,0,1]) linear_extrude(height) square([40,60]-[3,3], true);
        }
        
        // Assembly screw holes 
        for(pos=outer_mounting_holes) translate(pos) cylinder(d1=3+2*cos(45)*2, d2=3.2, h=2);
    }
}

module base_top() {
    difference() {
        linear_extrude(height) circle(d=diameter);
        linear_extrude(height-top_wall) circle(d=diameter-2*outer_wall);
        translate(extrusion_origin) linear_extrude(height) offset(delta=extrusion_wall+0.2) extrusion_profile();
        rotate([0,0,switch_angle]) translate([0,diameter/2-14]) linear_extrude(height) switch_tap();
        translate([0,0,7/2]) rotate([-90,0,power_port_angle]) linear_extrude(diameter/2) square([13,7], true);
    }
    difference() {
        intersection() {
            for(pos=outer_mounting_holes) translate(concat(pos, bottom_wall+0.2)) linear_extrude(height-(bottom_wall+0.2)) circle(d=16);
            translate([0,0,outer_wall+0.2]) linear_extrude(height) circle(d=diameter);
        }
        for(pos=outer_mounting_holes) translate(pos) linear_extrude(height) circle(d=2.9);
    }
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
        
        for (a=[0:90:360]) translate([0, 0, (height-top_wall-bottom_wall)/2]) rotate([90,0,a+45]) linear_extrude(30) circle(d=3);
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


module switch_tap_profile() polygon([
    [cos(180+45)*5,-8],
    [cos(-45)*5,-8],
    [cos(-45), sin(-45)]*5,
    for (a=[-45:5:180+45]) [cos(a), sin(a)]*5
]);

