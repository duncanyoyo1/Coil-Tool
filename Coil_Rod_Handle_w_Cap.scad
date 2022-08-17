include <BOSL2/std.scad>
include <knurledFinishLib.scad>

$fa = 0.1;       // Set these to 1 for faster preview.
$fs = 0.1;       // ----------------------------------

c_h = 56;        // Set the height
c_od = 16;       // Set the outer diameter
c_id = 4;        // Set the ID of the insert and the thickness
c_id_t = 0.125;  // Set the tolerance of the coil rod +/- here
c_c_t = 0.05;    // Set the tolerance of the cap +/- here
c_t = 2.4;       //Set the cap thickness here

r_c = 1.25;      // Rounding value for the curve may change with c_id
t_h = 0.84;      // Depth of the font
t_s = 9;         // Size of font ( 6 for half values 9 for whole )

knurl_wd=3;      // Knurl polyhedron width
knurl_hg=3;      // Knurl polyhedron height
knurl_dp=1;      // Knurl polyhedron depth

e_smooth=4;      // Cylinder ends smoothed height
s_smooth=50;     // [ 0% - 100% ] Knurled surface smoothing amount

module handle(){
        
    difference(){
        knurled_cyl(c_h, c_od, 
                    knurl_wd, knurl_hg, knurl_dp, 
                    e_smooth, s_smooth);
        translate([0,0,15.1])
        cylinder(h=60, d=(c_id+c_id_t));
        rotate([0,180,0])
        up(0) rounding_cylinder_mask(d=(c_od), rounding=r_c);
        translate([0,0,(t_h-0.05)])
        rotate([0,180,0])
        size_text();
    }
        difference(){
        translate([0,0,c_h])
        cylinder(h=6, d=c_od-(knurl_dp/2));
        up(c_h+6) rounding_hole_mask(d=(c_id+c_id_t), rounding=r_c);
        translate([0,0,10.1])
        cylinder(h=60, d=(c_id+c_id_t));
        translate([0,0,(c_h)])
        wrap_cap_negative();
        }
        
}

module size_text(){

linear_extrude(t_h)
    text(text = str(c_id), size = t_s, halign = "center", valign = "center", font="SF Pro Display:style=Bold");
    
}

module wrap_cap(){
    difference(){
        cylinder(h=8.5, d=c_od-(knurl_dp/2));
        wrap_cap_notch();
        translate([0,0,-1.5])
        cylinder(h=6, d=(c_od-c_t)+c_c_t);
        translate([0,0,3.05])
        cylinder(h=6, d=8+c_c_t);
        translate([0,-5.5,7.5])
        cube([20,10,3], center=true);
        wrap_cap_wire_gutter();        
    }
    difference(){
        translate([0,8.5,5])
        linear_extrude(height = 3.5)
        trapezoid(h=18, w1=15.45, w2=8);
        translate([0,0,3.05])
        cylinder(h=6, d=8+c_c_t);
        translate([0,0,3.05])
        cylinder(h=10, d=8.05);
        wrap_cap_wire_gutter();
    }
}

module wrap_cap_negative(){
    difference(){
        cylinder(h=7.5, d=c_od-(knurl_dp/2)+0.05);
        translate([0,0,0])
        wrap_cap_notch();
        translate([0,0,-1.5])
        cylinder(h=6, d=(c_od-c_t)-c_c_t);
        translate([0,0,3.05])
        cylinder(h=6, d=7.95);
    }
}

module wrap_cap_wire_gutter(){

    translate([3.25,10,7.375])
    rotate([0,0,7])
    cube([2,22,2.75],center=true);
    translate([-3.25,10,7.375])
    rotate([0,0,-7])
    cube([2,22,2.75],center=true);
    translate([2.25,10,7.375])
    rotate([0,0,0])
    cube([2,22,2.75],center=true);
    translate([-2.25,10,7.375])
    rotate([0,0,0])
    cube([2,22,2.75],center=true);
    translate([3,10,7.375])
    rotate([0,0,5])
    cube([2,22,2.75],center=true);
    translate([-3,10,7.375])
    rotate([0,0,-5])
    cube([2,22,2.75],center=true);
}

module wrap_cap_notch(){

    difference(){
        translate([0,0,-0.05])
        cylinder(h=2, d=c_od+1.05);
        translate([0,(c_od-0.75)/2,2])
        cube([2,5,1],center=true);
        translate([0,(c_od-0.75)/2,1.5])
        rotate([0,45,0])
        cube([1.4125,5,1.4125], center=true);
   }
   
}

module fake_coil_rod(){

cylinder(h=100, d=c_id);

}

module slice(){

    difference(){
    handle();
    translate([0,0,(c_h/4)])
    cube([(c_od)+1,(c_od)+1,(c_h/1.5)], center=true);
    translate([0,0,(c_h)])
    cube([(c_od)+1,(c_od)+1,(c_h/1.5)], center=true);
    }

}

//handle();
//translate([0,0,c_h])
//wrap_cap();
slice();