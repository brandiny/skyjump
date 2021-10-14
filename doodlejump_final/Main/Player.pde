/**
 * The main player object that bounces up the screen. The object is responsible for its physics, drawing, and colision detection.
 */
class Player {
  
  // Player is drawn as a BLACK square at center (x,y) with with 2r, rotated about center by angle, in radians.
  public float        x;
  public float        y;
  private float       r = 15;
  private color       fillColor = color(0, 0, 0);
  private float       angle = 0;                 
  
  // Physical properties
  public float        UPWARDS_MAX = 13;          // How fast the block jumps off each platform
  public float        vy = UPWARDS_MAX;          // Current upwards velocity
  private float       vx = 0;                    // Current sideways velocity
  private float       w = 0.1;                   // Angular velocity
  
  // Other
  private float       horizontal_push_speed = 6;            // How much the player moves when a left/right key is pressed
  public int          gun_level = 1;                        // How upgraded the players gun is...
  
  
  // Creates a player at (x, y) position
  public Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // Draw the player
  public void draw() {
    pushMatrix();
      translate(this.x, this.y);
      rotate(angle);
      rectMode(RADIUS);
      fill(fillColor);
      stroke(fillColor);
      rect(0, 0, r, r);
    popMatrix();
  }
  
  /* Move the player based on its vx, vy, and apply gravity */
  /* Also, use advance collision detection for platforms - line intersection */
  public void move() {
    
    // Record the initial position of left edge (x0,y0) and right edge (x2, y2);
    float x0 = this.x+this.r;
    float y0 = this.y+this.r;
    float x2 = this.x-this.r;
    float y2 = this.y+this.r;
    
    // Move the player - with gravity.
    vy += GRAVITY_CONSTANT/2;
    x += vx;
    y += vy;    
    vy += GRAVITY_CONSTANT/2;
    angle = (angle + w) % (2*PI);
    
    // Main animation
    SCORE = max(SCORE, height-y);
    
    // Check for wrap around
    if (x < 0)             {x = width;} 
    else if (x > width)    {x = 0;}
    
    // Record the initial position of left edge (x1,y1) and right edge (x3, y3);
    float x1 = this.x+this.r;
    float y1 = this.y+this.r;
    float x3 = this.x-this.r;
    float y3 = this.y+this.r;
    
    // Calculate collisions between platforms and the player.
    ArrayList<Platform> toRemove = new ArrayList<Platform>();
    for (Platform p : platforms) {
      float lx0 = p.x-Platform.w/2;           // (lx0, ly0) --> (lx1, ly1) = line of the top base of the platform 
      float ly0 = p.y;
      float lx1 = p.x+Platform.w/2;
      float ly1 = p.y;
      
      // If the left edge line or right edge line - intersects with platform line AND player veloctiy downwards - it is a collision 
      boolean collidesLeftEdge = intersects(x0, y0, x1, y1, lx0, ly0, lx1, ly1);
      boolean collidesRightEdge = intersects(x2, y2, x3, y3, lx0, ly0, lx1, ly1);
      if ((collidesLeftEdge || collidesRightEdge) && vy >= 0) {
        if (p.type.equals("disappear"))  // red platforms on bounce are removed
          toRemove.add(p);
          
        vy = UPWARDS_MAX; // bounce the player + and add particles
        vy = -abs(vy);
        animations.add(new Animation(this.x, this.y+20, "bounce"));
      }
    }
    
    // Remove the bounced red platforms.
    for (Platform p : toRemove) {platforms.remove(p);}
    
    // Possible lose condition - touches bottom of screen.
    if (y+r > height-SCREEN_OFFSET)  {
      if (!godmode)
        PLAYING=false;
      else 
        vy = -UPWARDS_MAX;
    } 
  }
  
  
  
  /** Given a platform, does the player collide with the platform's TOP EDGE **/
  /** Basic collision fails at higher velocities as platform is thin**/
  public boolean collideWith(Platform p) {
    if (IS_JETPACKING) {return false;} // ignore collisions in jetpack mode 
    
    double leftEdge = x-r;
    double rightEdge = x+r;
    double downEdge = y+r;
    double platformL = p.x-Platform.w/2;
    double platformR = p.x+Platform.w/2;
    double platformT = p.y;
    
    // if downwards vy, and the square is within the platform
    if ((vy >= 0 && downEdge > platformT && y < p.y) && ((platformL-leftEdge)*(leftEdge-platformR)>=0 || (platformL-rightEdge)*(rightEdge-platformR)>=0)) {
      vy = UPWARDS_MAX; 
      vy = -abs(vy);
      animations.add(new Animation(this.x, this.y+20, "bounce"));
      return true;
    }
    return false;
  }
  
  /** Given a monster, does the player collide with the monster **/
  /** Basic collision sufficient, as monsters are large enough.**/
  public boolean collideWith(Monster m) {
    if (IS_JETPACKING) {return false;}
    
    double leftEdge = x-r;
    double rightEdge = x+r;
    double topEdge = y-r;
    double downEdge = y+r;
    double monsterL = m.x-m.r;
    double monsterR = m.x+m.r;
    double monsterT = m.y-m.r;
    double monsterD = m.y+m.r;
    
    // if the square is within the platform
    if (((monsterL-leftEdge)*(leftEdge-monsterR)>=0 || (monsterL-rightEdge)*(rightEdge-monsterR)>=0) && ((monsterT-topEdge)*(topEdge-monsterD) >= 0 || (monsterT-downEdge)*(downEdge-monsterD) >= 0)) {
      vy = 0;
      fillColor = color(255, 0, 0);
      return true;
    }
    
    return false;
  }
  
  /** Given a powerup, does the player collide with it **/
  /** Basic collision sufficient, as powerup are large enough.**/
  public boolean collideWith(Powerup p) {
    if (IS_JETPACKING) {return false;}
    if (!PLAYING) {return false;}
    
    double leftEdge = x-r;
    double rightEdge = x+r;
    double topEdge = y-r;
    double downEdge = y+r;
    double powerupL = p.x-Powerup.w;
    double powerupR = p.x+Powerup.w;
    double powerupT = p.y-Powerup.w;
    double powerupD = p.y+Powerup.w;
    if (((powerupL-leftEdge)*(leftEdge-powerupR)>=0 || (powerupL-rightEdge)*(rightEdge-powerupR)>=0) && ((powerupT-topEdge)*(topEdge-powerupD) >= 0 || (powerupT-downEdge)*(downEdge-powerupD) >= 0)) {
      return true;
    }
    
    return false;
  }
  
  // Horizontal movement of the player    
  public void shiftLeft()   {x -= horizontal_push_speed; }
  public void shiftRight()  {x += horizontal_push_speed;}
}
