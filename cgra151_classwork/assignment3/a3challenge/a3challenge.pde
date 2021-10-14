Button             clipButton = new Button(10, 10, 60, 30, "Clip");
ArrayList<PVector> polygon = new ArrayList<PVector>();
ArrayList<PVector> temp_polygon = new ArrayList<PVector>();
PVector            mouseStart;
PVector            mouseEnd;
PVector            selectedVertex;
PVector            infiniteLine = new PVector(350, 200);

void setup() {
  size(500, 500);
  frameRate(40);
  polygon.add(new PVector(100, 100));
  polygon.add(new PVector(200, 200));
  polygon.add(new PVector(100, 200));
}

void draw() {
  background(255);
  clipButton.draw();
  drawPolygon(polygon, false);        // the active polygon
  drawPolygon(temp_polygon, true);    // the previous polygon
  drawInfiniteLine();                 // the clipping line
}

/** On mouse press, check if the button is clicked, if so activate it.
 *  If not, find the nearest vertex, and select it.
 */
void mousePressed() {
  mouseStart = new PVector(mouseX, mouseY);
  if (mouseStart.x>=clipButton.x && mouseStart.x<=(clipButton.x+clipButton.w) && mouseStart.y>=clipButton.y && mouseStart.y<=(clipButton.y+clipButton.h)) {
    clipButton.activate();
    clipButton.addColor();
    return;
  }
  float minDistance = Float.MAX_VALUE;
  for (PVector v : polygon) {
     float distance =  dist(v.x, v.y, mouseStart.x, mouseStart.y);
     if (distance < minDistance) {
       minDistance = distance;
       selectedVertex = v;
     }
  }
}

/** As you drag the mouse, move the selected vertex...*/
void mouseDragged() {
  mouseEnd = new PVector(mouseX, mouseY);
  float deltaX = mouseEnd.x-mouseStart.x;
  float deltaY = mouseEnd.y-mouseStart.y;
  if (selectedVertex != null)
    selectedVertex.set(selectedVertex.x+deltaX, selectedVertex.y+deltaY);
  mouseStart = mouseEnd;
}

/** On mouse release, deselect the vertex **/  
void mouseReleased() {
  clipButton.removeColor();
  selectedVertex = null;
}




  
