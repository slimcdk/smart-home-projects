
baseline5050();


module smooth(r=3) offset(r=r) offset(r=-r) children();


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


module front_profile() {
    smooth(2) square([45,45], true);
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
