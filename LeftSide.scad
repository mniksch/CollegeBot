// leftSide: The left vertical piece of the robot

// Definitions (all lengths are in millimeters)
yMax=83.7; //top of the main shape
x1=25.4;   //a repeated x coordinate
x2=44.5;   //a repeated x coordinate
x3=88.9;   //a repeated x coordinate
xMax=127;  //end of shape
notchDepth=4.9; //depth of top tab
th=5.98;      //thickness of a standard robot body part

bh = 1.9; // radius of 4-40 bolt hole
wt = 1.5; // radius of a tank wheel tap screw


// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module botLeftSide(){
  difference(){ //the shape is a main body minus cutouts
    union(){ //the main body is a collection of 5 parts
      //1: Rear tower (outside face is on z=0)
      polygon([[0,15.9],[0,yMax],[x1,yMax],[x1,0],[22.2,0]],
              [[0,1,2,3,4]]);
      //2: Small notch on rear tower to help tell left from right
      translate([x1-notchDepth,yMax]) square([notchDepth,th]);
      //3: Middle part connecting two towers (1 of 2)
      translate([x1,0]) square([x2-x1,38.1]);
      //4: Middle part connecting two towers (2 of 2)
      translate([x2,0]) square([x3-x2,31.8]);
      //5: Front tower
      polygon([[x3,0],[x3,yMax],[xMax,yMax],[xMax,19.1]],
              [[0,1,2,3]]);
    } //end of union()

    //Everything below are cut-outs/subtractions

    //bolt holes to connect to the bottom platform
    translate([19.1,34.9]) circle(r=bh, $fn=20);
    //for reference, this hole is 127-19.1=107.9 from the front
    translate([96.5,34.9]) circle(r=bh, $fn=20);
    //for reference, this hole is 127-96.5=30.5 from the front

    //holes for tank wheel threaded screws
    translate([22.2, 6.4]) circle(r=wt, $fn=20);
    translate([52.4, 6.4]) circle(r=wt, $fn=20);
    translate([82.6, 6.4]) circle(r=wt, $fn=20);
    translate([120.7,22.2])circle(r=wt, $fn=20);
    //the second hole is for using a different gearbox axle
    translate([120.7-13.5,22.2])circle(r=wt, $fn=20);

    //"cross" notches for nuts/bolts from above
    translate([10.9,yMax]) t_down();
    translate([114.1,yMax]) t_down();
    translate([64.9,31.8])  t_down();
    //for reference, this translates  to a a bolt that is
    //127-64.9-1.75=60.35 from the front (xMax)

    //cut-out for the speaker shelf
    translate([95.4,yMax-th]) square([8.6,th]);

    //optional cutouts to reduce material usage
    polygon([[20,13],[10,20],[30,20],[35,13]],[[0,1,2,3]]);
    polygon([[45,13],[40,20],[65,20],[62,13]],[[0,1,2,3]]);
    polygon([[72,13],[75,20],[100,20],[90,13]],[[0,1,2,3]]);
    polygon([[x3+8,45],[x3+8,yMax-15],
             [xMax-8,yMax-15],[xMax-8,45]],[[0,1,2,3]]);
    polygon([[8,45],[8,yMax-15],
             [x1-8,yMax-15],[x1-8,45]],[[0,1,2,3]]);

  } //end of difference()
} //end of botLeftSide()


linear_extrude(height=th) botLeftSide();

module t_down(){ //this function makes the "cross" shapes
  union(){
    translate([0,-8]) square([3.5,8]);
    translate([-2,-5.9]) square([7,3.4]);
  }
}
