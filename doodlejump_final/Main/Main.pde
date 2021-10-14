/**
 * Sky jump
 */
 
// For the marker
boolean godmode = false;

String            PLAYER_NAME = ""; // Name of player to save to leaderboard

final float       GRAVITY_CONSTANT = 0.5;       // How fast the player falls.
float             SCORE = 0;
float             SCREEN_OFFSET = 0;            // Camera position from bottom of screen
float             GAP = 50;                     // Current distance between platforms
final float       GAP_GROWTH = 0.25;            // How quickly the gap between platforms grows
final float       CAMERA_SPEED = 5;             // How fast the camera moves, when the player crosses mid point.  
boolean           PLAYING = true;               // Is the game in action?
int               restart_delay = 0;            // Used to create a delay after losing, before restarting.


boolean           RELOADING = false;            // Is the player currently reloading? Then disallow shooting
final int         RELOAD_TIME = 1000;           // How long the player takes to reload
int               AMMO_REMAINING = 10;          // Remaining bullets before reloading
int               BULLET_COOLDOWN = 200;        // Minimum delay before shooting next bullet
int               last_bullet_spawn = 0;        // When the last bullet was shot (milliseconds)

boolean           LEFT_PRESSED = false;         // Is left button pressed
boolean           RIGHT_PRESSED = false;        // Is right button pressed
boolean           SPACE_PRESSED = false;        // Is space button pressed

int               JETPACKING_END = 0;           // In milliseconds, when the jetpack will end
boolean           IS_JETPACKING = false;        // Is the player being jetpacked right now?

// Miscellaneous
boolean           SHOW_TITLE_SCREEN = true;     // display the title screen
int               SCOREBOARD_WAVE_SHIFT = 0;    // current parameter of the leaderboard wave.
final int         MAX_MONSTERS_ON_SCREEN = 3;   // as variable suggests


// Gameplay objects
Player player;                                                   // main player object
Leaderboard leaderboard;                                         // leaderboard data
ArrayList<Platform> platforms   = new ArrayList<Platform>();     // platforms on screen
ArrayList<Bullet>   bullets     = new ArrayList<Bullet>();       // bullets on screen
ArrayList<Monster>  monsters    = new ArrayList<Monster>();      // monsters on screen
ArrayList<Powerup>  powerups    = new ArrayList<Powerup>();      // powerups on screen
ArrayList<Animation> animations = new ArrayList<Animation>();    // animation queue, what is currently happening
PImage title_screen;

/** Call this to restart game **/
void setup() {
  size(400, 700);  // 400x700 screen
  title_screen = loadImage("title.png");
  
  // Reset parameters
  leaderboard = new Leaderboard();
  platforms.clear();
  powerups.clear();
  monsters.clear();
  SCREEN_OFFSET = 0;
  SCORE = 0;
  GAP = 50;
 
  // Construct the initial platforms
  for (int y=height; y>=0; y-=GAP) 
    platforms.add(new Platform(random(0, width-Platform.w), y));
  
  // Construct the player
  player = new Player(platforms.get(2).x, platforms.get(2).y-20);
}


/** Main drawing loop **/
void draw() {
  
  // Draw the title screen
  if (SHOW_TITLE_SCREEN) {
    image(title_screen, 0, 0);
    fill(0);
    
    int fontsize = 20;
    float textx = width/2-textWidth(PLAYER_NAME)/2;
    int texty = 600;
    textSize(fontsize);
    text(PLAYER_NAME, textx, texty);
    line(50, texty+5, 350, texty+5); 
    text("To return to the menu, press q", 45, 650);
    return; // Do not display game
  }
  
  // Check if you have lost -  if you have, wait 50 ticks before restarting.
  if (!PLAYING) {
    restart_delay++;
    if (restart_delay > 50) {
      println(SCORE);
      leaderboard.addScore(PLAYER_NAME, (int)SCORE);
      setup();
      restart_delay = 0;
      PLAYING = true;
    }
  }
  
  // Draw the background, and move the screen up slowly
  drawBackground();
  SCREEN_OFFSET += IS_JETPACKING ? 0 : 1;
  
  // Handle the user keypresses
  handleKeyPresses();
  
  // Draw the leaderboard;
  leaderboard.draw();
  
  // Make new platforms - just above the top of the screen
  // Destroy old platforms - below the bottom of the screen.
  makeNewPlatforms();
  removeOldPlatforms();
  
  // Powerups that collide with the player are removed.
  removePowerups();
  
  // Move screen up, if the player crosses the centerline
  // If the screen moves up, Make new enemies - fill the top
  // Destroy old enemies below the bottom of the screen.
  if(shiftCamera()) {
    makeNewMonsters();
    removeOldMonsters();
  }
  
    
  // Move the screen to the correct position
  pushMatrix();
  translate(0, SCREEN_OFFSET);
    
    // If jetpacking, keep the players velocity at terminal;
    if (millis()<JETPACKING_END) {
      float jetpack_speed = 20;
      player.vy = -jetpack_speed;
      shiftCamera();
    } else {
      IS_JETPACKING = false;
    }
    
    // Move the player - e.g gravity and its current vx, vy
    player.move();
    player.draw();
    
    // Draw the platforms, and check for collision
    movePlatforms();
    drawPlatforms();
    
    // Draw the powerups    
    drawPowerups();
    
    // Move bullets, and delete if necessary
    moveBullets();
    drawBullets();
     
    // Draw monsters
    moveMonsters();
    drawMonsters();
    
    // Do animations
    drawAnimations();
    
  popMatrix();
  
  // Draw scoreboard at the bottom of the screen.
  drawScoreboard();
  SCOREBOARD_WAVE_SHIFT++;
}

/** On key press, toggle the keypressed booleans **/
void keyPressed() {
  if (SHOW_TITLE_SCREEN) {
    if (keyCode==ENTER && !PLAYER_NAME.equals("")) {SHOW_TITLE_SCREEN = false; return;}
    if (keyCode==BACKSPACE || keyCode==DELETE) {
      if (PLAYER_NAME.length() > 0) {
        PLAYER_NAME = PLAYER_NAME.substring(0, PLAYER_NAME.length()-1);
      }
      return;
    }
    
    String myString = key==' ' || keyCode==LEFT || keyCode == RIGHT || keyCode == RETURN || keyCode == TAB ? "" : Character.toString(key);
    if(!myString.matches("[A-Za-z0-9]+")) {myString = "";}
    if (PLAYER_NAME.length() < 15) {
      PLAYER_NAME += myString;
    }
  }
  
  if (key=='q')       {setup(); SHOW_TITLE_SCREEN = true;}
  if (keyCode==LEFT || key=='a')  {LEFT_PRESSED = true;}
  if (keyCode==RIGHT || key=='d') {RIGHT_PRESSED = true;}
  if (key==' ' || key=='w')       {SPACE_PRESSED = true;}
}

/** On key release, toggle the keypressed booleans **/
void keyReleased() {
    if (keyCode==LEFT || key=='a')  {LEFT_PRESSED = false;}
    if (keyCode==RIGHT || key=='d') {RIGHT_PRESSED = false;}
    if (key==' ' || key=='w')       {SPACE_PRESSED = false;}
}
