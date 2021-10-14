void drawLine(int x0, int y0, int x1, int y1) {
  float m = (1.0*(x1-x0))/(y1-y0);
  int x = x0;
  int y = y0;
  float xi = 0.0;
  point(x, y);
  while (y < y1) {
    y++;
    xi += m;
    if (xi > 0.5) {
      xi--;
      x++;
    }
    point(x, y);
  }
}  

void setup() {
  size(500, 500);
  for (int x = 0; x < width; x+= 40) {
    stroke(0, 0, 255);
    drawLine(0, 0, x, height);
    line(0, 0, x, height);
    stroke(255, 0, 0);
  }
}
