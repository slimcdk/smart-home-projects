module nema17 () {
    translate([0,0,-36]) difference() {
        union() {
            linear_extrude(34) offset(delta=4, chamfer=true) square([34,34], center=true);
            linear_extrude(34+2) circle(d=22);
            linear_extrude(34+2+18) circle(d=5);
        }
        for (a=[45:90:360-45]) rotate([0,0,a]) translate([44/2,0,34-10]) linear_extrude(10) circle(d=3);
    }
}



module nema17_face_profile() {
    difference() {
        offset(delta=4, chamfer=true) square([34,34], center=true);
        for (a=[45:90:360-45]) rotate([0,0,a]) translate([44/2,0,34-10]) linear_extrude(10) circle(d=3);
    }
}