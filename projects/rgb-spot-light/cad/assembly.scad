
fn=100;


housing_base();
translate([0,0,30]) housing_front();



module housing_base() {
    d=120;
    difference() {
        union() {
            linear_extrude(30) difference() {
                circle(d=d, $fn=fn);
                circle(d=d-6, $fn=fn);
            }
            linear_extrude(3) circle(d=d-6, $fn=fn);
            for (a=[0:120:360]) rotate([0,0,a]) translate([d/2-3,0]) linear_extrude(30) circle(d=6, $fn=fn);
                
            color("green") translate([0,0,5]) !projection() pcb();
        }
        for (a=[0:120:360]) rotate([0,0,a]) translate([d/2-3,0]) linear_extrude(30) circle(d=3.4, $fn=fn);
    }
}


module housing_front() {
    
    
}


module pcb() {
    
    linear_extrude(1.8) difference() {
        circle(d=100, $fn=fn);    
        for (a=[0:60:360]) rotate([0,0,a]) translate([50-5,0]) circle(d=3.4, $fn=fn );
    }
}