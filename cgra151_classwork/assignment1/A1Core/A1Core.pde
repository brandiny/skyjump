background(255);
size(500, 500);

int rectX = 40;        // the top left X coordinate of the blue rectangle
int rectY = 50;        // the top left Y coordinate of the blue rectangle
int rectWidth = 210;   // width of rectangle
int rectHeight = 100;  // the height of rectangle

// blue rect - drawn with left, top, width, height
fill(0, 0, 255);
rect(rectX, rectY, rectWidth, rectHeight);

// green ellipse - drawn with first two params as center point and last two as width and height
fill(0, 255, 0);
ellipse(rectX+rectWidth/2, rectY+rectHeight+rectHeight/2+50, rectWidth, rectHeight);

// red triangle - drawn with x1, y1, x2, y2, x3, y3
fill(255, 0, 0);
triangle(rectX, rectY+(rectHeight+50)*2+rectHeight/2, rectX+rectWidth/2, rectY+(rectHeight+50)*2, rectX+rectWidth, rectY+(rectHeight+50)*2+rectHeight);

// yellow arrow - with 
fill(255, 255, 0);
beginShape();
vertex(rectX+rectWidth+40, rectY+rectHeight/2);
vertex(rectX+rectWidth+40, rectY+rectHeight);
vertex(rectX+rectWidth+80, rectY+rectHeight);
vertex(rectX+rectWidth+80, rectY+rectHeight+40);
vertex(rectX+2*rectWidth+10, rectY+rectHeight/2+rectHeight/4);
vertex(rectX+rectWidth+80, rectY);
vertex(rectX+rectWidth+80, rectY+rectHeight/2);
endShape(CLOSE);

// orange stroke line
strokeWeight(4);
stroke(255, 65, 0);
line(rectX+rectWidth+40, rectY+rectHeight/2 + rectHeight + 50, rectX+rectWidth+80, rectY+(rectHeight+50)*2+rectHeight);

// green stroke line
strokeWeight(8);
stroke(0, 255, 0);
line(rectX+rectWidth+40+40, rectY+rectHeight/2 + rectHeight + 50, rectX+rectWidth+80+40, rectY+(rectHeight+50)*2+rectHeight);

// green stroke line
strokeWeight(14);
stroke(120, 0, 255);
line(rectX+rectWidth+40+40+40, rectY+rectHeight/2 + rectHeight + 50, rectX+rectWidth+80+40+40, rectY+(rectHeight+50)*2+rectHeight);
