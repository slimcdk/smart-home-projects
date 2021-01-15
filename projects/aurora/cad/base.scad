
diameter=180;
height=12;
extrusion_origin = [-18/2, -18/2];
extrusion_wall = 3;

inner_mounting_holes_d = 18;
outer_mounting_holes_d = diameter/2-6;
inner_mounting_holes = [for(a=[0:360/4:360]) [cos(a),sin(a)]*inner_mounting_holes_d];
outer_mounting_holes = [for(a=[0:360/8:360]) [cos(a+360/8/2),sin(a+360/8/2)]*outer_mounting_holes_d];    

switch_angle=-45-180;
power_port_angle=-45;

translate([0,0,height]) base_top($fn=120);
!base_bottom($fn=120);

*rotate([0,0,switch_angle]) translate([0,55, 2+4]) diy_pcb();

module base_bottom() {
    difference() {
        union() {
            // Body
            difference() {
                linear_extrude(height) circle(d=diameter);
                translate([0,0,2]) linear_extrude(height) circle(d=diameter-4);
                rotate([0,0,power_port_angle]) translate([-9/2, diameter/2, 2+4]) rotate([90,0]) linear_extrude(10) square([9,4]);
            }
            
            // Center hub
            difference() {
                linear_extrude(height) circle(d=50);
                translate(concat(extrusion_origin,height-6)) linear_extrude(height) offset(r=0.1) extrusion_profile();
                translate(concat(extrusion_origin,2)) linear_extrude(height) {
                    offset(delta=-2) extrusion_profile();
                    rotate([0,0,-45]) translate([0,28]) square([10,25], true);
                }
            }
            
            // Outer mounting points
            intersection() {
                for(pos=outer_mounting_holes) translate(pos) linear_extrude(height) circle(d=16);
                linear_extrude(height) circle(d=diameter);
            }
        }
        
        // Mounting holes
        for(pos=concat(inner_mounting_holes,outer_mounting_holes)) translate(concat(pos,2)) linear_extrude(height) circle(d=2.9);
    }
    
    // Switch PCB mount
    rotate([0,0,switch_angle]) translate([0,55,2]) {
        rotate([0,90,90]) {
            translate([0,40/2,60/2-11]) linear_extrude(10) pcb_tap_stand(3);
            translate([0,40/2,-60/2+1]) linear_extrude(10) pcb_tap_stand(3);
        }
        rotate([0,90,-90]) {
            translate([0,40/2,60/2-11]) linear_extrude(10) pcb_tap_stand(3);
            translate([0,40/2,-60/2+1]) linear_extrude(10) pcb_tap_stand(3);
        }
    }

    // USB-c PCB mount
    rotate([0,0,power_port_angle]) translate([0,diameter/2-1,2]) {
        translate([-17/2,-10-3]) rotate([0,90,90]) linear_extrude(10) pcb_tap_stand(3);
        translate([17/2, -3]) rotate([0,90,-90]) linear_extrude(10) pcb_tap_stand(3);
        translate([10/2,-27]) rotate([0,90,180])  linear_extrude(10) pcb_tap_stand(3);
    }
    
    // Wemos D1 mount
    rotate([0,0,-10]) translate([38.5,0,2]) {
        translate([-26/2, -10/2]) rotate([0,90,90]) linear_extrude(10) pcb_tap_stand(3);
        translate([26/2, 10/2]) rotate([0,90,-90]) linear_extrude(10) pcb_tap_stand(3);
    }
}

module base_top() difference() {
    union() {
        // Body
        linear_extrude(2) circle(d=diameter);
        translate(extrusion_origin) linear_extrude(30) offset(r=extrusion_wall) extrusion_profile();
       
        // Top chamfer
        translate(concat(extrusion_origin, 30))  {
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
    // Mounting screw holes
    for(pos=concat(inner_mounting_holes,outer_mounting_holes)) translate(pos) cylinder(d1=3, d2=6, h=2);
    translate(concat(extrusion_origin,2)) linear_extrude(30+2*extrusion_wall) offset(delta=extrusion_wall) extrusion_opening();
    translate(extrusion_origin) linear_extrude(50) offset(r=0.1) extrusion_profile();
    rotate([0,0,switch_angle]) translate([0,diameter/2-14]) linear_extrude(2) switch_tap();
}

module extrusion_profile() polygon([[0,0],[18,0],[18,6.5],for (a=[0:5:90]) [5,5]+[cos(a), sin(a)]*(18-5),[6.5, 18],[0, 18]]);
module triangle_profile(h, b) polygon([[0,0], [b,0], [0,h]]);
module extrusion_opening() polygon([[10,10],[18*2,0],[0,18*2]]);

module switch_tap() {
    intersection() {
        difference() {
            offset(delta=0.2) switch_tap_profile();
            switch_tap_profile();
        }
        square([15,15], true);
    }
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

module pcb_tap_stand(h=3) translate([-h-1,-0.8]) polygon([
    [-1+0.4,1],
    [-1-0.4, 0],
    [-2, 0],
    [-4, 1],
    [-4, 2.6],
    [-1, 2.6],
    [1+h, 4],
    [1+h, 0],
    [1,0],
    [1,1],
]);

module diy_pcb() {
    pcb_mounting_holes = [for (hole=[[40,60]/2-[2,2], [40,-60]/2+[-2,2], [-40,-60]/2+[2,2], [-40,60]/2+[2,-2]]) hole];
    linear_extrude(1.6) difference() {
        square([40,60], true);
        for (hole=pcb_mounting_holes) translate(hole) circle(d=2);
    }
    #translate([0,60/2-8,1.6]) linear_extrude(4.4) circle(d=2);
}