/**
 * The bullet object, created when the player shoots.
 */
class Bullet {
  
   // The bullet is a red circle centred at (x, y), with radius r
   public float x;
   public float y;
   public float r = 6;
   private final color c = color(255, 0, 0);
   
   // Physical properties of the bullet
   private float vx = 0;
   private float vy = 0;
   
   
   // Create a bullet that is at (x, y), with velocity 15 forwards.
   public Bullet(float x, float y) {
     this(x, y, 0, -15);  
   }
   
   // Constructor to specify (vx, vy)
   public Bullet(float x, float y, float vx, float vy) {
     this.x = x;
     this.y = y;
     this.vx = vx;
     this.vy = vy;
   }
   
   // Draw the bullet
   public void draw() {
     fill(this.c);
     stroke(this.c);
     ellipseMode(RADIUS);
     pushMatrix();
     translate(this.x, this.y);
     ellipse(0, 0, this.r, this.r);
     popMatrix();
   }
  
   // Move the bullet forwards with its vx/vy
   // Also check for collision with monsters using line intersection (as the bullet is small and easily passes through the monster.
   public void move() {
     
    // Line of the bullets path
    float x0 = this.x+this.r;
    float y0 = this.y+this.r;
    float x1 = this.x+this.r+this.vx;
    float y1 = this.y+this.r+this.vy;
    
    ArrayList<Monster> toRemove = new ArrayList<Monster>();
    for (Monster m : monsters) {
      
      // Hit line of the monster
      float x2 = m.x-m.r;
      float y2 = m.y-m.r;
      float x3 = m.x+m.r;
      float y3 = m.y-m.r;
      
      // If intersects - remove the monster
      if (intersects(x0, y0, x1, y1, x2, y2, x3, y3)) {
        toRemove.add(m);
      }
    }
    
    for (Monster m : toRemove) {
      monsters.remove(m);
    }
    
    x += vx;
    y += vy;
   }
}
