color   LINE_COLOR = color(255, 100, 0);
int     CURVE_THICKNESS = 15;

/** 
 * Draws lines between the p
 */
void drawConnectingLines() {
  stroke(LINE_COLOR);
  for (Point p: POINTS)
    p.draw();
  
  for (int i=0; i<POINTS.length-1; ++i) {
      line(POINTS[i].getX(), POINTS[i].getY(), POINTS[i+1].getX(), POINTS[i+1].getY());   
  } line(POINTS[0].getX(), POINTS[0].getY(), POINTS[POINTS.length-1].getX(), POINTS[POINTS.length-1].getY());
}


/** 
 * Draws the main curves
 */
void drawCurve() {
  strokeWeight(CURVE_THICKNESS);
  for (int i=0; i<POINTS.length;++i){
    int a = i;
    int b = (i+1) % POINTS.length;
    int c = (i+2) % POINTS.length;
    int d = (i+3) % POINTS.length;
    curve(POINTS[a].getX(),POINTS[a].getY(),POINTS[b].getX(),POINTS[b].getY(),POINTS[c].getX(),POINTS[c].getY(),POINTS[d].getX(),POINTS[d].getY());
  }
}

/**
 *  Draws the laser pointer
 */
void drawLaserPointer() {
   float angle = atan2(mouseY-height/2, mouseX-width/2);
   pushMatrix();
   translate(width/2, height/2);
   rotate(angle);
   fill(255, 0, 0);
   ellipseMode(CENTER);
   ellipse(0, 0, 20, 20);
   rect(0, -5, 20, 10);
   line(0, 0, 400, 0);
   popMatrix();
}
