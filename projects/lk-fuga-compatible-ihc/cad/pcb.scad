

*#color("white") baseline5050($fn=30);
difference() {
    union() {
        insert_body_shell($fn=30);
        insert_body_claw_guide_body($fn=30);
        rotate([0,0,180]) insert_body_claw_guide_body($fn=30);
    }
    insert_body_claw_guide_cutout($fn=30);
    rotate([0,0,180]) insert_body_claw_guide_cutout($fn=30);
}

translate([0,0,1.2]) !front_pcb($fn=30);
translate([0,0,-5]) {
    back_pcb($fn=30);
    translate([2,0]) rotate([180,0,90]) hilink();
}



module insert_body_claw_guide_body() {
    translate([38/2,0,1.2]) linear_extrude(4.4) circle(d=8);
    translate([38/2-2,0,-12.8]) linear_extrude(14) square([7,10], true);
}


module insert_body_claw_guide_cutout() {
    translate([38/2,0,1.2+2]) linear_extrude(4.4) circle(d=6);
    translate([38/2,0,-20]) linear_extrude(25) circle(d=3);
    translate([38/2,0,-20]) linear_extrude(20) square([7,6], true);
    translate([38/2,0,-20]) linear_extrude(7.2) square([7,10], true);
}

module insert_body_shell() {
    difference() {
        union() {
            translate([0,0,1.2]) linear_extrude(4.4) front_profile();
            translate([0,0,-20]) linear_extrude(21.2) back_profile();
        }
        translate([0,0,2]) linear_extrude(10) smooth(1) square([45-2,45-2], true);
        translate([0,0,-30]) linear_extrude(40) offset(r=-1) back_profile();   
    }
}


module front_pcb() color("green") linear_extrude(1.6) difference () {
    smooth(r=1) square([42.8,42.8], true);
    for (d=[1,-1]) translate([d*(45/2-7/2),0]) {
        circle(d=8.2);
        translate([d*3,0]) square([6,8.2], true);
    }  
    
    // button pin holes
    for(d=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([d[0]*16,d[1]*45/3.5]) tactile_sw_holes($fn=30);
}

module back_pcb() color("green") linear_extrude(1.6) difference() {
    offset(r=-1.2) back_profile();
    for (d=[1,-1]) translate([d*(45/2-10/2),0]) square([8.2,10.2], true);
}



module front_profile() {
    union() {
        smooth(2) square([45,45], true);
        square([46.5,6], true);
        *square([6,46.5], true);
    }
}

module back_profile()  {
    large_radius=50.5/2;
    small_radius=43/2;
    radius_delta=large_radius-small_radius;
    difference() {
        polygon([
            for(a=[0:5:360]) [
                (large_radius+(sin((a-45)*2)*radius_delta))*cos(a), 
                (large_radius+(cos(a*2)*radius_delta))*sin(a)
            ]
        ]);
    }
}

module bridge_pcb() color("green") linear_extrude(1.6) square([10,20+4]);
module hilink() linear_extrude(15) square([35, 21], true);
module tactile_sw_holes() for(d=[[1,1], [1,-1], [-1,-1], [-1,1]]) translate([d[0]*5/2,d[1]*6/2]) circle(d=1);


module smooth(r=3) offset(r=r) offset(r=-r) children();
module fillet(r=3) offset(r=-r) offset(r=r) children();




module baseline5050() difference() {
    linear_extrude(9) smooth(5) square([50,50], true);
    translate([0,0,1.2]) linear_extrude(9) smooth(2.5) square([45.5,45.5], true);
    linear_extrude(6) square([46.5,6], true);
    linear_extrude(6) square([6,46.5], true);
    
    large_radius=51/2;
    small_radius=44/2;
    radius_delta=large_radius-small_radius;
    linear_extrude(9)  difference() {
        polygon([
            for(a=[0:5:360]) [
                (large_radius+(sin((a-45)*2)*radius_delta))*cos(a), 
                (large_radius+(cos(a*2)*radius_delta))*sin(a)
            ]
        ]);
    }
    
}
