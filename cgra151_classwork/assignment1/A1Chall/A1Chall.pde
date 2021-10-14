float offset = 0;
float radius = 10;  // radius of the individual circles
float centerX = 250;
float centerY = 250;
float ringRadius = 200; // radius of the entire circle ring
float circleCount = 10;
float degStep = TWO_PI / circleCount;

boolean goingIn = true;

// called once, at program startup
void setup() {
  size(500, 500);
  ellipseMode(CENTER);
  background(255);
}

// called once every frame
void draw() {
  
  // draw all the circles around the point (centerX, centerY)
  for (int count = 0; count < circleCount; ++count) {
    
    // when going inwards, reduce the radius of the circles from the center, but make the circles larger
    if (goingIn) {
      ringRadius -= 0.05;
      radius += 0.01;
    } 
    
    // when going outwards, increase the radius of the circles from the center, but make the circles smaller
    else {
      ringRadius += 0.05;
      radius -= 0.01;
    }
    
    // switch when the circles are > |300| pixels away from the center, about to leave the page
    if (ringRadius < -300) {goingIn = false;}
    if (ringRadius > 300) {goingIn = true;}
    
    
    // rotate the circles around and calculate the new radian position
    offset += 0.001;
    float rad = offset + degStep*count; 
    ellipse(centerX-ringRadius*cos(rad), centerY-ringRadius*sin(rad), radius, radius);  
  }
}
