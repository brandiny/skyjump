/**
 * Flexible animation class
 * to use - add the created animation to the list 'animations'
 */
class Animation {
  private float x;             // where the animation is drawn (x, y)
  private float y;
  private String type;         // name of animation
  public float frames;         // current frame count
  public float max_frames;     // when the animatione ends
  
  // Create the animation (x,y), with the type parameter=the name of animation
  public Animation(float x, float y, String type) {
    this.x = x;
    this.y = y;
    this.type = type;
    if (this.type.equals("bounce")) {
      max_frames = 25;
    }
  }
  
  
  // Draws the current frame of the animation, based on its name...
  public void draw() {
    pushMatrix();
      translate(x, y);
      
      /** Draws 3 fading (based on alpha value) spaced rectangles at (x, y), that eject exponentially slower away from (x, y) **/
      if (type.equals("bounce")) {
        int colorR, colorG, colorB;
        colorR = colorG = colorB = 0;     // initial color of the squares 
        int horiz_distance = 7;           // how spaced apart the squares are
        int w = 7;                        // side length of squares
        float drag = 0.7;                 // how quickly they slow down - directly proportional
        float shooting_distance = 30;     // how far they go
        
        // Draw the first rectangle - appears first
        fill(colorR, colorG, colorB, 100*(1.5-frames/max_frames));
        stroke(colorR, colorG, colorB, 100*(1.5-frames/max_frames));
        rectMode(CENTER);
        rect(0, shooting_distance*(1-exp(-drag*frames)), w, w);
        
        // After 1/3 of the animation, draw the second rectangle
        if (frames > max_frames/3) {
          fill(colorR, colorG, colorB, 100*(1.5-(frames-max_frames/3)/max_frames));
          stroke(colorR, colorG, colorB, 100*(1.5-(frames-max_frames/3)/max_frames));
          rect(10, (shooting_distance-horiz_distance)*(1-exp(-drag*(frames-max_frames/3))), w, w);
        }
        
        // After 2/3 of the animation, draw the third rectangle
        if (frames > 2*max_frames/3) {
          fill(colorR, colorG, colorB, 100*(1.5-(frames-2*max_frames/3)/max_frames));
          stroke(colorR, colorG, colorB, 100*(1.5-(frames-2*max_frames/3)/max_frames));
          rect(-10, (shooting_distance-2*horiz_distance)*(1-exp(-drag*(frames-2*max_frames/3))), w, w);
        }
      }
    
      // if (type.equals("next animation") - new animation template
      
    popMatrix();
    frames++;
  }
  
  // If the frame count is after the max_frames, the animation is finished and can be removed from the queue.
  public boolean finished() {
    return frames >= max_frames;
  }
}
