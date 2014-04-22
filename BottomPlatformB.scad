// bottomPlatform: Bottom of robot to hold most parts

// Definitions (all lengths are in millimeters)
bh = 1.9; // radius of 4-40 bolt hole
bh_off = 3.2; //offset of 4-40 bolt holes center from edge
th=1.2; //radius of tap screw hole
th_off = 1.95; //offset of tap screw holes from edge
t_width = 3.5; //width of bolt hole for "t crosses"

xmax=85.7;  //width of model
ymax=165.1;  //height of model
xc=xmax/2; // x-axis center of model (axis of symmetry)

notch=6.3; // depth of cutout to accept vertical side pieces
lego=4.9; //diameter of lego nubs (was 5.0)

// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module tankBottomPlatform(){
  difference(){ // a rectangle with a lot cut away
    square([xmax,ymax]); //the rectangle

    //Now use a for loop to create two notches on each side
    //(these notches are to accept the verticle legs)
    for(x_jump=[0,xmax-notch]){ //create on both ends in x
  
      //first the actual cut-outs (two per side)
      translate([x_jump,0])    square([notch,38.7]);
      translate([x_jump,82.0]) square([notch,46.1]);
    }

    //second the "t cutouts", one for each notch
    //we know from the left/right side code that the
    //holes are centered 30.5 and 107.9 from the front
    //of that robot
    for (y_jump=[30.5,107.9]) {
      //left side: rotate t counter-clockwise 90
      translate([notch,y_jump-t_width/2])
                              rotate([0,0,90]) t_down();
      //right side: rotate t clockwise 90
      translate([xmax-notch,y_jump+t_width/2])
                              rotate([0,0,-90]) t_down();
    }


    //cutout just below the 9V to pass wires through platform
    minkowski(){
      translate([38,106]) square([9,4]);
      circle(1, $fn=20);
    }

    //two long cutouts that reduce print volume and pass wires
    minkowski(){
      translate([20,15]) square([10,80]);
      circle(1, $fn=20);
    }
    minkowski(){
      translate([xmax-20-10,15]) square([10,80]);
      circle(1, $fn=20);
    }

    //bolt holes to go down into the sides
    //(from those files we know they are 60.35 from the front
    translate([bh_off,60.35]) circle(bh, $fn=20);
    translate([xmax-bh_off,60.35]) circle(bh, $fn=20);

    //bolt holes for the gearmotors:
    for (x_jump=[6.4,33.3,52.4,79.4]) {
      translate([x_jump,145.4]) circle(bh, $fn=20);
    }

    //tap holes to hold 4xAA batteries to the bottom
    translate([xc,21.0]) circle(th, $fn=20);
    translate([xc,65.0]) circle(th, $fn=20);

    //tap holes to hold 9V battery to the top
    translate([29.4,115.4]) circle(th, $fn=20);
    translate([56.4,115.4]) circle(th, $fn=20);
    translate([xc,137.7]) circle(th, $fn=20);

  } //end of difference() function
} //end of module

difference() {
//We're just going to chop off everything we don't need
//Original union() is below and the ** shows where we start
//chopping


union(){ //we're going to add lego nubs to the main part
  difference(){ //we're going to subtract a layer to add lego
    linear_extrude(height=5.98) tankBottomPlatform();
    translate([0,ymax-16.5,4]) cube([86,16.5,4]);
  }//end difference
  for(z=[0:9]){ //10 lego bumps across
    for(y_jump=[4,12]){
    translate([6.9+z*8,ymax-y_jump,3.5])
         cylinder(r=lego/2, h=2.5, $fs=.1);
         //nub is 2mm tall because buried
    }//end y_jump
  }//end z
}//end union

//**begin chopping off stuff here
  cube([xmax,55.3,6]); //chop off bottom

//now cut off half the thickness of the left and right
  for(x=[0,xmax-20]) {
    translate([x,55,2.98]) cube([20,14.3,4]);
  }
//now cut out an interface in the middle
  translate([30,55,2.98]) cube([xmax-30*2+1,10,3]);
  translate([38-0.35,61-0.35,0]) cube([xmax-38*2+0.35*2,8.7,6]);


} //end difference for chopping

module t_down(){ //this function makes the "cross" shapes
  /* Cross is for bolt pointing down with bolt hole center
     at (t_width/2,0)
   */
  union(){
    translate([0,-8]) square([t_width,8]);
    translate([-2,-5.9]) square([7,3.4]);
  }
}
