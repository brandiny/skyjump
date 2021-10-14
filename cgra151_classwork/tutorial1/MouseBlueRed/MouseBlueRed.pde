void setup() {
  size(400, 300);
  frameRate(24);
}

void draw() {
  background(0);
  if (mousePressed) {
    fill(255, 0, 0);
  } else {
    fill(0, 0, 255);
  }
  ellipse(mouseX, mouseY, 40, 40);
}
