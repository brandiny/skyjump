class Platform {
  public String type;
  public  float x;                 // the center x of the platform
  public  float y;                 // the top y of the platform
  public static final int w = 80;  // width
  public static final int h = 10;  // height
  
  public Platform(float x, float y) {
    this.x = x;
    this.y = y;
    this.type = "normal";
  }
  
  public Platform(float x, float y, String s) {
    this.x = x;
    this.y = y;
    this.type = s;
  }
    
  public void draw() {
    rectMode(CORNER);
    fill(0, 255, 0);
    stroke(0, 255, 0);
    rect(this.x-w/2, y, w, h);
  }
}  
