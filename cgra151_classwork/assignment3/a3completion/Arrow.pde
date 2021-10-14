/**
 *  Arrow object that goes through the curve. Can be drawn.
 */
class Arrow {
  private int MAX_T;
  private float t;
  private color ARROW_COLOR = color(255, 255, 255);
  private color HIGHLIGHT_COLOR = color(255, 0, 0);
 
  /** Initialse an arrow with the initial parameter t, and maximum t value. **/ 
  public Arrow(float initial_t, int maximum_t) {
     t = initial_t;
     MAX_T = maximum_t;
  }
  
  /** Draws the arrow , and colours it accordingly **/
  public void draw() {
    int curveNumber = (floor(t))%MAX_T;
    int a =  curveNumber;
    int b = (curveNumber+1) % MAX_T;
    int c = (curveNumber+2) % MAX_T;
    int d = (curveNumber+3) % MAX_T;
    float x = curvePoint(POINTS[a].getX(), POINTS[b].getX(), POINTS[c].getX(), POINTS[d].getX(), t % 1);
    float y = curvePoint(POINTS[a].getY(), POINTS[b].getY(), POINTS[c].getY(), POINTS[d].getY(), t % 1);
    float xTangent = curveTangent(POINTS[a].getX(), POINTS[b].getX(), POINTS[c].getX(), POINTS[d].getX(), t % 1);
    float yTangent = curveTangent(POINTS[a].getY(), POINTS[b].getY(), POINTS[c].getY(), POINTS[d].getY(), t % 1);
    float angle = atan2(yTangent, xTangent);
    
    strokeWeight(1);
    stroke(0);
    
    boolean lazered = false; // is it hit by the lazer
    
    float tangentMagnitude = pow(xTangent*xTangent + yTangent*yTangent, 0.5); 
    tangentMagnitude = tangentMagnitude==0 ? 1 : tangentMagnitude;
    
    float x1 = x + xTangent/tangentMagnitude * 30; // the line between the head of the tail, and the back
    float y1 = y + yTangent/tangentMagnitude * 30;
    float x2 = x - xTangent/tangentMagnitude * 10;
    float y2 = y - yTangent/tangentMagnitude * 10;
    
    float x3 = mouseX+(mouseX-width/2); // the line from the center of the screen, to the mouse
    float y3 = mouseY+(mouseY-height/2);
    float x4 = width/2;
    float y4 = height/2;
    
    float A = -(y4-y3); // 
    float B = (x4-x3);
    float C = x3*y4 - y3*x4;
    float s = -(A*x1+B*y1+C) / (A*(x2-x1)+B*(y2-y1));
    
    float xi = (1-s)*x1 +s*x2;
    float yi = (1-s)*y1 +s*y2;
    
    if ((xi-x1)*(x2-xi)>=0 && (yi-y1)*(y2-yi)>=0 && (xi-x3)*(x4-xi)>=0 && (yi-y3)*(y4-yi)>=0)
      lazered = true;
    
    if (lazered) {
      fill(HIGHLIGHT_COLOR);      
    } else {
      fill(ARROW_COLOR);
    }
    
    
    pushMatrix();
    translate(x, y);
    rotate(angle);
    beginShape();
     vertex(0,0);
     vertex(-10,-10);
     vertex(30,0);
     vertex(-10,10);
    endShape(CLOSE);
    popMatrix();
  }
  
  void move(float i) {
    t += i; 
  } 
}
