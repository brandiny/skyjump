float x = 100, y = 100;
float vx = 1.0;

void setup() {
  size(400, 300);
}

void mouseClicked() {
  if (vx != 0) {
    vx = 0;
  }
}
void draw() {
  background(0);
  
  // escape from edge
  if (x > width - 40 || x < 0) {
    vx *= -1;
  } 
  
  // fill with red if hovering over it
  if (mouseX <= x + 40 && mouseX >= x && mouseY <= y + 40 && mouseY >= y) {
    fill(255, 0, 0);
  } else {
    fill (0, 128, 255);
  }
 
  // move
  x += vx;
  rect(x, y, 40, 40); 
}
