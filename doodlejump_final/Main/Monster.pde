/**
 * Monster object. Two types - stationary, moving. If the player hits a monster, they will die.
 */
class Monster {
  
  // The monster will be drawn (x, y) with a hitbox as a square with width w. 
  public float x;         
  public float y;
  public float r = 20; 
  private color fillColor;
  private float spike_count;
  private String type;
  
  // Physical properties
  private float w = 0.1; // angular velocity.
  private float vx;
  private float currentangle = 0; // current angular displacement.
  
  
  // Constructor - no type given = normal, stationary type  
  public Monster(float x, float y) {
    this(x, y, "normal");
  }
  
  // Constructor - specify type;  
  public Monster(float x, float y, String s) {
    this.x = x;
    this.y = y;
    this.type = s;
    
    if (this.type.equals("moving")) {
      spike_count = 8;                       // more spikes on the moving one
      this.vx = random(0, 1) < 0.5 ? -1 : 1; // randomise initial direction of the speed 
      this.fillColor = color(100, 85, 211);  // pastel blue
      
    } else if (this.type.equals("normal")) { 
      this.vx = 0;                           // stationary
      this.fillColor = color(186, 85, 211);  // purple
      spike_count = 6;
    }
  }
  
  // Move the ball horizontally at vx, and bounce off walls.
  public void move() {
    x += vx;
    currentangle += w; 
    if (x > width || x < 0) {vx *= -1;}
  }

  // Draw the monster at (x, y)
  public void draw() {
    fill(fillColor);
    stroke(fillColor);
    beginShape();
    pushMatrix();
      translate(this.x, this.y);
      rotate(currentangle);
      
      // the shape is a circle with varying amplitude.
      float amplitude;
      float angle = PI/spike_count;
      for (int i=0; i<spike_count*2; ++i) {
         float x, y;
         if (i % 2 == 0) { // outer
           amplitude = this.r;
         } else { // inner
           amplitude = this.r/2;
         }
         
         x = amplitude*cos(angle*i);
         y = amplitude*sin(angle*i);
         vertex(x, y);
      }
      endShape(CLOSE);
    popMatrix();
  }
}
