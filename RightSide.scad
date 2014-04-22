// rightSide: The right vertical piece of the robot

/* Except for the placement of one notch, this is identical
 * to leftSide. The trick is the linear_extrude function at
 * the end has a "mirror" function that does a reverse image
 * of the original (left) side.
 *
 * All comments have been removed from this file, except to
 * illustrate the one change. Look to leftSide for comments.
 */

yMax=83.7;
x1=25.4;
x2=44.5; 
x3=88.9; 
xMax=127; 
notchDepth=4.9; 
th=5.98;  
bh = 1.9; 
wt = 1.5; 

module botRightSide(){
  difference(){
    union(){
      polygon([[0,15.9],[0,yMax],[x1,yMax],[x1,0],[22.2,0]],
              [[0,1,2,3,4]]);
//THIS IS THE ONE CHANGE
      translate([0.15,yMax]) square([notchDepth,th]);
      translate([x1,0]) square([x2-x1,38.1]);
      translate([x2,0]) square([x3-x2,31.8]);
      polygon([[x3,0],[x3,yMax],[xMax,yMax],[xMax,19.1]],
              [[0,1,2,3]]);
    } 
    translate([19.1,34.9]) circle(r=bh, $fn=20);
    translate([96.5,34.9]) circle(r=bh, $fn=20);
    translate([22.2, 6.4]) circle(r=wt, $fn=20);
    translate([52.4, 6.4]) circle(r=wt, $fn=20);
    translate([82.6, 6.4]) circle(r=wt, $fn=20);
    translate([120.7,22.2])circle(r=wt, $fn=20);
    translate([120.7-13.5,22.2])circle(r=wt, $fn=20);
    translate([10.9,yMax]) t_down();
    translate([114.1,yMax]) t_down();
    translate([64.9,31.8])  t_down();
    translate([95.4,yMax-th]) square([8.6,th]);
    polygon([[20,13],[10,20],[30,20],[35,13]],[[0,1,2,3]]);
    polygon([[45,13],[40,20],[65,20],[62,13]],[[0,1,2,3]]);
    polygon([[72,13],[75,20],[100,20],[90,13]],[[0,1,2,3]]);
    polygon([[x3+8,45],[x3+8,yMax-15],
             [xMax-8,yMax-15],[xMax-8,45]],[[0,1,2,3]]);
    polygon([[8,45],[8,yMax-15],
             [x1-8,yMax-15],[x1-8,45]],[[0,1,2,3]]);
  }
}

linear_extrude(height=th) mirror([0,50,0]) botRightSide();

module t_down(){
  union(){
    translate([0,-8]) square([3.5,8]);
    translate([-2,-5.9]) square([7,3.4]);
  }
}
