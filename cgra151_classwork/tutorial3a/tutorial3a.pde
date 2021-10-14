float x1=50, y1=50, x2=250, y2=50, x3=250, y3=250, x4=50, y4=250;

void mouseDragged(){
 x1 = mouseX ;
 y1 = mouseY ;
}

void setup() {
  size(300, 500);
  frameRate(30);
}


void draw() {
  background(255);
  stroke(0);
  noFill();
  
  fill(0, 0, 0);
  ellipse(x1,y1,20,20);
  ellipse(x2,y2,20,20);
  fill(0, 0, 0);
  
  line(x1,y1, x2,y2);
  line(x3,y3, x4,y4);  
  
  float a = -(y4-y3);
  float b = (x4-x3);
  float c = x3*y4-y3*x4;
  float s = -(a*x1 + b*y1 + c) / (a*(x2-x1)+b*(y2-y1));
  float xi = (1-s)*x1 + s*x2;
  float yi = (1-s)*y1 + s*y2;
  fill(0,128,0);
  ellipse(xi,yi,10,10 );
  
  
}
