// line(10,20,80,90);
// point(50, 50);

background(0);
stroke(255, 255, 0);

for (int i = 0; i < 1000; ++i) {
  line(random(0, width), random(0, height), random(0, width), random(0, height));
}

size(400, 300);
