size(400, 300);
noStroke();
background(255);


for (int i = 0; i < 1000; i++) {
  fill(random(0, 255), random(0, 70), random(0, 70));
  float rWidth = random(8, 10);
  float rHeight = random(5, height);
  //println("rWidth =", rWidth, "   rHeight=", rHeight);
  rect(random(0, width-rWidth), random(0, height-rHeight), rWidth, rHeight);
}
