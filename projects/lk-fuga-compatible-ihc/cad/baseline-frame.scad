

frame5050();

module frame5050() {
    
    wall_thickness=2;
    
    outside_side_length=50;
    outside_fillet_radius=5;
    outside_halfside_to_fillet = (outside_side_length/2)-outside_fillet_radius;
    outside_frame_pts = [
        for (a=[0:5:90])        [ outside_halfside_to_fillet+cos(a)*outside_fillet_radius,  outside_halfside_to_fillet+sin(a)*outside_fillet_radius],
        for (a=[-270:5:-180])   [-outside_halfside_to_fillet+cos(a)*outside_fillet_radius,  outside_halfside_to_fillet+sin(a)*outside_fillet_radius],
        for (a=[-180:5:-90])    [-outside_halfside_to_fillet+cos(a)*outside_fillet_radius, -outside_halfside_to_fillet+sin(a)*outside_fillet_radius],
        for (a=[-90:5:0])       [ outside_halfside_to_fillet+cos(a)*outside_fillet_radius, -outside_halfside_to_fillet+sin(a)*outside_fillet_radius],
    ];
    
    inside_fillet_radius=outside_fillet_radius-wall_thickness;
    inside_halfside_to_fillet = (outside_side_length/2)-inside_fillet_radius-wall_thickness;
    inside_frame1_pts = [
        for (a=[0:5:90])        [ inside_halfside_to_fillet+cos(a)*inside_fillet_radius,  inside_halfside_to_fillet+sin(a)*inside_fillet_radius],
        for (a=[-270:5:-180])   [-inside_halfside_to_fillet+cos(a)*inside_fillet_radius,  inside_halfside_to_fillet+sin(a)*inside_fillet_radius],
        for (a=[-180:5:-90])    [-inside_halfside_to_fillet+cos(a)*inside_fillet_radius, -inside_halfside_to_fillet+sin(a)*inside_fillet_radius],
        for (a=[-90:5:0])       [ inside_halfside_to_fillet+cos(a)*inside_fillet_radius, -inside_halfside_to_fillet+sin(a)*inside_fillet_radius],
    ]; 
    
    
    difference() {
        linear_extrude(8.6) polygon(outside_frame_pts);
        translate([0,0,1.5]) linear_extrude(8.6) polygon(inside_frame1_pts);
    }
}


