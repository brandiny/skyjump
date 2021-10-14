float brickHeight = 25; // height of each brick on each row
float gap = 5; // the gap between each brick
float randStart = 0; // minimum width of a brick
float randEnd = 40; // maximum width of a brick

background(100); // grey background
size(500, 500); // 500x500 window

// create a row of bricks from the top of the screen to the bottom
for (int i = 0; i < height/brickHeight; ++i) {
  int x = 0; // this variable tracks the X coordinate of the current brick
  
  // keep laying bricks, until you reach the end of the row.
  while (x < width) {
    float w = random(randStart, randEnd); // give each brick a random width
    rect(x, brickHeight*i, w, brickHeight);
    x += gap + w; // shift the X coordinate the accomodate for width and gap.
  }  
}
  
