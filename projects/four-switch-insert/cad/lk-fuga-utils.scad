
new_ihc_tanget($fn=60);

module smooth(r) offset(r=r) offset(r=-r) children();


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


module front_profile() smooth(2) square([45,45], true);


module front_profile_knobs() {
    front_profile();
    square([46.5,6], true);
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


module tanget_tap_profile(l=2.8) polygon([[0,0],[0,1],[1,2],[1,1],[l,1],[l,0]]);

module ihc_tangent_profile() {
    inner_curvature_radius = 30;
    outer_tanget_width = 17;
    tangent_height = 3.6;

    intersection() {
        translate([0,-inner_curvature_radius+tangent_height]) circle(r=inner_curvature_radius);
        translate([-outer_tanget_width/2,0]) square([outer_tanget_width, tangent_height]);
    }
}


module new_ihc_tanget() {
    tangent_length=44;
    tap_length=2.8;
    wall_thickness = 1;
    outer_tanget_width = 17;

    // Body
    difference() {
        translate([0,tangent_length/2]) rotate([90,0,0]) linear_extrude(tangent_length) ihc_tangent_profile();
        translate([0,tangent_length/2-wall_thickness]) rotate([90,0,0]) linear_extrude(tangent_length-2*wall_thickness) offset(delta=-wall_thickness) ihc_tangent_profile();
        linear_extrude(1) square([15,tangent_length-2*wall_thickness], true);
        linear_extrude(1) square([5,tangent_length], true);
        
        // Fillets
        linear_extrude(10) difference() {
            square([outer_tanget_width,tangent_length], true);
            smooth(r=2) square([outer_tanget_width,tangent_length], true);
        }
    }
    
    // Button stands (crosses)
    translate([0,0,1]) for (i=[1,-1]) translate([0, 27/2*i]) linear_extrude(2) {
        square([0.5, 3], true);
        square([3, 0.5], true);
    }
    
    // Taps
    translate([2.8/2+10.5/2,-tangent_length/2,-tap_length]) rotate([0,-90,0]) linear_extrude(2.8) tanget_tap_profile(tap_length);
    translate([2.8/2-10.5/2,-tangent_length/2,-tap_length]) rotate([0,-90,0]) linear_extrude(2.8) tanget_tap_profile(tap_length);
    translate([-2.8/2+10.5/2,tangent_length/2,-tap_length]) rotate([0,-90,180]) linear_extrude(2.8) tanget_tap_profile(tap_length);
    translate([-2.8/2-10.5/2,tangent_length/2,-tap_length]) rotate([0,-90,180]) linear_extrude(2.8) tanget_tap_profile(tap_length);
}



module slim_cover_bar() {
    
    tangent_length=44;
    tap_length=2.8;
    wall_thickness=1.4;
    
    // Body
    difference() {
        linear_extrude(3.2) square([10,tangent_length], true);
        linear_extrude(3.2-wall_thickness) square([10-2*wall_thickness,tangent_length-2*wall_thickness], true);
        linear_extrude(wall_thickness) square([5,tangent_length], true);
    }

    // Taps
    translate([10/2-wall_thickness, -tangent_length/2+2,-tap_length]) rotate([0,-90,180]) linear_extrude(wall_thickness) tanget_tap_profile(tap_length);
    translate([-10/2, -tangent_length/2+2,-tap_length]) rotate([0,-90,180]) linear_extrude(wall_thickness) tanget_tap_profile(tap_length);
    translate([-10/2+wall_thickness,  tangent_length/2-2,-tap_length]) rotate([0,-90,0]) linear_extrude(wall_thickness) tanget_tap_profile(tap_length);
    translate([10/2,  tangent_length/2-2,-tap_length]) rotate([0,-90,0]) linear_extrude(wall_thickness) tanget_tap_profile(tap_length);
}



