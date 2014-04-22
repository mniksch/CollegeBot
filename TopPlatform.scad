// topPlatform: Top of robot to hold servo & switches

// Definitions (all lengths are in millimeters)
bh = 1.9; // radius of 4-40 bolt hole
bh_off = 3.2; //offset of 4-40 bolt holes center from edge
th=1.2; //radius of tap screw hole
th_off = 1.95; //offset of tap screw holes from edge
y_spk = 84.8; //center of the speaker on y-axis (1mm lower)

xmax=85.7;  //width of model
ymax=127;  //height of model
xc=xmax/2; // x-axis center of model (axis of symmetry)

// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module topPlatform(){
  difference(){ //a rectangle with a lot cut away
    square([xmax,ymax]); //the rectangle

    // everything below here is a "cutout" from the circle 

    //cutout for servo (that holds the "eyes")
    translate([36.5,ymax-12.1]) square([23.9,12.1]);
  
    //screw holes for servo
    for(x_loc=[36.5-th_off,36.5+23.9+th_off]) { //two holes
      translate([x_loc,ymax-12.1/2]) circle(th, $fn=20);
    }

    //cutout for on/off switch
    translate([xc-17/2,15.6]) square([17,11.4]);
    //screw holes for on/off switch
    for(x_loc=[xc-17/2-th_off,xc+17/2+th_off]) { //two holes
      translate([x_loc,15.6+11.4/2]) circle(th, $fn=20);
    }

    //bolt holes (total of 4)
    for(x_loc=[bh_off,xmax-bh_off]) {
      for(y_loc=[12.7,115.9]) {
        translate([x_loc,y_loc]) circle(bh, $fn=30);
      }
    }

    // two notches to make sure aligned with right sides
    translate([xmax-6.35,19.8]) square([6.35,6.1]);
    translate([0,0]) square([6.35,5.7]);

    // 
    translate([xc,36.3]) circle(6.3, $fn=30);

    //speaker grill
    translate([xc,y_spk]) circle(6.6, $fn=30);
    for(a=[0:7]) {
      translate([xc    + 19.1 * sin(a*45),
                 y_spk + 19.1 * cos(a*45)])
              circle(6.6,$fn=30);
    } //end of for loop
  } // end of "difference"
} //end of module

    grill_rad = ymax-y_spk-12.1-1;
// Assemble it all in 3D (top of the robot will be at z=0)
difference(){
    //this line converts from a 2D to 3D shape
    linear_extrude(height=5.98) topPlatform();
    //hollow cavity for speaker to go into
    translate([xc,y_spk,2.1]) cylinder(h=4.2,r=29,$fn=60);

    //extra and optional to reduce the length of solid infill
    difference() { //part 1: well around speaker grill
      translate([xc,y_spk,0])
           cylinder(h=0.3,r=grill_rad,$fn=30);
      translate([xc,y_spk,0])
           cylinder(h=0.3,r=grill_rad-1,$fn=30);
    }
    difference() { //part 2: rectangle around speaker circle
      translate([(xmax/2-grill_rad),15.6/2-0.5,0])
           cube([grill_rad*2,y_spk+grill_rad-15.6/2+0.5,0.3]);
      translate([(xmax/2-grill_rad+1),15.6/2+0.5,0])
           cube([grill_rad*2-2,y_spk+grill_rad-15.6/2-1.5,0.3]);
    }
    hull() { //part 3: stripe 1
      translate([((xmax/2-grill_rad+1)+(xc-17/2-th_off))/2,
                15.6/2,0])
           cylinder(h=0.3,r=0.5,$fn=4);
      translate([((xmax/2-grill_rad+1)+(xc-17/2-th_off))/2,
                15.6/2+55.5,0])
           cylinder(h=0.3,r=0.5,$fn=4);

    }
    hull() { //part 4: stripe 2
      translate([(xmax-((xmax/2-grill_rad+1)+(xc-17/2-th_off))/2),
                15.6/2,0])
           cylinder(h=0.3,r=0.5,$fn=4);
      translate([(xmax-((xmax/2-grill_rad+1)+(xc-17/2-th_off))/2),
                15.6/2+55.5,0])
           cylinder(h=0.3,r=0.5,$fn=4);

    }

}
