/** Global variables **/
Point[] POINTS     = new Point[6];
Arrow[] ARROWS     = new Arrow[3];

/** Setup the processing sketch **/
void setup() {
  size(500, 500);
  frameRate(20);
  POINTS[0] = new Point(100, 100);
  POINTS[1] = new Point(200, 400);
  POINTS[2] = new Point(400, 300);
  POINTS[3] = new Point(300, 100);
  POINTS[4] = new Point(200, 250);
  POINTS[5] = new Point(350, 220);
  ARROWS[0] = new Arrow(1, POINTS.length);
  ARROWS[1] = new Arrow(2, POINTS.length);
  ARROWS[2] = new Arrow(3, POINTS.length);
}


/** Main loop **/
void draw() {
  background(255);
  stroke(0);
  noFill();
  
  drawCurve();
  drawConnectingLines();

  for (Arrow a : ARROWS) {
    a.draw();
    a.move(0.1);
  }
}
