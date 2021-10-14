final float       GRAVITY_CONSTANT = 0.5;       // The higher this is, the faster the player falls.
float             SCREEN_OFFSET = 0;            // This increases as the player moves up - THIS IS THE SCORE
float             GAP = 50;                     // Current distance between platforms - grows as game gets harder
float             CAMERA_SPEED = 5;             // How fast the camera moves if you jump higher                 
boolean           PLAYING = true;


// Gameplay objects
Player              player; 
ArrayList<Platform> platforms = new ArrayList<Platform>();   // start of array=bottom of screen, end of array=top of screen


void setup() {
  size(400, 700);
  background(0);
  
  // Construct the initial platforms
  for (int y=height; y>=0; y-=GAP) 
    platforms.add(new Platform(random(0, width-Platform.w), y));
  
  // Construct the player
  player = new Player(platforms.get(2).x, platforms.get(2).y-20);
}

/** Main drawing loop **/
void draw() {
  background(0);
  
  // Check for a key press.
  if (keyPressed) {
    if (keyCode==LEFT) {
      player.shiftLeft();
    } else if (keyCode==RIGHT) {
      player.shiftRight();
    } else if (keyCode==UP) {
    }
  }

  // Make new platforms
  // - If the highest platform is visible, keep creating platforms until it you go offscreen
  while (platforms.get(platforms.size()-1).y>-SCREEN_OFFSET) {
    platforms.add(new Platform(random(0, width-Platform.w), platforms.get(platforms.size()-1).y-GAP));
    GAP += 1;
  }

  // Destroy old platforms below the bottom of the screen.
  if (platforms.size() > 0) {
    while (platforms.get(0).y > height-SCREEN_OFFSET) {
      platforms.remove(0);
    }
  }


  // Move screen up, if the player crosses the centerline
  if (player.y < height/2-SCREEN_OFFSET) {
    SCREEN_OFFSET += CAMERA_SPEED;
  }
  
  // Move the screen to the correct position
  pushMatrix();
  translate(0, SCREEN_OFFSET);
  
    // Move the player - e.g gravity and its current vx, vy
    player.move();
    player.draw();
  
    // Draw the platforms, and check for collision
    for (Platform p : platforms) {
      player.collideWith(p);
      p.draw();
    }   
  popMatrix();
  
  // Draw scoreboard
  textSize(20);
  fill(255, 255, 0);
  rect(0, height-40, width, height-40);
  fill(0, 0, 0);
  
  if (PLAYING) {
    text(SCREEN_OFFSET, 40, height-10);
  } else {
    text("You lose", 40, height-10);
  }
}
