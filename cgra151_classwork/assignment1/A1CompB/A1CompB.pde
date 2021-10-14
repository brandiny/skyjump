int numTriangles = 1000; // number of triangles on screen
int triangleSize = 50; // how much each vertex of the triangle can deviate from initial.
size(500, 500); // 500x500

// draw all triangles
for (int i = 0; i < numTriangles; ++i) {
  // choose random initial point
  int initialX = random(0, width);
  int initialY = random(0, height);
  
  // initial vertex is at (xi, yi)
  // subsequent vertices are at (xi + k, yi + j)
  // where k, and j, are random numbers from [-triangleSize, triangleSize]
  triangle(initialX, initialY, initialX + random(-triangleSize, triangleSize), initial + random(-triangleSize, triangleSize), initialX + random(-triangleSize, triangleSize), initial + random(-triangleSize, triangleSize));
