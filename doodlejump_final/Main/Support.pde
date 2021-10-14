// Source of line intersection algorithm - https://bryceboe.com/2006/10/23/line-segment-intersection-algorithm/
// This is used over the one provided as it is faster.  
// is slope of p0->p1 less than p0->p2
boolean ccw(float x0, float y0, float x1, float y1, float x2, float y2) {
  return (y2-y0)*(x1-x0) > (y1-y0)*(x2-x0); // rearrangement of (y2-y0)/(x2-x0) > (y1-y0)/(x1-x0)
}

// Finds intersection between 2 lines made from 4 points
boolean intersects(float x0, float y0, float x1, float y1, float x2, float y2, float x3, float y3) {                                                                                    
  return ccw(x0, y0, x2, y2, x3, y3) != ccw(x1, y1, x2, y2, x3, y3) && ccw(x0, y0, x1, y1, x2, y2) != ccw(x0, y0, x1, y1, x3, y3);
}


/**
 * Depending on the booleans of keypresses, move the player.
 */
void handleKeyPresses() {
  if (LEFT_PRESSED) {player.shiftLeft();}
  if (RIGHT_PRESSED) {player.shiftRight();}
  if (SPACE_PRESSED && !IS_JETPACKING && abs(player.vy)<player.UPWARDS_MAX) { // shooting logic
  
    // if you have no ammo, and haven't reloaded - set reload finish time
    if (AMMO_REMAINING == 0 && !RELOADING) { 
      RELOADING = true;
      last_bullet_spawn = millis() + RELOAD_TIME;
    }
     
    // if finished reloading, refill the ammo   
    if (millis() - last_bullet_spawn > BULLET_COOLDOWN && RELOADING) {
        RELOADING = false;
        AMMO_REMAINING = 10;
    }
    
    // otherwise, allow the player to shoot iff the time between last bullet shot is less than the cooldown.
    if (millis() - last_bullet_spawn > BULLET_COOLDOWN && !RELOADING) {
      int bullet_velocity = 15;
      
      // single shot fire in a straight line 
      if (player.gun_level == 1) {
        bullets.add(new Bullet(player.x, player.y, 0, -bullet_velocity));
      } 
      
      // 3 spray shot in a tight cone 
      if (player.gun_level == 2) {
        bullets.add(new Bullet(player.x, player.y, 0, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 1, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -1 , -bullet_velocity));
      }
      
      // 3 spray shot in a wide line
      if (player.gun_level == 3) {
        bullets.add(new Bullet(player.x, player.y, 0, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 10, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -10 , -bullet_velocity));
      }
      
      // 5 spray shot 
      if (player.gun_level == 4) {
        bullets.add(new Bullet(player.x, player.y, 0, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 10, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -10 , -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 1, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -1 , -bullet_velocity));
      }
      
      // 7 spray shot - with horizontal bullets
      if (player.gun_level >= 5) {
        bullets.add(new Bullet(player.x, player.y, 0, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -15, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 15 , -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -30, -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, 30 , -bullet_velocity));
        bullets.add(new Bullet(player.x, player.y, -bullet_velocity, 0));
        bullets.add(new Bullet(player.x, player.y, bullet_velocity , 0));
      }
      
      last_bullet_spawn = millis();
      AMMO_REMAINING--;
    }
  }
}

/**
 * Make new platforms
 * If the highest platform is visible, keep creating platforms until it you go offscreen
 */
void makeNewPlatforms() {
  // If no platform availiable, seed it with one
  if (platforms.size()==0) {
    platforms.add(new Platform(random(0, width-Platform.w), 40));
  }
  
  // Generate platforms until offscreen.
  while (platforms.get(platforms.size()-1).y>-SCREEN_OFFSET) {
    String type = "normal"; // fallback type;
    
    
    // probability density function of MOVING is a +ve logarithmic function,  
    double y = SCREEN_OFFSET;
    double p_moving = log(((y) <= 0  ? 1.0 : (float)(y)))/20;
    
    // probability density function of DISAPPEAR is a +ve logarithmic function, with a higher growth rate --> red takes over eventually.  
    double DISAPPEAR_START = 8000;
    double p_disappear = log(((y-DISAPPEAR_START) <= 0  ? 1.0 : (float)(y-DISAPPEAR_START)))/15;
    
    // determine the type of platform to spawn
    double rng = random(0.0, 1);
    if (rng <= p_moving) {type = "moving";}
    if (rng <= p_disappear) {type = "disappear";}
    
    // calculate the position to spawn the platform
    float platformx = random(0, width-Platform.w);
    float platformy = platforms.get(platforms.size()-1).y-GAP;
    
    // if we decide to spawn a powerup... only on non moving platforms.
    float spawn_rate_of_powerups = 0.5; 
    if (!type.equals("moving") && rng < spawn_rate_of_powerups) {
        double rng2 = random(0.0, 1);
        if (0 <= rng2 && rng2 <= 0.3) { // 0.3 it will be a spring
          powerups.add(new Powerup(platformx+random(-Platform.w/2, Platform.w/2), platformy-Powerup.w, "spring"));
        } else if (0.3 <= rng2 && rng2 <= 0.65) { // 0.35 it will be shoes
          powerups.add(new Powerup(platformx, platformy-Powerup.w, "shoes"));
        } else if (0.65 <= rng2 && rng2 <= 0.9) { // 0.35 it will be a gun
          powerups.add(new Powerup(platformx, platformy-Powerup.w, "gun")); 
        } else if (0.9 <= rng2) { // 0.1 it will be a jetpack
          powerups.add(new Powerup(platformx, platformy-Powerup.w, "jetpack"));
        }
    } 
    
    platforms.add(new Platform(platformx, platformy, type));
    GAP += GAP_GROWTH;
  }
}

/**
 * Platforms that are below the screen are removed
 */
void removeOldPlatforms() {
  if (platforms.size() > 0) {
    while (platforms.get(0).y > height-40-SCREEN_OFFSET) { // we can do this as platforms is sorted by ascending height.
      platforms.remove(0);
    }
  }
}

/**
 * If the player crosses the centerline, the screen view is shifted. true if a shift happened
 */
boolean shiftCamera() {
  double error = height/1.7-SCREEN_OFFSET - player.y; // PID system
  double k = 0.1; // higher k is more jittery
  int shift = max(0, (int)(k*error));
  SCREEN_OFFSET += shift;
  if (shift > 0) {
    return true;
  } else {
    return false;
  }
}
 
 
/**
 * Move the platforms. 
 */
void movePlatforms() {
  for (Platform p : platforms) {
    p.move();
  }
}

/**
 * Draw platforms 
 */
void drawPlatforms() {
  for (Platform p : platforms) {
      p.draw();
  }
}

/**
 * Draw bullets
 */
void drawBullets() {
  for (Bullet b : bullets) {
      b.draw();
  }
}

/** Moves the bullets and deletes if necessary **/
void moveBullets() {
  ArrayList<Bullet> toRemoveBullets = new ArrayList<Bullet>();
  for (Bullet b : bullets) {
    b.move();
    if (b.y < -SCREEN_OFFSET) {
      toRemoveBullets.add(b);
    }
  }
  
  for (Bullet b : toRemoveBullets) {
    bullets.remove(b);
  }    
}
    
/** Draws the scoreboard, proportional to height **/
void drawScoreboard() {
  textSize(20);
  fill(0, 0, 83);
  stroke(0, 0, 83);
  
  int scoreboard_height = 40;
  rectMode(CORNER);
  rect(0, height-scoreboard_height, width, height-scoreboard_height);
  
  int wavegap = 50;
  for (float x=-SCOREBOARD_WAVE_SHIFT%50; x<width; x+=wavegap) {
    curve(x, height+scoreboard_height, x, height-scoreboard_height, x+wavegap, height-scoreboard_height, x+wavegap, height+scoreboard_height); 
  }
  
  fill(255, 255, 255);
  if (PLAYING) {
    text(SCORE, 40, height-10);
    if (!RELOADING)
      text("Ammo: " + AMMO_REMAINING, width-150, height-10);
    else
      text("Reloading...", width-150, height-10);
  } else {
    text("You lose", 40, height-10);
    PLAYING = false;
  }
}

/**
 * Make new monsters
 * 
 */
void makeNewMonsters() {
    double rng = random(0.0, 1);
    double rng2 = random(0.0, 1);
    String type = "none";
    if (monsters.size()<MAX_MONSTERS_ON_SCREEN) {
      if (rng <= 0.008) { // 0.8% chance it spawns whenever you cross the mid line
        if (rng2 <= 0.75) { // 75% chance it spawns as a stationary enemy
          type = "normal";
        }
        else {
          type = "moving"; // 25% chance it is moving
        }
      }
    }
    
    if (!type.equals("none"))
      monsters.add(new Monster(random(0, width-20), -SCREEN_OFFSET-100, type));
}

/**
 * Platforms that are below the screen are removed
 */
void removeOldMonsters() {
  while (monsters.size() != 0 && monsters.get(0).y > height-40-SCREEN_OFFSET) {
    monsters.remove(0);
  }
}

/**Move monsters **/
void moveMonsters() {
  for (Monster m : monsters) {
    m.move();
    if (player.collideWith(m)) {
      PLAYING = godmode ? true : false; //  you lose on collision with a monster
    }
  }
}

/**Draw monsters **/
void drawMonsters() {
  for (Monster m : monsters) {
    m.draw();
  }
}

/** Draw powerups **/
void drawPowerups() {
  for (Powerup p : powerups) {
    p.draw();
  }
}

/**Remove old powerups**/
void removePowerups() {
  ArrayList<Powerup> toRemove = new ArrayList<Powerup>();
  for (Powerup p : powerups) {
    if (player.collideWith(p)) {
      // Powerup buffs
      if (p.type.equals("jetpack")) {
        IS_JETPACKING = true;
        JETPACKING_END = millis()+1000;
      } else if (p.type.equals("spring")) {
        player.vy = -player.UPWARDS_MAX*1.5;
      } else if (p.type.equals("shoes")) {
        player.UPWARDS_MAX += 1;
        player.r = max(player.r-1, 9); // to prevent player from getting too small
      } else if (p.type.equals("gun")) {
        player.gun_level++;
      }
      
      toRemove.add(p);
    }
  }
  
  for (Powerup p : toRemove) {
    powerups.remove(p);
  } 
}

// Draws the background lines
void drawBackground() {
  color bgcolor = color(255, 255, 238);
  color bgstroke = color(200, 160, 80);
  background(bgcolor); 
  stroke(bgstroke);
 
  // draw the lines.
  pushMatrix();
    int step = 20;
    for (int y=0; y<height; y+=step)
      line(0, y, width, y); 
      
    for (int x=0; x<width; x+=step)
      line(x, 0, x, height); 
  popMatrix();
}

/** All animations in the animation queue will be drawn **/
void drawAnimations() {
  ArrayList<Animation> toRemove = new ArrayList<Animation>();
  for (Animation a : animations) {
    a.draw();
    if (a.finished()) {
      toRemove.add(a);
    }
  }
  for (Animation a : toRemove) {
    animations.remove(a);
  }
}
