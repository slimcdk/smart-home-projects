



*linear_extrude(1) inside_bar_profile();
#translate([0,0, -16+7]) pulley($fn=30);
#translate([0,0,-5-16+7]) bolt($fn=30);


adapter($fn=60);
translate([0,0,-16+7-5]) bearing_adapter(5, 10, 5.2, $fn=60);


module adapter() {
    difference() {
        union() {
            linear_extrude(1) circle(d=28);
            linear_extrude(30) inside_bar_profile();
        }
        
        translate([0,0, -16+7+16]) rotate([180,0,180-45]) pulley_tightner_access();
        translate([0,0,-5-16+7]) bolt();
    }

}

module pulley_tightner_access() {
    pulley();
    
    translate([0,0,3.2]) {
        rotate([90,0,0]) translate([0,0,3]) linear_extrude(20) circle(d=3);
        rotate([90,0,90]) translate([0,0,3]) linear_extrude(20) circle(d=3);
        
    }
    
}

module pulley() {
    linear_extrude(16) difference() {
        circle(d=16);
        circle(d=5);
    }
}


module bolt() {
    linear_extrude(40) circle(d=5.2);
    translate([0,0,40]) linear_extrude(4) circle(d=9.4, $fn=6);
}


module bearing_adapter(t, od, id) {
    linear_extrude(t) difference() {
        circle(d=od);
        circle(d=id);
    }
}

module inside_bar_profile() {
    a = 33;
    od = 24.6;
    id= 17.2;
    difference() {
        circle(d=od);
        polygon([[0,0], [od*cos(a),od*sin(a)], [od*cos(a),-od*sin(a)]]);
    }
    circle(d=id);
    
    echo("lip to lip (packman mouth) dist:", od*sin(a));
}