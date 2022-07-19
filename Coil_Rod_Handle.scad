include <BOSL2/std.scad>
include <knurledFinishLib.scad>

$fa = 0.1;      // Set these to 1 for faster preview.
$fs = 0.1;      // ----------------------------------

c_h = 56;       // Set the height
c_od = 16;      // Set the outer diameter
c_id = 3;       // Set the ID of the insert and the thickness
c_id_t = 0.1;  // Set the tolerance of the coil rod +/- here

r_c = 1.25;    // Rounding value for the curve may change with ID
t_h = 0.84;     // Depth of the font
t_s = 9;        // Size of font

k_cyl_hg=c_h;    // Knurled cylinder height
k_cyl_od=c_od;   // Knurled cylinder outer* diameter

knurl_wd=3;      // Knurl polyhedron width
knurl_hg=3;      // Knurl polyhedron height
knurl_dp=1;      // Knurl polyhedron depth

e_smooth=1.65;   // Cylinder ends smoothed height
s_smooth=50;     // [ 0% - 100% ] Knurled surface smoothing amount

module handle(){ // The main handle body
    difference(){
        knurled_cyl(k_cyl_hg, k_cyl_od, 
                    knurl_wd, knurl_hg, knurl_dp, 
                    e_smooth, s_smooth);
        translate([0,0,10.1])
        cylinder(h=50, d=c_id);
        up(c_h) rounding_hole_mask(r=c_id/2, rounding=r_c);
        translate([0,0,(t_h-0.05)])
        rotate([0,180,0])
        size_text();
    }
}

module size_text(){ // You may need to change the font set in this module

linear_extrude(t_h)
    text(text = str(c_id), size = t_s, halign = "center", valign = "center", font="SF Pro Display:style=Bold");
    
}

module fake_coil_rod(){ // A fake coil rod you can use to check sizing

cylinder(h=100, d=c_id);

}


handle();
