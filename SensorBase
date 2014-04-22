// sensorBase: "Base" to connect sonar to motor

// Definitions (all lengths are in millimeters)
//locations of the two bolt centers on y-axis
yc=0; //center in y (axis of symmetry)
yh=33; //height of the total shape in the y-dimension
ef=14; //x-coordinate of the edge that touches the face

b1=yc-9.45; //center of first bolt hole
b2=yc+9.45; //center of second bolt hole
bd=7.2;  //bolt depth
bw=3.55; //bolt width
nd=3.4;  //nut depth
nw=6.95; //nut width

th=1.2; //radius of tap screw hole

// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module sensorBase() {

  difference() { //a circle with a lot cut away

    translate([18,yc]) circle(r=18, $fn=60);

    // everything below here is a "cutout" from the circle 

    //basic shape cutout in the back
    translate([0,yc-yh/2-10])  square([20,10.3]);
    translate([0,yc+yh/2-0.3]) square([20,10.3]);
    translate([20,yc-yh/2-5]) square([20,yh+5*2]);
    translate([ef,yc-26.8/2]) square([7,26.8]);

    //bolt/nut slots
    translate([ef-bd,b1-bw/2]) square([bd,bw]);
    translate([ef-bd,b2-bw/2]) square([bd,bw]);
    translate([ef-5.9,b2-nw/2]) square([nd,nw]);
    translate([ef-5.9,b1-nw/2]) square([nd,nw]);

    //servo holes (these match a servo horn)
    translate([4,yc-6.9]) circle(th, $fn=20);
    translate([4,yc+6.9]) circle(th, $fn=20);
    translate([4,yc]) circle(2.8, $fn=30);
  }
}

//this line converts from a 2D to a 3D shape
linear_extrude(height=5.58) sensorBase();
