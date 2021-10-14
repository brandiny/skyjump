float x1=50, y1=50, x2=250, y2=50, x3=250, y3=250, x4=50, y4=250;
float t=0.5;
boolean forwards = true;

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
  strokeWeight(30);
  bezier(x1, y1, x2, y2, x3, y3, x4, y4);
  
  float x = bezierPoint(x1, x2, x3, x4, t);
  float y = bezierPoint(y1, y2, y3, y4, t);
  float xTangent = bezierPoint(x1, x2, x3, x4, t);
  float yTangent = bezierPoint(y1, y2, y3, y4, t);
  
  noStroke();
  fill(255, 0, 0);
  

  float angle = atan2(yTangent, xTangent);
  translate(x, y);
  rotate(angle);
  beginShape();
   vertex(0,0);
   vertex(-10,-10);
   vertex(30,0);
   vertex(-10,10);
  endShape(CLOSE);
  
  if (forwards)
    t += 0.1;
  else 
    t -= 0.1;
   
  if (t>1) forwards = false;
  else if (t<0) forwards = true;
  
}
