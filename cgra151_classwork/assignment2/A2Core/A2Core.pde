// bat variables
float batWidth = 100;
float batHeight = 40;

// circle position and speed variables
float r = 40;
float x = 200;
float y = 200;
float vx = 5;
float vy = 5;

// create all the green blocks on the screen.
void setup() {
  size(600, 600);
}

void draw() {
  background(0);
  
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
}


  
 
