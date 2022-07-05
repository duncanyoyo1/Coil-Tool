include <BOSL2/std.scad>
include <knurledFinishLib.scad>

$fa = 0.1; // Set these to 1 for faster preview.
$fs = 0.1; // ----------------------------------

c_od = 16; // Set the outer diameter
c_h = 60;  // Set the height
c_id = 3;  // Set the ID of the insert and the thickness
r_c = 2;   // Rounding value for the curve may change with thickness
t_h = 3;   // Depth of the font
t_s = 8;   // Size of font

module handle(){
    
    k_cyl_hg=c_h;      // Knurled cylinder height
    k_cyl_od=c_od;   // Knurled cylinder outer* diameter

    knurl_wd=3;      // Knurl polyhedron width
    knurl_hg=3;      // Knurl polyhedron height
    knurl_dp=1;    // Knurl polyhedron depth

    e_smooth=1.65;      // Cylinder ends smoothed height
    s_smooth=50;      // [ 0% - 100% ] Knurled surface smoothing amount
    
    difference(){
        knurled_cyl(k_cyl_hg, k_cyl_od, 
                    knurl_wd, knurl_hg, knurl_dp, 
                    e_smooth, s_smooth);
        translate([0,0,10.1])
        cylinder(h=50, d=c_id);
        up(c_h) rounding_hole_mask(r=c_id/2, rounding=r_c);
        translate([0,0,2.5])
        rotate([0,180,0])
        size_text();
    }
}

module size_text(){

linear_extrude(t_h)
    text(text = str(c_id), size = t_s, halign = "center", valign = "center");
    
}

handle();
