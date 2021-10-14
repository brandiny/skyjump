/**
 * Powerups - when collided with, will provide the player with a boost
 * Types are:
 *   - shoe = permanetly boosts the player jump speed and reduces their size
 *   - gun = upgrades the gun shot
 *   - rocket = takes the player to a higher part of the map for free
 *   - spring = boosts the player up 
 */
class Powerup {
  public static final float w = 20;
  public float x;
  public float y;
  public String type;
   
  public Powerup(float x, float y, String s) {
    this.x=x;
    this.y=y;
    this.type=s;
  }
  
  // Draw the powerup using processing art
  public void draw() {
    noStroke();
    pushMatrix();
      translate(this.x, this.y);
      rectMode(CORNER);
      
      if (type.equals("gun")) { // Gun art
        fill(0);
        
        rect(0, 0, w, w/2);
        rect(0, w/2, w/2, w/2);
      }
      
      else if (type.equals("jetpack")) {  // Jetpack/Rocket art       
         fill(255);
         rect(-w/2, -w/2, w, 3*w/2);
         fill(230, 230, 230);
         rect(w/4, -w/2, w/4, 3*w/2);
         fill(255, 0, 0);
         triangle(-w/2, -w/10, -w, w, -w/2 ,w);
         triangle(w/2, -w/10, w, w, w/2 ,w);
         fill(0);
         triangle(-w/2, -w/2, w/2, -w/2, 0, -w);
      } 
      
      else if (type.equals("spring")) { // Spring art
        pushMatrix();
        scale(0.8);
        fill(255, 100, 0);
        triangle(0, -w, -w, 0, w, 0);
        triangle(0, 0, -w, w, w, w);
        popMatrix();
      } 
      
      else if (type.equals("shoes")) { // Shoes art
        int shoegap = 3;
        fill(100, 0, 255); 
        beginShape();
        vertex(-w, -w/2);
        vertex(-w, w);
        vertex(0-shoegap, w);
        vertex(0-shoegap, w/2);
        vertex(-w/2, w/2);
        vertex(-w/2, -w/2);
        endShape(CLOSE);
        fill(10, 0, 150);
        rect(-w, 3*w/4, w-shoegap, w/4);
        
        fill(100, 0, 255);
        translate(w, 0);
        beginShape();
        vertex(-w, -w/2);
        vertex(-w, w);
        vertex(0-shoegap, w);
        vertex(0-shoegap, w/2);
        vertex(-w/2, w/2);
        vertex(-w/2, -w/2);
        endShape(CLOSE);
        fill(10, 0, 150);
        rect(-w, 3*w/4, w-shoegap, w/4);
        translate(-w, 0);
      }
    
   popMatrix();
    
  }
  
  
}
