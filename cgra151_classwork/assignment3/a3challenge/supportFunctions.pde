/**
 * Draws the polygon
 */
void drawPolygon(ArrayList<PVector> polygon_list, boolean isTemp) {
  int   circle_radius   = 20;
  color circle_color    = color(0, 0, 255);
  color circle_coloralt = color(255, 0, 0);
  int   edge_thickness  = 3;
  color edge_color      = color(0, 0, 0);
  color edge_color_alt  = color(255, 0, 0);
  
  // draws the edges of the polygon
  noFill();
  stroke(isTemp ? edge_color_alt : edge_color);
  strokeWeight(isTemp ? 1 : edge_thickness);
  beginShape();
  for (PVector p : polygon_list) {
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
  
  // draws the circles of the polygon
  if (!isTemp) {
    ellipseMode(CENTER);
    for (PVector p : polygon_list) {
      fill(p.equals(selectedVertex) ? circle_coloralt : circle_color);
      ellipse(p.x, p.y, circle_radius, circle_radius);
    }
  }
}

/**
 * Draws the infinite clipping line
 */
void drawInfiniteLine() {
  stroke(200);
  strokeWeight(2);
  line(infiniteLine.x, infiniteLine.y-2000, infiniteLine.x, infiniteLine.y+2000);
}

/**
 * Clips the polygon
 */
void clipThePolygon() {
    float y0 = infiniteLine.y*-500;
    float y1 = infiniteLine.y*500;
    float a = y0-y1;
    float b = 0;
    float c = infiniteLine.x*y1-infiniteLine.x*y0;
    
    ArrayList<PVector> newPolygon = new ArrayList<PVector>();
    for (int i=0; i<polygon.size(); ++i) {
      PVector start = polygon.get(i);
      PVector end   = polygon.get((i+1) % polygon.size());
      float   ks    = a*start.x + b*start.y + c; // is the starting point in front of the clip line or behind
      float   ke    = a*end.x + b*start.y + c; // is the end point in front or behind clip line.
      
      // if both start and end in front of clip line, include it
      if (ks > 0 && ke > 0) {
        newPolygon.add(new PVector(start.x, start.y));
      } 
      
      // if both of them are behind the clip line, remove it
      else if (ks < 0 && ke < 0) {
        continue;
      } 
      
      // else, find the intersection, and include it.
      else {
        float t = (a*start.x + c)/(a*(start.x-end.x)+b*(start.y-end.y));
        PVector intersection = new PVector(start.x*(1-t)+end.x*t, start.y*(1-t)+end.y*t);
        if (ks >= 0) {
          newPolygon.add(new PVector(start.x, start.y));
        }
        
        newPolygon.add(intersection);
      }
    }
    
    // set the polygon as the tempArray we had.
    temp_polygon = polygon;
    polygon = newPolygon;
 }
 
