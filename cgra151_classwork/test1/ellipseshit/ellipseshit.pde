size(300, 300);
int[] vals = new int[]{10, 30, 60, 150, 210, 280};
for (int i : vals) {
   line(i, 0, i, 300);
   line(0, i, 300, i);
}
ellipseMode(LEFT);
ellipse(60, 60, 90, 90);  
ellipse(150, 60, 130, 90);
ellipse(60, 150, 90, 130);
