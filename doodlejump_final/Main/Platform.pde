/**
 * Platform object, which allows the player to bounce on top of and reach higher.
 */
class Platform {
  public static final int max_speed_height = 40000; // when do the moving platforms hit max speed 
  public static final int max_speed = 5;            // how fast the platform can get
  
  // Used for drawing the platform
  public float x;                        // the center x of the platform
  public float y;                        // the top y of the platform
  public static final int w = 80;        // width
  public static final int h = 13;        // height
  private int colorR, colorG, colorB;

  // Properties
  private float vx;                      // current speed  
  public String type;                    // normal - stationary
                                         // moving - moves left and right at vx
                                         // disappear - is removed when bounced on. 
                                        
                                         
  // Default constructor - constructs a stationary platform.                                        
  public Platform(float x, float y) {
    this(x, y, "normal");
  }
  
  // Specifc constructor - constructs a platform of a type.
  public Platform(float x, float y, String s) {
    this.x = x;
    this.y = y;
    this.type = s;
    
    // Normal - green, vx=0
    if (this.type.equals("normal")) {
      this.vx = 0;
      this.colorR = 151;
      this.colorG = 227;
      this.colorB = 194;
    }
    
    // Moving - blue, vx=random velocity, and proportional to how high up you are
    if (this.type.equals("moving")) {
      this.vx = min(1, SCREEN_OFFSET/max_speed_height)*max_speed + random(0, 1);  
      if (random(1) <= 0.5) vx *= -1;
      this.colorR = 70;
      this.colorG = 212;
      this.colorB = 225;
    }
    
    // Disappear - red platform with vx=0;
    if (this.type.equals("disappear")) {
      this.vx = 0;
      this.colorR = 255;
      this.colorG = 0;
      this.colorB = 0;
      
    }
  }
  
  // Move the platform with it's vx. Bounce back if needed.
  public void move() {
    x += vx;
    if (x > width) vx *= -1;
    if (x < 0)     vx *= -1;
  }
    
    
  // Draw the platform.
  public void draw() {
    pushMatrix();
    translate(this.x-w/2, y);
      // Draw the first forwards facing rectangle..
      rectMode(CORNER);
      fill(colorR, colorG, colorB);
      stroke(colorR, colorG, colorB);
      rect(0, 0, w, h);
      
      
      int i = 6; // how far it goes in y
      int j = 6; // hor far it goes in z
      
      // Draw the 'into the page' paralleogram.
      fill(colorR/2, colorG/2, colorB/2);         // darken
      stroke(colorR/2, colorG/2, colorB/2);
      beginShape();                              
        vertex(0, 0);
        vertex(i, -j);
        vertex(w+i, -j);
        vertex(w, 0);
      endShape(CLOSE);
      
      // Draw the 'into the page' paralleogram2
      fill(colorR/3, colorG/3, colorB/3);         // darken even more
      stroke(colorR/3, colorG/3, colorB/3);
      beginShape();
        vertex(w, 0);
        vertex(w+i, -j);
        vertex(w+i, h-j);
        vertex(w, h);
      endShape(CLOSE);
    popMatrix();
  }
}  
