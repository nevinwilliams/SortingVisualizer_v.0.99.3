//import processing.javafx.*;   // javaFX "FX2D" renderer. //<>//
//import java.util.LinkedList;  // Also for Array Queues
import java.util.Arrays;      // Array Utilities.
import processing.sound.*;


//* Static global Variables */


// Counters **********
static int swaps = 0;  // put 'swaps++' in sort algorithms when array elements get exchanged.
static int aas = 0;    // put 'aas++' in sort algos at points where there are Array Accesses.
static int comps = 0;  // put in 'comps++' where elements are compared < or > or = or 1.
static int snaps = 0;  // more diagnostic.  uses 'snaps++' instead of snap() to estimate drawing steps.
static int lines = 0;  // place a ++ in code whereever lines are drawn.  If a triangle, 'lines+=3'.
static int refresh = 0; // place in code after a background() call.  Counts screen clears.

static String ptrMode = "W";   // currently 'T'RIANGLE(new) and 'W'EDGE(OG default)

static int maxArray = 1000; // We're gonna try to use one large array, and only sort/draw some of it.

static int MIN_MERGE = 32; //  From TimSort.

static int base = 10; // For Radix Sorts.

static boolean runOK = false;
static boolean running = false;

static String sortName = "";

// colourMode
// 0 = white
// 1 = spectrum

static int colourMode = 1;  // not used
static float hueRange = 0;  // not used

static char displayMode = '0';
static char pointerMode = '7';
static boolean soundMode = true;
static boolean showMenu = true;

// Benchmarking
//static int msTimerStart = 0;  // inits the millisecond timer start variable.
//static int msTimerStop = 0;   // inits the millisecond time stop variable.

// static arrays for benchmarking and troubleshooting.
// they're a pain to make, and these are made, so here they are in case they're needed.
//int[] data700 = { 156, 176, 299, 619, 210, 246, 172, 128, 669, 651, 342, 100, 65, 105, 691, 551, 243, 590, 2, 376, 123, 135, 75, 530, 25, 674, 59, 444, 133, 428, 373, 259, 406, 661, 384, 449, 326, 134, 578, 598, 640, 354, 611, 39, 588, 435, 271, 398, 525, 377, 289, 72, 557, 459, 235, 56, 478, 362, 597, 297, 485, 650, 538, 288, 461, 178, 369, 20, 422, 298, 301, 390, 445, 8, 136, 121, 34, 266, 175, 229, 174, 285, 31, 393, 353, 109, 565, 148, 495, 699, 221, 276, 587, 3, 499, 503, 509, 309, 359, 73, 649, 379, 433, 472, 313, 13, 320, 171, 489, 512, 234, 327, 366, 70, 304, 434, 368, 197, 668, 437, 184, 573, 630, 212, 545, 205, 339, 411, 593, 561, 582, 187, 625, 195, 476, 222, 338, 580, 131, 191, 501, 447, 111, 498, 168, 372, 113, 129, 130, 219, 399, 421, 609, 426, 200, 629, 272, 283, 94, 252, 263, 526, 469, 484, 477, 402, 232, 318, 294, 303, 76, 343, 684, 157, 360, 319, 341, 286, 249, 440, 209, 508, 672, 138, 16, 26, 675, 43, 620, 579, 231, 429, 173, 400, 613, 540, 192, 391, 652, 166, 87, 454, 571, 331, 493, 550, 385, 496, 677, 204, 250, 198, 50, 409, 662, 413, 101, 199, 48, 264, 676, 659, 648, 80, 41, 479, 632, 490, 228, 694, 180, 21, 35, 92, 269, 378, 323, 556, 29, 60, 529, 19, 293, 453, 356, 528, 549, 654, 389, 405, 332, 145, 685, 616, 344, 307, 159, 642, 1, 534, 634, 233, 568, 328, 126, 541, 314, 295, 572, 455, 687, 655, 547, 474, 527, 186, 486, 416, 614, 361, 201, 586, 270, 407, 441, 88, 160, 603, 591, 223, 165, 351, 638, 425, 570, 64, 515, 641, 239, 83, 594, 290, 664, 238, 241, 118, 53, 394, 522, 254, 643, 355, 98, 89, 42, 46, 188, 69, 392, 177, 452, 218, 82, 589, 61, 140, 442, 606, 120, 163, 553, 439, 287, 419, 225, 535, 18, 329, 151, 657, 562, 670, 36, 137, 510, 90, 575, 22, 470, 81, 475, 666, 494, 153, 462, 251, 370, 300, 480, 605, 663, 667, 63, 97, 315, 108, 132, 350, 208, 162, 537, 491, 47, 533, 375, 215, 689, 386, 397, 678, 492, 170, 523, 617, 563, 577, 306, 365, 262, 185, 688, 458, 158, 33, 415, 115, 367, 420, 214, 179, 217, 280, 543, 345, 516, 607, 181, 583, 5, 558, 482, 346, 268, 626, 167, 653, 418, 54, 546, 542, 139, 417, 532, 352, 248, 601, 32, 292, 624, 11, 17, 531, 473, 57, 79, 507, 457, 302, 112, 68, 348, 585, 9, 695, 193, 519, 656, 10, 143, 511, 161, 456, 124, 312, 488, 432, 77, 569, 277, 690, 62, 517, 627, 671, 38, 595, 144, 387, 273, 15, 520, 635, 86, 27, 203, 324, 497, 125, 66, 596, 552, 548, 257, 103, 325, 539, 427, 95, 581, 227, 296, 334, 291, 122, 196, 340, 155, 44, 52, 592, 206, 182, 110, 190, 621, 147, 265, 23, 284, 169, 49, 622, 330, 698, 183, 566, 468, 646, 4, 524, 559, 152, 483, 322, 117, 446, 24, 237, 58, 245, 358, 357, 146, 311, 308, 576, 333, 560, 430, 28, 107, 256, 513, 316, 403, 337, 636, 67, 404, 55, 481, 692, 213, 681, 518, 127, 202, 317, 30, 633, 194, 424, 12, 463, 261, 639, 99, 628, 374, 544, 450, 78, 207, 7, 436, 431, 451, 255, 371, 584, 396, 564, 680, 555, 506, 618, 410, 414, 93, 45, 608, 408, 647, 102, 602, 242, 363, 502, 536, 574, 599, 14, 696, 281, 521, 258, 487, 282, 423, 438, 364, 500, 164, 631, 471, 51, 679, 141, 380, 383, 0, 149, 154, 448, 216, 660, 610, 116, 465, 683, 686, 220, 466, 142, 554, 382, 6, 114, 247, 71, 310, 253, 226, 84, 279, 395, 347, 278, 443, 604, 505, 96, 40, 211, 682, 274, 600, 388, 150, 645, 119, 260, 412, 335, 658, 567, 336, 349, 673, 623, 240, 189, 460, 106, 85, 74, 504, 615, 91, 305, 236, 464, 612, 637, 275, 514, 224, 401, 693, 381, 467, 244, 321, 644, 697, 104, 230, 665, 267, 37};
//int[] data500 = {164, 379, 477, 438, 252, 289, 389, 106, 48, 147, 120, 230, 457, 80, 194, 10, 459, 27, 217, 260, 96, 474, 139, 292, 290, 69, 68, 37, 301, 204, 9, 122, 172, 8, 410, 170, 151, 330, 409, 213, 472, 442, 91, 169, 429, 89, 396, 31, 436, 458, 366, 350, 208, 349, 115, 88, 371, 150, 312, 131, 470, 144, 223, 498, 481, 171, 149, 426, 421, 212, 23, 152, 13, 163, 121, 394, 340, 195, 216, 243, 344, 463, 378, 70, 5, 187, 259, 258, 16, 355, 84, 57, 372, 240, 175, 162, 36, 179, 380, 198, 263, 74, 264, 296, 26, 407, 351, 480, 272, 248, 238, 211, 246, 388, 102, 58, 129, 202, 219, 278, 452, 280, 476, 60, 309, 313, 67, 236, 205, 469, 363, 358, 98, 300, 341, 352, 85, 206, 141, 337, 183, 400, 6, 77, 14, 434, 247, 4, 275, 156, 354, 2, 45, 287, 186, 304, 382, 132, 245, 143, 39, 443, 180, 130, 490, 54, 361, 479, 28, 182, 285, 284, 73, 158, 65, 348, 390, 189, 428, 454, 110, 237, 331, 191, 346, 140, 464, 61, 283, 433, 177, 1, 276, 486, 499, 269, 224, 242, 306, 444, 87, 154, 166, 34, 449, 274, 368, 279, 261, 450, 22, 196, 52, 329, 383, 146, 295, 193, 302, 21, 405, 398, 365, 44, 455, 356, 53, 333, 320, 323, 374, 353, 188, 461, 125, 310, 266, 160, 62, 317, 81, 103, 83, 391, 345, 403, 249, 362, 250, 402, 221, 108, 445, 255, 298, 492, 185, 244, 101, 123, 286, 373, 475, 220, 181, 327, 41, 199, 386, 218, 135, 47, 307, 288, 318, 148, 468, 406, 165, 114, 178, 119, 86, 153, 63, 419, 496, 299, 456, 397, 399, 488, 384, 76, 225, 112, 190, 200, 448, 364, 315, 79, 256, 231, 210, 338, 305, 321, 40, 297, 360, 393, 55, 7, 332, 42, 24, 117, 466, 376, 262, 116, 109, 128, 124, 235, 413, 29, 412, 440, 369, 184, 395, 92, 126, 427, 375, 359, 11, 473, 229, 294, 209, 416, 197, 387, 94, 104, 173, 207, 483, 430, 134, 50, 49, 381, 441, 314, 432, 59, 324, 35, 145, 233, 82, 20, 113, 291, 485, 319, 489, 133, 127, 97, 418, 33, 56, 241, 90, 17, 239, 334, 467, 335, 495, 439, 453, 99, 46, 311, 336, 422, 265, 176, 157, 322, 234, 268, 367, 482, 414, 271, 446, 424, 12, 43, 232, 257, 18, 107, 401, 78, 411, 168, 451, 435, 32, 342, 167, 277, 385, 64, 111, 447, 66, 75, 30, 491, 357, 15, 423, 494, 71, 308, 214, 404, 51, 471, 460, 93, 370, 226, 316, 267, 497, 155, 203, 487, 138, 437, 281, 478, 273, 493, 484, 3, 254, 19, 161, 392, 174, 72, 95, 227, 325, 377, 137, 201, 415, 253, 465, 408, 228, 118, 343, 25, 192, 251, 222, 105, 431, 347, 326, 339, 136, 425, 282, 100, 270, 142, 38, 293, 0, 303, 328, 159, 215, 462, 420, 417};
//int[] data250 = {326, 358, 212, 308, 194, 74, 210, 302, 102, 498, 18, 124, 476, 204, 306, 86, 312, 472, 446, 266, 152, 246, 4, 144, 176, 170, 30, 116, 106, 218, 334, 340, 296, 232, 120, 328, 452, 280, 430, 12, 316, 314, 250, 100, 244, 486, 292, 40, 274, 496, 240, 350, 372, 36, 490, 238, 66, 478, 388, 360, 190, 54, 336, 90, 230, 346, 168, 352, 356, 148, 134, 278, 150, 166, 282, 104, 438, 108, 468, 330, 298, 180, 160, 482, 300, 418, 322, 76, 136, 58, 56, 70, 222, 454, 488, 474, 394, 402, 26, 128, 130, 28, 226, 96, 82, 202, 406, 294, 348, 0, 126, 400, 390, 258, 224, 434, 318, 216, 392, 380, 178, 122, 416, 208, 60, 342, 138, 344, 80, 436, 444, 286, 414, 146, 206, 440, 92, 424, 426, 448, 42, 242, 458, 88, 62, 198, 172, 422, 182, 462, 320, 268, 304, 184, 156, 234, 248, 412, 24, 480, 188, 492, 366, 158, 262, 386, 50, 270, 442, 16, 140, 174, 44, 164, 214, 290, 68, 354, 220, 276, 338, 132, 378, 2, 200, 324, 404, 264, 114, 456, 420, 428, 8, 34, 470, 38, 6, 364, 374, 284, 98, 288, 52, 260, 162, 142, 332, 310, 22, 410, 84, 464, 396, 32, 10, 236, 64, 272, 228, 398, 466, 186, 370, 484, 72, 20, 494, 252, 254, 154, 118, 192, 384, 112, 46, 368, 196, 408, 94, 432, 362, 110, 460, 256, 450, 48, 382, 78, 14, 376};
//int[] data100 = {35, 0, 165, 5, 225, 460, 135, 440, 80, 130, 220, 430, 185, 485, 470, 255, 275, 175, 25, 300, 380, 150, 240, 455, 360, 350, 145, 210, 290, 190, 30, 85, 200, 20, 370, 195, 230, 205, 355, 435, 245, 45, 330, 235, 305, 280, 475, 120, 40, 270, 450, 55, 215, 110, 320, 50, 325, 180, 105, 420, 160, 340, 295, 415, 425, 125, 490, 70, 315, 155, 390, 170, 335, 65, 465, 410, 95, 480, 310, 265, 405, 100, 10, 495, 375, 365, 345, 260, 60, 250, 15, 285, 140, 400, 385, 445, 115, 395, 90, 75};
//int[] data50 = {160, 100, 310, 20, 150, 170, 200, 260, 330, 480, 230, 270, 350, 190, 470, 300, 360, 180, 40, 90, 290, 80, 60, 450, 370, 280, 390, 320, 140, 30, 120, 380, 50, 210, 130, 240, 220, 0, 490, 400, 420, 340, 410, 440, 460, 250, 430, 10, 110, 70};
//int[] data10 = {50, 150, 400, 200, 300, 100, 250, 500, 350, 450};



// draw() variables.
static int iter = 0;                 // iteration variable for draw() loop.  frameCount doesn't work with my code.

static boolean drawArrayDone = false;  // used to do post-sort animation.
static int iter2 = 0;         // Iteration variable for post array animation.

/* aQueue is a queue of arrays with linked lists.  aQueue is used for the main
 sort array sequences, and populated with the snap() method as often as
 necessary for an interesting animation.
 aQueue is passed the large sort arrays of variable element length with the
 snap() method.  The array should be added to the queue with the .clone() method
 weirdness happens.  The snap() method should be the only method to add to the queue. */


//static  Queue<int[]> aQueue = new LinkedList<>();



//  Should an Array List need to be used, say if access to already drawn array values are needed
//  this is the syntax for defining it:

//      static  ArrayList<int[]> aList = new ArrayList<int[]>();
//  when adding an array to the aList, use the .clone() method or weirdness happens.

/* ptrList is a list of arrays in an ArrayList.  ptrList is used to animate two
 graphical pointers.  It is populated with the snap() method.  Its arrays are
 currently exclusively int[2] in length.  This is not enforced.  The first
 element positions the bottomUp pointer.  The second element places the
 topDown pointer.  It is important that when the queue to aQueue added,
 so too is ptrList, or there will be Trouble.
 It is useful to access past values of the ptr[] array, so it is defined as an ArrayList.
 The snap() method should be the only way to add elements to the ptrList.
 */

static ArrayList<int[]> ptrList = new ArrayList<int[]>();
static ArrayList<int[]> aList = new ArrayList<int[]>();
//static ArrayList<int[]> chgList = new ArrayList<int[]>();


//   COLOUR AND DISPLAY VARIABLES

// The HSB colour format is used because it's easier to select colours than RGB.

int colourOffset = 0;        // where, in the HSB range, does colours start.
float colourFactor = 1.25;   // HSB range = aSize * colourFactor
// offset of 1.25 will get rid of most magenta,
// by redshifting.

//*****************************************************SOUND STUFF*****************

SqrOsc snd0;       // sets up two Square Oscillators, one for each floating pointer.
SqrOsc snd1;

Reverb reverb0;   // Applies default reverb effect
Reverb reverb1;    // Adding reverb made the best change.

Env env0;        // Applies an ASR envelope
Env env1;        //  The envelope keeps the tones from playing longer than a few frames.  Sounds ok with reverb.


float aT = 1.0/120;    // Attack Time
float sT = 1.0/120;    // Sustain Time
float sL = 0.01;      // Sustain Level
float rT = 1.0/120;  // Release Time       (changing any of these really did not affect the sound quality at all)

/*  Some sorts' pointers stick to an element or value for an extended time, causing a long, steady tone.
 The sound code stops playing if there are two consecutive notes in a row.  Some sorts, like QuickSort just have
 short runs of the same value, and these sorts sound worse with the quenching.   This lets one turn the
 quenching on or off on a per-sort basis in the Case statements.  Default to true.*/


static boolean samePitchQuench = true;


//ARRAY SIZE DEFINITION -- might be less of a deal now with newer scaling drawing.

// ******************
static int aSize = 0;    //the MAIN array size for several functions.
// *****************

float wd = 1280.0;   // window width
float ht = 720.0;   //  window height

float yR = 0.0;    // global var to represent the y-Ratio for lines.
float xR = 0.0;    // global var to represent the x-Ratio for lines.

// The settings() method must be used if screen height & width are defined with variables.
// I don't know why.

// here begins the start of having multiple sorts in one sketch.
// wish me luck.


char inputKey = ' ';  // defaults to Display Menu key.




void settings() {
//  size((int)wd, (int)ht, P2D);
fullScreen(P2D);
  smooth();
  //options for renderer: none, P2D, P3D, (FX2D with JavaFX library imported)
}


//*******************************SETUP**********************
void setup() {

  wd = width;
  ht = height;
  background(0);


  loop();


  // sets the framerate of the draw() method.

  frameRate(60);


/* This stanza defines the sound effects.  snd0 corresponds to ptr0 sounds.
snd1 corresponds to ptr1 sounds. */

  snd0 = new SqrOsc(this);
  snd1 = new SqrOsc(this);
  env0 = new Env(this);
  env1 = new Env(this);
  reverb0 = new Reverb(this);
  reverb1 = new Reverb(this);

  reverb0.process(snd0);
  reverb1.process(snd1);
  snd0.pan(0.5);
  snd1.pan(-0.5);





  showMenu = true;


  // Make Hue range equal to array elements, others to percentages.
  // When lines are drawn, the color can be set to the array value
  // to get a nice spectrum.   The 100s define the SB and Alpha as percentages.

  hueRange = aSize * colourFactor;

  colorMode(HSB, aSize * colourFactor, 10, 10, 10); // changed from 100 to 10; look for magentas; change accordingly.




  // setup is done.
  // DEFAULT STROKECAP (ROUND) = Big performance hit with default renderer.
  // Use SQUARE or PROJECTED instead.

  displayMenuScreen();
  strokeCap(SQUARE);

  // noSmooth();
  yR = ht/(aSize); // Y axis ratio to set line height scale.
  xR = wd/aSize;          // X axis ratio to scale line strokeWeight

  //delay(2000);
  //  msTimerStart = millis();
}

void draw() {

  // main scale and translate calls have to be at start of draw() because docs say they reset each loop

float scaleFactor = 0.89;

  scale(scaleFactor, scaleFactor);    // shrinks the drawing within the display screen.
//  translate((((1.0-scaleFactor) * width)/2/scaleFactor), ((1.0-scaleFactor) * height)/2/scaleFactor);  // gives a small border around drawing.
// textSize(((1.0-scaleFactor) * height)/2/scaleFactor)
  translate((((1.0-scaleFactor) * width)/2/scaleFactor), ((1.0-scaleFactor) * height)/2/scaleFactor);  // gives a small border around drawing.


  if (showMenu && !running) {
    displayMenuScreen();
  }

  if (iter < aList.size() && runOK) {
    
background(0);  

    if (displayMode == '0') {
      drawSpectrum(aList.get(iter));
    }

    if (displayMode == '1') {
      drawSticks(aList.get(iter));
    }

    if (displayMode == '2') {
      pointerMode = '8';
      drawTriangleSpectrum(aList.get(iter));
    }

    if (displayMode == '3') {
      pointerMode = '#';
      drawBoxedArray(aList.get(iter));
    }

    if (runOK) {
      if (iter < ptrList.size() - 1) {
        if (pointerMode == '7') {
          drawTrails();
        }

        if (pointerMode =='8') {
          ptrArrowDraw();
        }
        if (pointerMode =='9') {
          drawPtrLines();
        }
      }

      if (soundMode) {
        soundPtr();
      }
    }
    if (runOK) {  // keeps from crashing if a pointer mode
      iter++;                 // is selected before a sort mode.
      writeSortName(((1.0-scaleFactor) * height)/2/scaleFactor);
    }
  } else {
    drawArrayDone = true;


    // noLoop();
  }


 


  // saveFrame("stills/images-#####.tif");
}

void keyPressed() {
  inputKey = key;
  showMenu = false;


  int[] arr = genArray (maxArray);


  switch(inputKey) {

  case 'a':
    resetPreSortVars();
    aSize = 80;
    shuffleArray(arr);
    bubbleSort(arr);
    samePitchQuench = true; // definitely want quenching here.
    resetPreDrawVarsAndGo();
    break;

  case 'b':
    resetPreSortVars();
    aSize = 100;
    shuffleArray(arr);
    insertionSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'c':
    resetPreSortVars();
    aSize = 80;
    shuffleArray(arr);
    selectionSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'd':
    resetPreSortVars();
    aSize = 100;
    shuffleArray(arr);
    cocktailSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'e':
    resetPreSortVars();
    aSize = 200;
    shuffleArray(arr);
    shellSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'f':
    resetPreSortVars();
    aSize = 500;
    shuffleArray(arr);
    mergeSort(arr, 0, aSize - 1);
    resetPreDrawVarsAndGo();
    break;

  case 'g':
    resetPreSortVars();
    aSize = 500;
    shuffleArray(arr);
    iterativeMergeSort(arr);
    resetPreDrawVarsAndGo();
    break;


  case 'h':
    resetPreSortVars();
    aSize = 400;
    shuffleArray(arr);
    quickSort(arr, 0, aSize - 1);
    samePitchQuench = false;  // The cut-outs sound worse than a tone-run-on.
    resetPreDrawVarsAndGo();
    break;

  case 'i':
    resetPreSortVars();
    aSize = 800;
    shuffleArray(arr);
    dualPivotQuickSort(arr, 0, aSize -1);
    samePitchQuench = false; // Quicksorts hit the same pitch, but not long; cutouts sound worse.
    resetPreDrawVarsAndGo();
    break;

  case 'j':
    resetPreSortVars();
    aSize = 400;
    shuffleArray(arr);
    heapSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'k':
    resetPreSortVars();
    aSize = 160;
    shuffleArray(arr);
    combSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'l':
    resetPreSortVars();
    aSize = 1000;
    base = 10;
    shuffleArray(arr);
    radixSort(arr);   // LSD
    resetPreDrawVarsAndGo();
    break;

  case 'm':
    resetPreSortVars();
    aSize = 800;
    base = 4;
    shuffleArray(arr);
    radixSort(arr);   // LSD
    resetPreDrawVarsAndGo();
    break;

  case 'n':
    resetPreSortVars();
    aSize = 400;
    base = 10;
    shuffleArray(arr);
    radixMSDSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'o':
    resetPreSortVars();
    aSize = 500;
    base = 4;
    shuffleArray(arr);
    radixMSDSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'p':
    resetPreSortVars();
    aSize = 500;
    shuffleArray(arr);
    smoothSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 'q':
    resetPreSortVars();
    aSize = 256;
    shuffleArray(arr);
    // params are Array, start index, array size, and 1 (for up, 0 for down)
    bitonicSort(arr, 0, aSize, 1);   // bi-tonic, like bi-weekly. :)
    resetPreDrawVarsAndGo();
    break;

    case ('r'):
    resetPreSortVars();
    aSize = 300;
    shuffleArray(arr);
    cycleSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 's':
    resetPreSortVars();
    aSize = 200;
    shuffleArray(arr);
    pigeonholeSort(arr);
    resetPreDrawVarsAndGo();
    break;

  case 't':
    resetPreSortVars();
    aSize = 600;
    shuffleArray(arr);
    timSort(arr, aSize);
    resetPreDrawVarsAndGo();
    break;

  case '6':
    soundMode = !soundMode;
    break;

  case ' ':
    showMenu = true;
    running = false;
    break;

  case '0':
    background(0);
    displayMode = '0';
    break;

  case '1':
    displayMode = '1'; // triangle
    background(0);
    break;

  case '2':
    displayMode = '2';  //sticks
    background(0);
    break;

  case '3':
    displayMode = '3';  // boxes
    pointerMode = '4';   //disable pointers for box draw.
    background(0);
    break;


  case '7':
    pointerMode = '7';  // flying lines
    break;

  case '8':
    pointerMode = '8';  // arrows
    break;

  case '9':
    pointerMode = '9'; // regular lines
    break;

  case '5':
    pointerMode = '5'; // no pointers
    break;
  }
  if (!running) {
    showMenu = true;
  }
}
