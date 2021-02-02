

// LK FUGA INSIDE FRAME
squashed_circle_max_radius = 51/2;
squashed_circle_min_radius = 44/2;
squashed_circle_delta_radius = squashed_circle_max_radius - squashed_circle_min_radius;



function squashed_circle_max_radius($fn) = [for(a=[0:360/($fn?$fn:20):360]) [
    (squashed_circle_max_radius+(sin((a-45)*2)*squashed_circle_delta_radius))*cos(a),   // x
    (squashed_circle_max_radius+(cos(a*2)*squashed_circle_delta_radius))*sin(a)         // y
]];





// LK FUGA BASELINE FRAME




// LK FUGA IHC LOW VOLTAGE TANGENT
new_ihc_tangent_length = 44;
new_ihc_tangent_width = 17;
new_ihc_tangent_curvature_radius = 30;
new_ihc_tangent_corner_fillet_radius = 2;
new_ihc_tanget_button_tap_width = 0.6;
new_ihc_tanget_button_tap_length = 3;
new_ihc_tanget_button_tap_height = 1.9;


new_ihc_tanget_locktap_width = 3.65;
new_ihc_tanget_locktap_thickness = 0.85;
new_ihc_tanget_locktap_head_thickness = 1.7;
new_ihc_tanget_locktap_head_height = 1;
new_ihc_tanget_locktap_c2c_dist = 10.5;
new_ihc_tanget_end_opening_width = 5;
new_ihc_tanget_end_opening_height=1;

new_ihc_tanget_wall_thickness = 1;