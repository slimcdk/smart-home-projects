



encoder_disk_diameter = 30;
encoder_eye_size = [3.2,1];
encoder_disk_thickness = 1;

bearing_inner_diameter=10;
bearing_inner_ring_diameter=12;
bearing_width = 5;



/** expose parameters **/
function encoder_disk_diameter() = encoder_disk_diameter;


/** compute metrics **/
function encoder_eye_pos () = [encoder_disk_diameter/2-encoder_eye_size[0]/2-1,0];


function bearing_resting_edge () = encoder_disk_thickness+0.2;
function bearing_core_width () = bearing_resting_edge () + bearing_width;


module encoder_disk() {
    linear_extrude(encoder_disk_thickness)  difference() {
        circle(d=encoder_disk_diameter);        
        for (a=[15:15:360]) rotate([0,0,a]) translate(encoder_eye_pos()) square(encoder_eye_size, center=true);
    }

    linear_extrude(bearing_resting_edge()) circle(d=bearing_inner_ring_diameter);
    linear_extrude(bearing_core_width()) circle(d=bearing_inner_diameter);
}




encoder_disk($fn=60);