class Player {
  private final float UPWARDS_MAX = 13;
  private color       fillColor = color(255, 255, 255);
  public float        x;
  public float        y;
  private float       r = 30;
  private float       vy = UPWARDS_MAX;
  private float       push_speed = 6;
  
  // Constructor
  public Player(float x, float y) {
    this.x = x;
    this.y = y;
  }
  
  // Draw the player
  public void draw() {
    rectMode(RADIUS);
    fill(fillColor);
    stroke(fillColor);
    rect(this.x, this.y, r, r);
  }
  
  /* Move the player based on its vx, vy, and apply gravity.*/
  public void move() {
    vy += GRAVITY_CONSTANT/2;
    y += vy;    
    vy += GRAVITY_CONSTANT/2;
    
    // Wrap around
    if (x < 0)             {x = width;} 
    else if (x > width)    {x = 0;}
    
    // Lose condition - touches bottom
    if (y+r > height-SCREEN_OFFSET)  {PLAYING=false;} 
  }
  
  /** Given a platform, does the player collide with the platform's TOP EDGE **/
  public boolean collideWith(Platform p) {
    double leftEdge = x-r;
    double rightEdge = x+r;
    double topEdge = y-r;
    double downEdge = y+r;
    double platformL = p.x-Platform.w/2;
    double platformR = p.x+Platform.w/2;
    double platformT = p.y;
    double platformD = p.y-Platform.h;
    if ((vy >= 0 && downEdge > platformT && y < p.y) && ((platformL-leftEdge)*(leftEdge-platformR)>=0 || (platformL-rightEdge)*(rightEdge-platformR)>=0)) {
      vy = UPWARDS_MAX; 
      vy = -abs(vy);
      return true;
    }
    return false;
  }
   
  // On keypress, directly move the player.
  public void shiftLeft()   {x -= push_speed;}
  public void shiftRight()  {x += push_speed;}
}
