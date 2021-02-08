





translate([0,0,20-13/2]) water_bottle_mount($fn=60);
translate([-49.5,(36+4+4)/2,-30-13/2]) rotate([90,0,-90]) edge_mount();
translate([-80/2+3,0,-13/2]) weight_module($fn=30);



module edge_mount() {
    width = 36;
    walls=4;
    difference() {
        linear_extrude(walls+24) square([walls+width+walls, 30+13+walls]);
        linear_extrude(24) square([walls+width+walls, 30]);
        translate([(walls+width+walls)/2,30, -13.8]) rotate([0,90,90]) weight_module_cutout($fn=30);    
        translate([12, 11]) linear_extrude(walls+24+walls) circle(d=4, $fn=30);
        translate([walls+width+walls-12, 11]) linear_extrude(walls+24+walls) circle(d=4, $fn=30);
    }
    translate([walls+width/2,walls+30+0.5,28]) difference() {
        linear_extrude(6) square([walls+width+walls, 25], center=true);
        linear_extrude(3.5+0.2) square([walls+width+walls, 21], center=true);
    }
    
}



module water_bottle_mount() {
    led_cutout = true;
    to92_cutout = true;

    
    difference() {
        union() {
            rotate_extrude($fn=60) bottle_shell_profile($fn=60);
            rotate([180,0,0]) intersection() {
                linear_extrude((23)) circle(d=41+5.4, $fn=60);
                translate([-50/2,0,2]) rotate([0,90,0]) linear_extrude(50) circle(d=41+5.4+2, $fn=60);
            }
            //if(led_cutout) translate([-24,0,-5]) rotate([0,-2,0]) linear_extrude(36) circle(d=4);
        }
        translate([0,0,9]) tube_slot();
        translate([80/-2+3,0,-20]) weight_module_cutout($fn=30);
        translate([0,0,3]) rotate([180,0,0]) linear_extrude(8) intersection() {
            circle(d=41, $fn=60);
            polygon([[0,-5], [0,5],[45, 45], [45, -45]]);
        }
        
        
        // LED cutout
        if (led_cutout) {
            v1 = [47/2,28];
            v2 = [83/2,42/2+18];
            v3 = v1 + (v2-v1)/2;
            echo(v3);
            a = 90-atan2((v2-v1)[0], (v2-v1)[1]);
            translate([-v3[0],0,v3[1]]) rotate([180,a,0]) translate([0,0,-2.9]) linear_extrude(2) square([21,11], center=true);
            translate([-24,0,-8]) rotate([5,-2,0]) linear_extrude(45) circle(d=3);
        }
        
        
        // Dallas temperature cutout
        if (to92_cutout) {

        }
        

    }
}


module weight_module() {
    linear_extrude(13) square([80+1,13],center=true);
}

!weight_module_cutout();

module weight_module_cutout() {
    linear_extrude(13) square([80+1,13],center=true);
    translate([-81/2+34/2, 13/2+2/2]) linear_extrude(13) square([34,2],center=true);
    translate([-81/2+5, 13/2+2/2, 13/2]) rotate([0,-90,-68]) linear_extrude(30) circle(d=3);
    
    translate([80/2-5,0]) linear_extrude(16) circle(d=4.2);
    translate([80/2-5,0,16]) linear_extrude(40) circle(d=8);
    translate([80/2-20,0]) linear_extrude(16) circle(d=4.2);
    translate([80/2-20,0,16]) linear_extrude(40) circle(d=8);
    
    translate([-(80/2-5),0]) linear_extrude(17) circle(d=5.2);
    translate([-(80/2-5),0,17]) linear_extrude(40) circle(d=12);
    translate([-(80/2-20),0]) linear_extrude(17) circle(d=5.2);
    translate([-(80/2-20),0,17]) linear_extrude(40) circle(d=12);
}


module tube_slot(angle=27.5) {
    //rotate([90,0,0]) translate([0,0,-9/2])  linear_extrude(9) square([46.18,88.7]);
    translate([0,9/2]) rotate([90,0,0]) linear_extrude(9) square([82,100]);
    intersection() {
        translate([0,9/2,-50]) rotate([90,0,0]) linear_extrude(9) square([82,50]);
        rotate([0,90+angle,0]) linear_extrude(95) {
            circle(d=9);
            translate([-50,0]) square([50*2,9], center=true) ;
        }
    }
}



module bottle_shell_profile() {
    intersection() {
        square([83/2+3,60+3]);
        translate([0,3]) difference() {
            offset(delta=3) bottle_profile();
            bottle_profile();
        }
    }
}

module bottle_profile() polygon([[0,0],[41/2, 0],[47/2,28], [83/2, 42/2+18], [83/2,60], [0,60]]);
