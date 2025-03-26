public static int[] genArray (int elements)
{

  int[] genArr = new int[elements*2];

  for (int i = 0; i < elements; i++) {
    genArr[i] = i;
  }

  return(genArr);
}

static int[] setupArray (int size, boolean doShuffle) {


  int[] arr = genArray(size);
  // if passed false, will pass back a sorted array of size.

  if (doShuffle) {
    shuffleArray(arr);
    return arr;
  } else {
    return arr;
  }
}

public static void shuffleArray(int[] array) {
  int temp = 0;
  int n = aSize;

  for (int i=0; i < n; i++) {
    int r = (int) (Math.random() * (i + 1));
    temp = array[r];
    array[r] = array[i];
    array[i] = temp;
    //    snap(array, i, aSize);
  }
}

public static void snap (int[] array, int pointer0, int pointer1) {


  // ptr[0] value of index for first pointer
  // ptr[1] value of index for 2nd pointer
  // ptr[2] value of array[pointer0]
  // ptr[3] value of array[pointer1]

  int[] ptr = new int[4];

  // value clamping is used as sometimes a variable too small or two large can get passed.
  // sometimes, to get a more interesting drawing, add or subtract 1 to one of the pointers, to put it ahead of the action.
  // clamping lets me not worry about array access errors when I do this.


  ptr[0] = Math.max(Math.min(pointer0, aSize-1), 0); // clamps the value recorded to the array dimensions.
  ptr[1] = Math.max(Math.min(pointer1, aSize-1), 0); // clamps the value recorded to the array dimensions.
  ptr[2] = array[ptr[0]];
  ptr[3] = array[ptr[1]];

  // The pointers are a list, because it can be useful to grab several pointers back.
  ptrList.add(ptr.clone());

  // the arrays are a queue, because they're usually only accessed once.  Until they're not.  Then you need aList.
  // aQueue.add(array.clone());
  aList.add(array.clone());
}


void resetPreSortVars() {
  
  swaps = 0;  // put 'swaps++' in sort algorithms when array elements get exchanged.
  aas = 0;    // put 'aas++' in sort algos at points where there are Array Accesses.
  comps = 0;  // put in 'comps++' where elements are compared < or > or = or 1.
  snaps = 0;  // more diagnostic.  uses 'snaps++' instead of snap() to estimate drawing steps.
  lines = 0;  // place a ++ in code whereever lines are drawn.  If a triangle, 'lines+=3'.
  refresh = 0; // place in code after a background() call.  Counts screen clears.

  // Benchmarking

  iter = 0;                 // iteration variable for draw() loop.  frameCount doesn't work with my code.

  drawArrayDone = false;  // used to do post-sort animation.
  iter2 = 0;         // Iteration variable for post array animation.

  aList.clear(); // where array lists are stored with snap() then played back in draw()
  ptrList.clear(); // where sort pointers are stored with snap() then played back in draw()

  samePitchQuench = true;  // keeps sound from playing same pitch.
}

void resetPreDrawVarsAndGo() {
  hueRange = aSize * colourFactor;   

  colorMode(HSB, hueRange, 10, 10, 10); // changed from 100 to 10; look for magentas; change accordingly.
  yR = ht/(aSize); // Y axis ratio to set line height scale.
  xR = wd/aSize;          // X axis ratio to scale line strokeWeight


loop();
 runOK = true;
 running = true;
}
