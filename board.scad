// Pawn module
module pawn() {
  // Set the width and height of the pawn
  width = 4;
  height = 10;

  // Create the base of the pawn
  cylinder(r=width/2, h=height/4);

  // Create the top of the pawn
  translate([0, 0, height/4])
  cylinder(r=width/2, h=height/2);

  // Create the neck of the pawn
  translate([0, 0, 3*height/4])
  cylinder(r=width/4, h=height/4);

  // Create the head of the pawn
  translate([0, 0, height])
  sphere(r=width/2);
}

module rook(size=10) {
  // Calculate the height and width of the rook
  // based on the size parameter
  height = size * 0.8;
  width = size * 0.4;

  // Create the base of the rook using a cylinder
  difference() {
    cylinder(r=width/2, h=height);

    // Cut out the top of the rook using a smaller cylinder
    translate([0, 0, height * 0.9])
      cylinder(r=width/2 * 0.7, h=height * 0.1);
  }

  // Create the top of the rook using a cube
  translate([0, 0, height])
    cube([width, width, height * 0.2], center=true);

  // Add some detail to the top of the rook using
  // spheres and cylinders
  difference() {
    translate([0, 0, height + height * 0.1])
      sphere(r=width/2 * 0.8);

    translate([0, 0, height * 1.15])
      cylinder(r=width/2 * 0.4, h=height * 0.3);
  }
}

// Bishop OpenSCAD module
//
// Generates a 3D model of a bishop chess piece
//
// Parameters:
//   h: height of the bishop (default: 20)
//   r: radius of the base (default: 10)
//   d: depth of the base (default: 5)

module bishop(h = 10, r = 5, d = 2.5) {
  // base of the bishop
  cylinder(h = d, r = r);

  // main body of the bishop
  translate([0, 0, d])
    cylinder(h = h - d, r1 = r * 0.8, r2 = r * 0.5);

  // bishop's head
  translate([0, 0, h - d * 0.5])
    sphere(r = r * 0.5);
}

//Knight Chess Piece

module knight(size=10) {
  //Base parameters
  difference() {
    //Body of knight
    union() {
      //Head of knight
      translate([0, 0, size * 0.7])
        sphere(size * 0.3);

      //Neck of knight
      translate([0, 0, size * 0.5])
        cylinder(r = size * 0.1, h = size * 0.2);

      //Body of knight
      translate([0, 0, size * 0.3])
        cylinder(r = size * 0.15, h = size * 0.2);

      //Legs of knight
      translate([size * 0.15, 0, 0])
        cylinder(r = size * 0.05, h = size * 0.3);
      translate([-size * 0.15, 0, 0])
        cylinder(r = size * 0.05, h = size * 0.3);
    }

    //Cut out for knight's arms
    translate([0, 0, size * 0.5])
      rotate([90, 0, 0])
      cylinder(r = size * 0.2, h = size * 0.2);
  }

  //Arms of knight
  translate([0, 0, size * 0.7])
    rotate([-45, 0, 0])
    cylinder(r = size * 0.05, h = size * 0.3);
  translate([0, 0, size * 0.7])
    rotate([45, 0, 0])
    cylinder(r = size * 0.05, h = size * 0.3);
}

module queen(size=10) {
  // Body of the queen
  union() {
    // Head of the queen
    cylinder(r=size/6, h=size/3);
    // Torso of the queen
    translate([0, 0, size/3])
      cylinder(r=size/6, h=size/2);
    // Dress of the queen
    translate([0, 0, size/2])
      cylinder(r=size/2, h=size/6);
  }

  // Crown of the queen
  translate([0, 0, size*5/6])
    cylinder(r1=0, r2=size/4, h=size/6);
  translate([0, 0, size])
    cylinder(r1=size/4, r2=0, h=size/6);
}

module king() {
  // Base of the king
  cylinder(r=5, h=10);
  
  // Crown on top of the king
  translate([0, 0, 10]) {
    cylinder(r=3, h=4, center=true);
    sphere(r=3, center=true);
    translate([0, 0, 2]) {
      cylinder(r=1, h=8, center=true);
      translate([0, 0, 4]) {
        cylinder(r=2, h=2, center=true);
        translate([0, 0, 1]) {
          cylinder(r=0.5, h=6, center=true);
        }
      }
    }
  }
  
  // Cross on top of the crown
  translate([0, 0, 14]) {
    rotate([90, 0, 90]) {
      cylinder(r=0.5, h=10, center=true);
    }
  }
}

// Chessboard
size = 8;  // number of squares on each side
thickness = 2;  // thickness of board and squares

for (i = [0:size-1])
  for (j = [0:size-1])
    translate([i*10, j*10, -2])
    color( (i+j)%2 == 0 ? "white" : "black")
    cube([10,10,thickness]);

// Place the chess pieces on the board
translate([0 * 10 + 5, 7 * 10 + 5, 0]) rook();
translate([1 * 10 + 5, 7 * 10 + 5, 0]) knight();
translate([2 * 10 + 5, 7 * 10 + 5, 0]) bishop();
translate([3 * 10 + 5, 7 * 10 + 5, 0]) queen();
translate([4 * 10 + 5, 7 * 10 + 5, 0]) king();
translate([5 * 10 + 5, 7 * 10 + 5, 0]) bishop();
translate([6 * 10 + 5, 7 * 10 + 5, 0]) knight();
translate([7 * 10 + 5, 7 * 10 + 5, 0]) rook();

for (x = [0 : 7]) {
translate([x * 10 + 5, 6 * 10 + 5, 0]) pawn();
}

translate([0 * 10 + 5, 0 * 10 + 5, 0]) rook();
translate([1 * 10 + 5, 0 * 10 + 5, 0]) knight();
translate([2 * 10 + 5, 0 * 10 + 5, 0]) bishop();
translate([3 * 10 + 5, 0 * 10 + 5, 0]) queen();
translate([4 * 10 + 5, 0 * 10 + 5, 0]) king();
translate([5 * 10 + 5, 0 * 10 + 5, 0]) bishop();
translate([6 * 10 + 5, 0 * 10 + 5, 0]) knight();
translate([7 * 10 + 5, 0 * 10 + 5, 0]) rook();

for (x = [0 : 7]) {
translate([x * 10 + 5, 1 * 10 + 5, 0]) pawn();
}
