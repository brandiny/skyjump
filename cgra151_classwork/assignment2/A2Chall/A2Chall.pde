void setup() {
  size(500, 500);
  noSmooth();
}

void draw() {
  int gap = 10; // vertical gap between the lines
  int y0 = 0; // tracks the current y of the line
  int gapdiff = 1; // how much further down y1 is.
  
  // draws the line until the gradient is > 1
  while((y0+gap*gapdiff-y0)/width < 1) {
    stroke(0, 0, 255);
    line(0, y0, width, y0+gap*gapdiff);
    stroke(255, 0, 0);
    
    drawLine(0, y0, width, y0+gap*gapdiff);
    y0 += gap;
    gapdiff += 2;
  }
}

// dda line algorithm for octant 1, 0 < m < 1;
void drawLine(float x0, float y0, float x1, float y1) {
    float m = (y1 - y0)/(x1 - x0);
    if (m > 0 && m <= 1) {
      int x = round(x0);
      float yi = y0 + m*(x-x0);
      int y = round(yi);
      float yf = yi - y;
      while(x != x1) {
        point(x, y);
        x++;
        yf += m;
        if (yf >= 0.5) {
          y++;
          yf--;
      }
    }
  } 
}
  
