class Arrow {
  private int MAX_T;
  private float t;
  
  /** Constructs an arrow with an initial parametric T value, and a maximum T value **/
  public Arrow(float initial_t, int maximum_t) {
     t = initial_t;
     MAX_T = maximum_t;
  }
  
  /** Draws the arrow, based on the current T value on the POINTS curve **/
  public void draw() {
    int curveNumber = (floor(t)) % MAX_T; // which curve is it on
    int a =  curveNumber;
    int b = (curveNumber+1) % MAX_T; 
    int c = (curveNumber+2) % MAX_T;
    int d = (curveNumber+3) % MAX_T;
    float x = curvePoint(POINTS[a].getX(), POINTS[b].getX(), POINTS[c].getX(), POINTS[d].getX(), t % 1);
    float y = curvePoint(POINTS[a].getY(), POINTS[b].getY(), POINTS[c].getY(), POINTS[d].getY(), t % 1);
    float xTangent = curveTangent(POINTS[a].getX(), POINTS[b].getX(), POINTS[c].getX(), POINTS[d].getX(), t % 1);
    float yTangent = curveTangent(POINTS[a].getY(), POINTS[b].getY(), POINTS[c].getY(), POINTS[d].getY(), t % 1);
    float angle = atan2(yTangent, xTangent);
    
    // Draws the arrow
    strokeWeight(1);
    fill(255, 0, 0);
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
  
  /** Increments t **/
  void move(float i) {
    t += i; 
  }  
}
