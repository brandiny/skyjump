// bat variables
float batWidth = 100;
float batHeight = 40;

// circle position and speed variables
float r = 40;
float x = 200;
float y = 200;
float vx = 5;
float vy = 5;

// screen variables
int screenwidth = 600;
int screenheight = screenwidth;

// variables for the game blocks
float num_blocks_x = 5;
float num_blocks_y = 4;
float gap = 15;
float blockwidth = (screenwidth-gap*(1+num_blocks_x))/num_blocks_x;
float blockheight = 40;
Block[] blocks = new Block[(int)(num_blocks_x*num_blocks_y)];


// create all the green blocks on the screen.
void setup() {
  size(600, 600);
  for (int y = 0; y < num_blocks_y; ++y) {
    for (int x = 0; x < num_blocks_x; ++x) {
      blocks[(int)(y*num_blocks_x+x)] = new Block((int)(gap*(x+1)+blockwidth*x+blockwidth/2),(int)(gap*(y+3) + y*blockheight), (int)(blockwidth), (int)(blockheight));
    }
  }
}

void draw() {
  background(0);
  
  // draw the game blocks
  for (Block b : blocks) {
    b.drawBlock();
  }
  
  
  // draw the bat
  fill(255, 255, 255);
  rectMode(RADIUS);
  rect(mouseX, mouseY, batWidth/2, batHeight/2);


  // draw the circle
  x += vx;
  y += vy;
  ellipseMode(RADIUS);
  ellipse(x, y, r, r);
  
  
  // 4 edges of the screen boundary checking with ball
  if (x+r > width) {vx = abs(vx) * -1;}
  if (x-r < 0) {vx = abs(vx);} 
  if (y+r > height) {vy = abs(vy) * -1;}
  if (y-r < 0) {vy = abs(vy);}
  
  
  // bat to ball boundary checking
  if ((x-(mouseX-batWidth/2))*(x-(mouseX-batWidth/2)) + (y-(mouseY-batHeight/2))*(y-(mouseY-batHeight/2)) < r*r) { // top-left corner 
    vx = abs(vx)*-1;
    vy = abs(vy)*-1;
  } else if ((x-(mouseX-batWidth/2))*(x-(mouseX-batWidth/2)) + (y-(mouseY+batHeight/2))*(y-(mouseY+batHeight/2)) < r*r) {  // bottom-right
    vx = abs(vx)*-1;
    vy = abs(vy)*1;
  } else if ((x-(mouseX+batWidth/2))*(x-(mouseX+batWidth/2)) + (y-(mouseY-batHeight/2))*(y-(mouseY-batHeight/2)) < r*r) { // top-right
    vx = abs(vx)*1;
    vy = abs(vy)*-1;
  } else if ((x-(mouseX+batWidth/2))*(x-(mouseX+batWidth/2)) + (y-(mouseY+batHeight/2))*(y-(mouseY+batHeight/2)) < r*r) { // bottom-right
    vx = abs(vx)*1;
    vy = abs(vy)*1;
  } else if (x+r > mouseX-batWidth/2 && x-r < mouseX-batWidth/2 && y>mouseY-batHeight/2 && y<mouseY+batHeight/2) { // left 
    vx = abs(vx)*-1;
  } else if (x+r > mouseX+batWidth/2 && x-r < mouseX+batWidth/2 && y>mouseY-batHeight/2 && y<mouseY+batHeight/2) { // right
    vx = abs(vx);
  } else if (y-r < mouseY+batHeight/2 && y+r > mouseY+batHeight/2 && x>mouseX-batWidth/2 && x<mouseX+batWidth/2) { // bottom
    vy = abs(vy); 
  } else if (y+r > mouseY-batHeight/2 && y-r < mouseY-batHeight/2 && x>mouseX-batWidth/2 && x<mouseX+batWidth/2) { // top
    vy = abs(vy)*-1;
  } 
  
  // block to ball collision detection
  for (Block b : blocks) {
    b.detectCollision();
  }
}

/**
 * A block that when hit by a ball, will reflect the ball, and change the colour of the ball
 */
class Block {
  private int blockwidth;
  private int blockheight;
  private int blockx;
  private int blocky;
  private int hitcount = 0; // 0 = green, 1 = yellow, 2 = red, >3 = transparent
  
  public Block(int blockx, int blocky, int blockwidth, int blockheight) {
     this.blockx = blockx;
     this.blocky = blocky;
     this.blockwidth = blockwidth;
     this.blockheight = blockheight;
  }
    
  // draws the block on screen
  public void drawBlock() {
    rectMode(RADIUS);
    if (hitcount == 0) {fill(0, 255, 0);} // green
    else if (hitcount == 1) {fill(255, 255, 0);} // yellow 
    else if (hitcount == 2) {fill(255, 0, 0);} // red
    else {fill(0, 0, 0);} // black (can't see it)
    rect(blockx, blocky, blockwidth/2, blockheight/2);
  }
  
  // changes the color, and the balls direction if collided.
  public void detectCollision() {
    if (hitcount >= 3) {return;}
    
    if (x+r > blockx-blockwidth/2 && x-r < blockx-blockwidth/2 && y>blocky-blockheight/2 && y<blocky+blockheight/2) {
      vx = abs(vx)*-1;
      hitcount++;
    } 
    
    if (x+r > blockx+blockwidth/2 && x-r < blockx+blockwidth/2 && y>blocky-blockheight/2 && y<blocky+blockheight/2) {
      vx = abs(vx);
      hitcount++;
    } 
    
    if (y-r < blocky+batHeight/2 && y+r > blocky+batHeight/2 && x>blockx-blockwidth/2 && x<blockx+blockwidth/2) {
      vy = abs(vy);
      hitcount++;
    }
    
    if (y+r > blocky-blockheight/2 && y-r < blocky-blockheight/2 && x>blockx-blockwidth/2 && x<blockx+blockwidth/2) {
      vy = abs(vy)*-1;
      hitcount++;
    } 
  }
}
    
  
  
 
