// sensorFront: "Face" to hold sonar sensor "eyes"

// Definitions (all lengths are in millimeters)
bh = 1.9; // radius of 4-40 bolt hole
sh = 8.3;  // radius of sonar "eyes"
ehght = 19.6; // center of the "eye" on the x-axis
yc=0; // y-axis center of model (axis of symmetry)

// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module sensorFront() {

  difference() { //hull vs. everything else

    hull() {
    //"envelope" over these four shapes define the
    // outer boundary of the shape
      translate([ehght,yc+13.2]) circle(r=sh+3, $fn=60);
      translate([ehght,yc-13.2]) circle(r=sh+3, $fn=60);
      translate([3,yc+16.9]) circle(r=3, $fn=20);
      translate([3,yc-16.9]) circle(r=3, $fn=20);
    } 

    // everything below here is a "cutout" from the shape
    
    //holes for sonar eyes
    translate([ehght,yc+13.2]) circle(r=sh, $fn=60);
    translate([ehght,yc-13.2]) circle(r=sh, $fn=60);

    //two openings to accept tabs in sensorBase
    translate([3.15,yc+12.9]) square([6.2,4]);
    translate([3.15,yc-12.9-4]) square([6.2,4]);

    //holes for the bolts
    translate([6.2,yc+9.45]) circle(bh, $fn=20);
    translate([6.2,yc-9.45]) circle(bh, $fn=20);

    //clearance for popout (crystal) from sonar circuit
    translate([9.2,yc-11/2]) square([4.8,11]);

    //clearance for header pins from sonar circuit
    translate([37,yc]) circle(11, $fn=60);

  } //end of the difference() function
} //end of the module

//this line converts from a 2D to a 3D shape
linear_extrude(height=5.98) sensorFront();
