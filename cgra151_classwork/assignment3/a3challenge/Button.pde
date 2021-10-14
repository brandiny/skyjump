/** A button that is located at x,y with width=w and height=h. It displays string=s **/
class Button {
  public int x, y, w, h;
  private String s;
  private color c = color(255);
  
  public Button(int x, int y, int w, int h, String s) {
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
    this.s = s;
  }
  
  // Draws the button, and its text
  public void draw() {
    fill(c);
    rect(x, y, w, h);
    fill(0);
    textSize(18);
    text(s, x+10, y+22);
  }
  
  // Clip the polygon
  public void activate() {
    clipThePolygon();
  }
  
  // Colors the button 
  public void addColor() {
    c = color(255, 0, 0); 
  }
  
  // Doesn't color the button.
  public void removeColor() {
    c = color(255);
  }
}
