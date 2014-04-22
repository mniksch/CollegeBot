// sensorBack: back plate to hold sensor to face

// Definitions (all lengths are in millimeters)
//locations of the two bolt centers on x-axis
xc=12.7;    // x-center (axis of symmetry)
b1=xc-9.45; // center of first bolt hole
b2=xc+9.45; // center of second bolt hole
bh=1.9;     // radius of 4-40 bolt hole
xheight=xc*2;  // height of object in x

//No modules are used--we're just defining a 3D shape
difference() { //union() with everything else subtracted

  union() {
    cube([xheight,6.4,11.98]);
    translate([xc-9/2,0,0]) cube([9,21,8.5]);
  }

  //These holes are subtracted from the union above
  translate([b1,3.175,0]) cylinder(r=bh, h=13, $fn=20);
  translate([b2,3.175,0]) cylinder(r=bh, h=13, $fn=20);
}
