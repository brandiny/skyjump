size(400, 300);
background(255);
noStroke();
for (int i=0; i<10000; i++) {
   float eRadius = 20;
   fill(random(0, 255), random(0, 255), random(0, 255) );
   ellipse(random(eRadius, width-eRadius), random(eRadius, height-eRadius), eRadius*2, eRadius*2);
}
