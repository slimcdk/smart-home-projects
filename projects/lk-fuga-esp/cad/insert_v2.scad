
// Import libaries
use <lk-fuga-utils.scad>;
include <../../../utils/cad/NopSCADlib/lib.scad>;

tactile_sw_positions = [for(i=[1,-1]) for(ii=[1,-1]) [i*27/2, ii*13.7]];


assembly_screws

// Frame
*translate([0,0,-1.2]) baseline5050($fn=30);
%translate([0,-50/2+17/2+(50/2-44/2)-0.2,6]) rotate([0,0,90]) new_ihc_tanget($fn=60);
%translate([0,50/2-17/2-(50/2-44/2)+0.2,6]) rotate([0,0,90]) new_ihc_tanget($fn=60);
%translate([0,0,5.1]) rotate([0,0,90]) slim_cover_bar($fn=60);
*for (pos=tactile_sw_positions) translate(concat(pos, 2)) square_button(button_6mm);


tanget_offset = 27.4/2;

 
difference() {
    union() {
        linear_extrude(4.4) offset(delta=-0.4) front_profile_taps();
        linear_extrude(5.4) offset(delta=-0.4) front_profile();
    }
    
    for(i=[1,-1]) translate([0, i*tanget_offset, 0.8]) {
        for(ii=[1,-1]) {
            translate([47/2,ii*5.25,2]) linear_extrude(10) square([5.5,3], true);
            translate([46/2,ii*5.25,2]) linear_extrude(1.6) square([6.5,3], true);
        }
        for(ii=[1,-1]) {
            translate([-47/2,ii*5.25,2]) linear_extrude(10) square([5.5,3], true);
            translate([-46/2,ii*5.25,2]) linear_extrude(1.6) square([6.5,3], true);
        }
    }
    
    translate([0,0,1]) linear_extrude(5.4) square([34,40], true);
    linear_extrude(1) square([34,40]-[2, 2], true);
}


// PCB
translate([0,0,2-1]) linear_extrude(1) front_pcb_outline();



translate([0,0,-1]) polygon(squashed_circle_max_radius($fn=60));


/*
assembly_screw_pos = [for(i=[1,-1]) for(ii=[-1,1]) [i*17.5,ii*14]];
tactile_sw_positions = [for(i=[1,-1]) for(ii=[1,-1]) [i*27/2, ii*13.7]];
//tangent_hook_cutouts = [for(i=[1,-1]) for(ii=[1,-1]) [i, ii], [i, ii]];

// Frame
*color("gray") translate([0,0,-1.2]) baseline5050($fn=30);

// Panels
*color("gray") translate([0,50/2-17/2-(50/2-44/2)+0.2,5.6]) rotate([0,0,90]) new_ihc_tanget($fn=120);
*color("gray") translate([0,0,4.6]) rotate([0,0,90]) slim_cover_bar($fn=120);
*color("gray") translate([0,-50/2+17/2+(50/2-44/2)-0.2,6]) rotate([0,0,90]) new_ihc_tanget($fn=120);
*for (pos=tactile_sw_positions) translate(concat(pos, 0.6+1)) tactile_sw($fn=30);
*translate([0,-24/2+42/2,0.6+1]) rotate([0,0,0]) color("black") esp12e();

*translate([0,0,0.6]) color("green") front_pcb($fn=30);
*translate([0,0,-16]) color("green") back_pcb();
*translate([1,2.2,-15]) rotate([0,0,90]) hilink();

*insert_body_front_part($fn=30);
*insert_body_front_part_lid($fn=30);

// Claw screws
*translate([0,0,2]) rotate([180,0,0]) {
    translate([38/2,0]) claw_screw($fn=30);
    translate([-38/2,0]) claw_screw($fn=30);
}
*/

module front_pcb_outline() difference() {
    size=[34,40]-[0.4, 0.4];
    square(size, true);
    for(i=[1,-1]) translate([0,i*(size[1]-2)/2]) circle(d=5);
    for(i=[1,-1]) translate([i*38/2,0]) square([10,10], true);
}




module insert_body_front_part_lid() {
    translate([0,0,4.4]) difference() {
        linear_extrude(1) front_profile();
        for (pos=tactile_sw_positions) translate(pos) {
            linear_extrude(1)  circle(d=4);
            linear_extrude(0.4) square([8,8], true);
        }
        for(i=[1,-1]) for(ii=[1,-1]) linear_extrude(1) {
            translate([i*44/2,ii*(19.25-0.3)]) square([2,3.4], true);
            translate([i*44/2,ii*(8.15+0.3)]) square([2,3.4], true);
        }
        
        for(i=[1,-1]) translate([i*38/2,0]) linear_extrude(1) circle(d=6);
    }
}


module insert_body_front_part() {
    // Front parts
    difference() {
        union() {
            linear_extrude(4.4) front_profile_taps();
            linear_extrude(4.4) front_profile();
        }
        translate([0,0,0.6]) linear_extrude(7) offset(delta=0.4) front_pcb_profile();
        linear_extrude(1) square([28,38], true);
        
        for(i=[1,-1]) for(ii=[1,-1]) linear_extrude(5) {
            translate([i*42/2,ii*(19.25-0.3)]) square([3,3.4], true);
            translate([i*42/2,ii*(8.15+0.3)]) square([3,3.4], true);
        }
        
        // Claw guides
        for(i=[1,-1]) translate([i*38/2,0]) linear_extrude(1) circle(d=3);
        for(i=[1,-1]) translate([i*38/2,0, 1]) linear_extrude(5) circle(d=5.8);
    }

    // Back part    
    rotate([180,0,0]) difference() {
        linear_extrude(16) back_profile();
        linear_extrude(20) back_pcb_profile();
        translate([0,0, 14.9]) linear_extrude(1.2) offset(delta=-1) back_profile();
    }
    
    /*difference() {
        translate([0,0,1.2]) insert_body_blob($fn=30);

        // Front PCB
        translate([0,0,3]) linear_extrude(10) offset(r=0.2) front_pcb_profile($fn=30);
        translate([0,0,2]) linear_extrude(10) difference () {
            offset(r=-1) front_pcb_profile($fn=30);
            *for(p=assembly_screw_pos) translate(p) circle(d=6+1.8,$fn=30);
        }

      
        // Assembly screw holes
        *for(p=assembly_screw_pos) translate(concat(p, -25)) linear_extrude(35) circle(d=3,$fn=30);
        *for(p=assembly_screw_pos) translate(concat(p, 0.5)) cylinder(h=2, d1=3, d2=6);
        *for(p=assembly_screw_pos) translate(concat(p, 2.5)) linear_extrude(5) circle(d=6,$fn=30);
    }*/
}



//claw_cutout();

module claw_cutout() {
    for(i=[1,-1]) translate([i*38/2,0, 1]);// square([]);
}


module front_pcb() linear_extrude(1) front_pcb_profile();


module front_pcb_profile() difference() {
    square([34,42], true);
    for(i=[1,-1]) translate([i*38/2,0, 1]) circle(d=5.8+1.6*2);
}



module back_pcb_profile() {
    difference() {
        offset(delta=-1.2) back_profile();
        for (i=[1,-1]) translate([i*38/2,0]) square([10,10], true);
    }
}

module back_pcb(parts=false) linear_extrude(1) back_pcb_profile();


module hilink($fn=10) {
    linear_extrude(15) square([35, 21], true);
    ps = [[35/2-3,  5/2], [35/2-3,  -5/2], [-35/2+3,  15/2], [-35/2+3,  -15/2]];
    rotate([180,0,0]) for (p=ps) translate(p) linear_extrude(4) circle(d=1.4);
}
module tactile_sw_holes() for(d=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([d[0]*5/2,d[1]*6/2]) circle(d=1);

module claw_screw() {
    cylinder(h=1, d1=3, d2=5);
    translate([0,0,1]) cylinder(h=2, d1=5, d2=2);
    translate([0,0,3]) {
        linear_extrude(10-3) circle(d=2);
        linear_extrude(15/*21.5-3*/) circle(d=1.8);
    }
}

module terminal_blocks(n=1, $fn=10) {
    n=floor(n);
    translate([n*5,4]) rotate([90,0, -90]) linear_extrude(n*5) polygon([
        [0,0],[0, 6.5],[1.6, 10],[6.5, 10],[7.5, 6.5],[7.5, 0]
    ]);
    for (p=[0:n-1]) translate([2.5+p*5, 0, -4]) linear_extrude(4) circle(d=1.4);
}

module esp12e() {
    linear_extrude(0.6) square([16,24], true);
    translate([0,-24/2+15/2+1]) linear_extrude(3) square([12,15], true);
}

module tactile_sw(stud_height=1) {
    linear_extrude(3) square([6,6], true);
    linear_extrude(3+stud_height) circle(d=3);
    linear_extrude(0.4) tactile_sw_holes();
}
