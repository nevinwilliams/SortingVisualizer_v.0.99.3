void displayMenuScreen(){
 
  background(0,0,0,10);

fill(0,0, 100, 100);
strokeWeight(1);
 rectMode(CENTER);
 textAlign(CENTER,CENTER);
 
 float rowTracker = 0;
 float headerX = width/2.0;
 float headerY = height/30.0;
 textSize(headerY*2);
 text("(Yet Another) Sorting Visualizer", headerX, headerY, width, headerY*2);
 rowTracker += headerY*2.0;
 
 // first 10% of screen used
// header 2 smaller
rowTracker += height/40.0;
headerY = height/40.0 ; // headerX stays to center
textSize(headerY*2);
text("coded novicely in Processing 4.3.4/java", headerX, headerY + rowTracker, width, (headerY*2)); 


//*******************************************************************************************

rowTracker += headerY*2.0;
rowTracker += height/15.0;

headerY = height/55.0;
headerX = width/3.0;
float header2X = headerX*2.5;
textAlign(LEFT, CENTER);
textSize(headerY*2);
text("\"A\" for good ol' BubbleSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"K\" for CombSort", header2X, headerY + rowTracker, width/2.5, headerY*2);


rowTracker += headerY*2.0;
rowTracker += height/40.0;
text("\"B\" for InsertionSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"L\" for RadixSort LSD, base 10", header2X, headerY + rowTracker, width/2.5, headerY*2);

rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"C\" for SelectionSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"M\" for RadixSort LSD, base 4", header2X, headerY + rowTracker, width/2.5, headerY*2);

rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"D\" for CocktailSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"N\" for RadixSort MSD, base 10", header2X, headerY + rowTracker, width/2.5, headerY*2);


rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"E\" for ShellSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"O\" for RadixSort MSD, base 4", header2X, headerY + rowTracker, width/2.5, headerY*2);

rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"F\" for MergeSort (in-place, recursive)", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"P\" for SmoothSort", header2X, headerY + rowTracker, width/2.5, headerY*2);


rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"G\" for MergeSort (iterative)", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"Q\" for Bi-TonicSort", header2X, headerY + rowTracker, width/2.5, headerY*2);


rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"H\" for QuickSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"R\" for CycleSort", header2X, headerY + rowTracker, width/2.5, headerY*2);


rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"I\" for DualPivotQuickSort", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"S\" for PigeonHoleSort", header2X, headerY + rowTracker, width/2.5, headerY*2);

rowTracker += headerY*2;
rowTracker += height/40.0;
text("\"J\" for HeapSort (Max Heap)", headerX, headerY + rowTracker, width/2.5, headerY*2);
text("\"T\" for TimSort", header2X, headerY + rowTracker, width/2.5, headerY*2);

rowTracker += headerY*2;
rowTracker += height/40.0;

strokeWeight(3);
stroke(0,0,4,10);
line(0, rowTracker, width, rowTracker);

strokeWeight(1);
stroke(0,0,10,10);

rowTracker += headerY;
rowTracker += height/144.0;

textSize(height/35.0);
text("Display Modes:  '0' for Spectrum, '1' for Sticks, '2' for Triangle, '3' for Boxes.", width/2, headerY + rowTracker, width/1.2, headerY * 2);

rowTracker += headerY*2;
rowTracker += height/72.0;
text("Pointer Modes:  '7' for flying lines, '8' for Arrows, '9' for regular lines, '5' for no pointer lines.  '6' to toggle sound on or off.", width/2, headerY + rowTracker, width/1.2, headerY * 2);

rowTracker += headerY*2;
rowTracker += height/72.0;
text("Space bar for this menu.  Selecting a draw mode before the sort *may* crash, or I *may* have fixed it.  Feel lucky?", width/2, headerY + rowTracker, width/1.2, headerY * 2);

rowTracker += headerY*2;
rowTracker += height/72.0;
text("Triangle Display Mode(2) only runs with Arrows(8).  Boxes Display Mode(3) has its own pointer display built-in.", width/2, headerY + rowTracker, width/1.2, headerY * 2);


runOK = false;
}
