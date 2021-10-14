int radius = 70; // radius of the circle 
int FPS = 60; // frame rate of program
int bgcolor = 120; // background color (bgcolor, bgcolor, bgcolor) - monochrome
// run once on startup
void setup() {
  size(400, 300);
  frameRate(FPS);
}

// run every frame
void draw() {
  background(bgcolor); 
  
  // when mouse pressed, fill with red
  if (mousePressed) {
    fill(255, 0, 0);
  } 
  
  // otherwise fill with a purple
  else { 
    fill(50, 0, 255);
  }
  
  // draw the ellipse at the mouse, so that it moves with the mouse.
  ellipse(mouseX, mouseY, radius, radius);
}
