// speakerShelf: shelf to hold speaker flush to top platform

// Definitions (all lengths are in millimeters)
botWidth=85.7; //the width from left side to right of the robot
tabDepth=8;    //the width of the openings on left and right sides
tabLength=6.3; //how long tabs are compared to the rest


// this module defines a 2D shape that we'll then
// extrude to the desired thickness
module speakerShelf() {
  difference() { //the main shape is defined by the union()
                 //and this difference allows us to cut a
                 //circle out of the middle

    union() {
      //there are two parts to this main shape:
      //  -The first part is a long rectangle for the "tabs"
      //  -The second part is the "wing" to hold the speaker
      
      //First part:
      square([tabDepth,botWidth]);

      //Second part (a "hull" combination of two shapes):
      hull() { //This wraps a "hull" around two shapes:
        translate([0,tabLength])
                 square([15.8,botWidth-2*tabLength]);
        translate([18.6,botWidth/2]) circle(r=18, $fn=60);
      } //end of hull
    } //end of union

    //what we're cutting out (based on the difference function):
    translate([18.9,botWidth/2]) circle(r=14.5, $fn=60);
  }
}

linear_extrude(height=5.68) speakerShelf();
