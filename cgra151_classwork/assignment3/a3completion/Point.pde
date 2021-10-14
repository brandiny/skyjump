/*
 * A curve point 
 */
class Point {
  private float x;
  private float y;
  private static final float outline_radius = 5;
  
  public Point(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
  // Draws a rectangle at this x,y point.
  public void draw() {
    strokeWeight(1);
    rect(x-outline_radius/2, y-outline_radius/2, outline_radius, outline_radius);
  }
  
}
