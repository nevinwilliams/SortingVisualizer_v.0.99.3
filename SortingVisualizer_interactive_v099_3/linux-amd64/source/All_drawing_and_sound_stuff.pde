

//*************************************ARRAY DRAWING CODE*****************************************
//    drawSpectrum:  draws a wedge from left bottom to right top, in spectral colours.
//    drawSticks:    draws lines that are anchored to their array indicies at bottom, and their unsorted value at top
//    drawTriangleSpectrum:  draws lines that are vertically  centered, left to right.
//    drawBoxedArray:  draws a numbered grid of rectangles; needs an aSize of 400 to display properly.




public void drawSpectrum(int array[]) {

  // this version onward will draw colourful arrays.
  // it depends on colorMode(HSB, aSize, 100, 100, 100); being called in setup()

  //  snaps++;
  background(0);
  refresh++;


  for (int i=0; i < aSize; i++) {

    stroke(array[i] + colourOffset, 10, 10, 10);  // each line coloured to its value.
    strokeWeight(xR); //lines fill screen

    //draw main array

    float x1 = i * xR;  //  verticle lines
    //    float x1 = array[i] * xR; // lines anchored on bottom in right places.
    float y1 = height;        // lines bend to the bottom.
    float x2 = i * xR;    //
    float y2 = height - (array[i] * yR);

    line(x1, y1, x2, y2);
    lines++;
  }
}


public void drawTriangleSpectrum(int array[]) {



  background(0);
  refresh++;

  // float hR is height ratio in main.
  // float wR is width ratio in main.



  for (int i=0; i < aSize; i++) {

    stroke(array[i] + colourOffset, 10, 10, 10);  // each line coloured to its value.
    strokeWeight(xR); //lines fill screen

    //draw main array

    float x1 = i * xR;  //  both start and end of xPos here are at the index of the array.

    float y1 = height/2 + (array[i] * yR)/2;
    float x2 = x1;      // xPos doesn't move.
    float y2 = height/2 - (array[i] * yR)/2;

    line(x1, y1, x2, y2);
    lines++;
  }
}

public void drawSticks(int array[]) {

  // this method will draw mixed-up sticks.
  // The bottom of the stick is anchored to its array position
  // which is, for this data, its sorted position.
  // the top of the stick is anchored to its place in the array.
  // as the array is sorted, the sticks will be moved to an upright position.


  background(0);
  refresh++;

  // float hR is height ratio in main.
  // float wR is width ratio in main.

  //  float hueRange = aSize * colourFactor;

  stroke(0, 0, 10, 10);  // white unless colourMode == 1

  for (int i=0; i < aSize; i++) {

    if (colourMode == 1) {
      stroke(array[i] + colourOffset, 10, 10, 10);  // each line coloured to its value.
    } else {
      stroke(0, 0, 10, 10);  // white unless colourMode == 1
    }
    strokeWeight(xR); //lines fill screen

    //draw main array

    //   float x1 = i * xR;  //  verticle lines
    float x1 = array[i] * xR; // lines anchored on bottom in right places.
    float y1 = height;        // lines bend to the bottom.
    float x2 = i * xR;    //
    float y2 = height - (array[i] * yR);

    line(x1, y1, x2, y2);
    lines++;
  }
}


void drawBoxedArray(int[] array) { //  Thanks to SCF@Styrocord for the help!
  noStroke();
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  if (aSize > 600) {
    textSize(18);
  } else {
    textSize(24);
  }

  if (aSize > 800) {
    textSize(12);
  }

  int row = 20;
  int col = aSize/row; // aSize is the array length; 400 works with this, draws off the screen with other values.

  float rectWd = (float)width/col;
  float rectHt = (float)height/row;

  int ptr[] = ptrList.get(iter);  // iter is the main counter that's incremented in the draw() loop that calls this method.

  int i = 0;
  for (int y = 0; y < row; y++) {

    for (int x = 0; x < col; x++ )
    {

      fill(array[i], 10, 10, 10);    // fill with colour corresponding to the element value.

      if (iter < aList.size() -1) {   // code for the white & black boxes that show the swap or index pointers.
        if (array[i] == ptr[2]) {    // stops drawing those before the last loop.
          fill(0, 0, 0, 10);
        } else if (array[i] == ptr[3]) {
          fill(0, 0, 10, 10);
        }
      }
      float rectCtrX = (x * rectWd) + (0.5 * rectWd);
      float rectCtrY = (y * rectHt) + (0.5 * rectHt);

      rect(rectCtrX, rectCtrY, rectWd, rectHt);
      fill((array[i] + hueRange/2)%hueRange, 10, 10, 10);
      text("" +array[i], rectCtrX, rectCtrY, rectWd, rectHt);
      i++;
    }
  }
}

//************************************POINTER DRAWING CODE***************************************

void drawTrails() {

  // this trail-drawing method draws several pointers based on past data,
  // flying in from the top left and bottom right corner.
  // the pointers fade out as the opacity of the line decreases.

  strokeWeight(xR * 2);
  float transp = 5.0;
  int trails = 10;

  int spaces = 2;
  float steps = (float)transp/trails;




  if (iter > (trails * spaces) && iter < ptrList.size() - 2) {


    for (int j = 0; j < trails*spaces; j+= spaces) {


      int[] oldPtr = ptrList.get(iter - j);



      stroke(0, 0, 10, transp);



      float x12  =  oldPtr[0] * xR;
      //     float y1  =  height - array[oldPtr[0]] * yR;
      float y1  =  height - oldPtr[2] * yR;
      float y2 =  height;
      line(x12, y1, width + 100, height + 100);  // anchor end of pointer well offscreen
      lines++;


      stroke(0, 0, 10, transp); //white line

      x12 = oldPtr[1] * xR ;
      y1 = 0;
      //      y2 = height-array[oldPtr[1]] * yR;
      y2 = height-oldPtr[3] * yR;

      line(-100, -100, x12, y2);  // -640 anchor end of pointer well offscreen
      transp -= steps;
      lines++;
    }
  } else {  
    // since the main code pulls past data, it can't start immediately.
    // this just draws single lines at the start so there won't be a blank
    // spot in the animation.
    int[] ptr = ptrList.get(iter);
    stroke(0, 0, 10, transp);
    float x12  =  ptr[0] * xR;
    float y1  =  height - ptr[2] * yR;
    float y2 =  height;
    line(x12, y1, width + 100, height + 100);  // anchor end of pointer well offscreen
    lines++;

    stroke(0, 0, 10, transp);
    x12 = ptr[1] * xR ;
    y1 = 0;
    y2 = height-ptr[3] * yR;

    line(-100, -100, x12, y2);  // -640 anchor end of pointer well offscreen
    transp -= steps;
    lines++;
  }
}

void drawPtrLines() {


  if (iter < aList.size() -1) {

    int[] newPtr = ptrList.get(iter);
    strokeWeight(xR);
    stroke(0, 0, 10, 10);
    float x12  =  newPtr[0] * xR;
    float y1 = height + 36;
    float y2  =  height - newPtr[2] * yR;

    line(x12, y1, x12, y2);
    lines++;

    strokeWeight(xR);
    stroke(0, 0, 10, 10); //white line
    x12 = newPtr[1] * xR;
    y1 = -36;
    y2 = height-newPtr[3] * yR;

    line(x12, y1, x12, y2);

    lines++;
  }
}

void ptrArrowDraw() {

  strokeWeight(xR/2);


  if (colourMode == 1) {
    stroke(0, 0, 10, 10);
  } else if (colourMode == 0) {
    stroke(0, 10, 10, 10);
  }

  int ptr[] = ptrList.get(iter);

  //  Bottom Up Arrow

  //vertex

  float x1  =  ptr[0] * xR;

  //   float y1  =  height - arr0Av * yR;
  float y1  =  height - 100;

  // right leg
  float x2  =  x1 - 5;
  float y2 =  height + 36;

  float x3 = x1 + 5;


  line(x1, y1, x2, y2);
  line(x1, y1, x3, y2);

  lines+=2;

  if (colourMode == 1) {
    stroke(0, 0, 10, 10);
  } else if (colourMode == 0) {
    stroke(aSize * 1.25/2, 10, 10, 10);
  }


  // BOTTOM DOWN ARROW

  //vertex
  //    x1 = oldPtr[1] * xR;
  x1 = ptr[1] * xR;
  y1 = 100 ;

  //right leg
  x2 = x1 - 5;
  y2 = -36;
  x3 = x1 + 5;
  //left leg
  //      line (x3, y2, x1, y1);


  line(x1, y1, x2, y2);
  line(x1, y1, x3, y2);

  lines+=2;
}

// The big & little finish methods need work.  They don't currently run.

void bigFinish() { // do final animation 10 lines at a time.
  iter2 = aSize;

  strokeWeight(xR *1.2); //lines fill screen
  if (iter2 + 10 > aSize) {
    lilFinish();
  } else {
    for (int i = 0; i < 10; i++) {


      stroke(iter2 + colourOffset, 10, 10, 10);  // full spectrum
      line(iter2 * xR, // X1
        height, // Y1
        iter2 * xR, // X2
        height - (iter2*yR)); // Y2
      lines++;

      float freq2 = (iter2+150) *1;
      float freq3 = (iter2+300) *2;

      snd0.play(freq2, 0.1);

      env0.play(snd0, aT, sT, sL, rT);

      snd1.play(freq3, 0.1);
      env1.play(snd1, aT, sT, sL, rT);
      iter2++;
    }
  }
}
void lilFinish() { // do final animation just one line at a time.
  strokeWeight(xR *1.2); //lines fill screen
  stroke(iter2 + colourOffset, 10, 10, 10);  // full spectrum
  line(iter2 * xR, // X1
    height, // Y1
    iter2 * xR, // X2
    height - (iter2*yR)); // Y2
  lines++;
  iter2++;
  //  println("lilfinish");
}

void bigTriFinish() { // do final animation 10 lines at a time.
  strokeWeight(xR *1.2); //lines fill screen
  if (iter2 + 10 > aSize) {
    lilTriFinish();
  } else {
    for (int i = 0; i < 10; i++) {


      stroke(iter2 + colourOffset, 10, 10, 10);  // full spectrum
      line(iter2 * xR, // X1
        height/2 + (iter2*yR)/2, // Y1
        iter2 * xR, // X2
        height/2 - (iter2*yR)/2); // Y2
      lines++;

      float freq2 = (iter2+150) *1;
      float freq3 = (iter2+300) *2;

      snd0.play(freq2, 0.1);

      env0.play(snd0, aT, sT, sL, rT);

      snd1.play(freq3, 0.1);
      env1.play(snd1, aT, sT, sL, rT);
      iter2++;
    }
  }
}
void lilTriFinish() { // do final animation just one line at a time.
  strokeWeight(xR *1.2); //lines fill screen
  stroke(iter2 + colourOffset, 10, 10, 10);  // full spectrum
  line(iter2 * xR, // X1
    height/2 + (iter2*yR)/2, // Y1
    iter2 * xR, // X2
    height/2 - (iter2*yR)/2); // Y2
  lines++;
  iter2++;
}

//***************************************************unsound tbh SOUND CODE*********************
void soundPtr() {


  int[] ptr = ptrList.get(iter);

  float freq2 = (ptr[2]+150) *1;
  float freq3 = (ptr[3]+300) *2;
  int[] oldPtr = new int[4];
  if (iter > 1) {
    oldPtr = ptrList.get(iter -1 );
  }
  
  if (ptr[2] > 0 && ptr[2] < aSize -1) {
    if (ptr[2] == oldPtr[2] && samePitchQuench) {
    } else {
      snd0.play(freq2, 0.1);
      env0.play(snd0, aT, sT, sL, rT);
    }
  }
  if (ptr[3] > 0 && ptr[3] < aSize -1) {
    if (ptr[3] == oldPtr[3] && samePitchQuench) {
    } else {
      snd1.play(freq3, 0.1);
      env1.play(snd1, aT, sT, sL, rT);
    }
  }
}
