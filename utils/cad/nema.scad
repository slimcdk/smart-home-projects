module nema17 () {
    rotate([180,0,0]) linear_extrude(39) nema17_face_profile();
    linear_extrude(2) circle(d=22);
    #translate([0,0,2]) linear_extrude(18) circle(d=5);
}



module nema17_face_profile() {
    difference() {
        offset(delta=4, chamfer=true) square([34,34], center=true);
        for (a=[45:90:360-45]) rotate([0,0,a]) translate([44/2,0,34-10]) linear_extrude(10) circle(d=3);
    }
}

nema17();