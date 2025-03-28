// Java implementation


// Define the Leonardo numbers
static int leonardo(int k)
{
  if (k < 2) {
    return 1;
  }
  return leonardo(k - 1) + leonardo(k - 2) + 1;
}

// Build the Leonardo heap by merging
// pairs of adjacent trees
static void smoothHeapify(int[] arr, int start, int end)
{
  int i = start;
  int j = 0;
  int k = 0;
  //  snap(arr, start, end); // Snap 0
  while (k < end - start + 1) {
    if ((k & 0xAAAAAAAA) != 0) {
      j = j + i;
      i = i >> 1;
    } else {
      i = i + j;
      j = j >> 1;
    }

    k = k + 1;
  }

  while (i > 0) {
    j = j >> 1;
    k = i + j;
    while (k < end) {
      if (arr[k] > arr[k - i]) {
        break;
      }
      int temp = arr[k];
      arr[k] = arr[k - i];
      arr[k - i] = temp;
      k = k + i;
      //       snap(arr, k, i); // Snap 1  Does nothing
    }
    snap(arr, i, j); // Snap C new
    i = j;
  }
}

// Smooth Sort function
static void smoothSort(int[] arr)
{
  sortName = "Smooth Sort";
  int n = aSize;

  int p = n - 1;
  int q = p;
  int r = 0;

  // Build the Leonardo heap by merging
  // pairs of adjacent trees
  while (p > 0) {
    if ((r & 0x03) == 0) {
      smoothHeapify(arr, r, q);
      //       snap(arr, r, q);      //Snap A new
    }

    if (leonardo(r) == p) {
      r = r + 1;
    } else {
      r = r - 1;
      q = q - leonardo(r);
      smoothHeapify(arr, r, q);
      //        snap(arr, r, q); //  Snap B new
      q = r - 1;
      r = r + 1;
    }

    int temp = arr[0];
    arr[0] = arr[p];
    arr[p] = temp;
    snap(arr, temp, p);  // Snap 2 Doesn't do much.
    p = p - 1;
  }

  // Convert the Leonardo heap
  // back into an array
  for (int i = 0; i < n - 1; i++) {
    int j = i + 1;
    //      snap(arr, i, j); // Snap 3
    while (j > 0 && arr[j] < arr[j - 1]) {
      int temp = arr[j];
      arr[j] = arr[j - 1];
      arr[j - 1] = temp;
      j = j - 1;
    }
    snap(arr, i, j);   //Snap 4 needs to be here or sort draw won't finish.
  }
}



public static int minRunLength(int n)
{
  assert n >= 0;

  // Becomes 1 if any 1 bits are shifted off
  int r = 0;
  while (n >= MIN_MERGE) {
    r |= (n & 1);
    n >>= 1;
  }
  return n + r;
}

// This function sorts array from left index to
// to right index which is of size atmost RUN


public static void timInsertionSort(int[] arr, int left,
  int right)
{
  for (int i = left + 1; i <= right; i++) {
    int temp = arr[i];
    aas++;
    int j = i - 1;
    while (j >= left && arr[j] > temp) {
      arr[j + 1] = arr[j];
      j--;
      comps++;
      aas+=3;
      //     snap(arr, i, j);
    }
    arr[j + 1] = temp;
    aas++;
    snap(arr, i, j+1);
  }
}

// Merge function merges the sorted runs
static void timMerge(int arr[], int start, int mid, int end)
{


  int start2 = mid + 1;


  // If the direct merge is already sorted
  if (arr[mid] <= arr[start2]) {
    comps++;
    aas+=2;
    return;
  }

  // Two pointers to maintain start
  // of both arrays to merge
  while (start <= mid && start2 <= end) {

    // If element 1 is in right place
    if (arr[start] <= arr[start2]) {
      start++;
      comps++;
      aas+=2;
    } else {
      int value = arr[start2];
      aas++;
      int index = start2;

      // Shift all the elements between element 1
      // element 2, right by 1.
      while (index != start) {
        arr[index] = arr[index - 1];
        index--;
        aas+=2;
      }
      arr[start] = value;
      aas++;
      snap(arr, start, start2 + 1);

      // Update all the pointers
      start++;
      mid++;
      start2++;
    }

    //   snap(arr, start, mid+1);
  }
  snap(arr, start, end);
}
// Iterative Timsort function to sort the
// array[0...n-1] (similar to merge sort)


public static void timSort(int[] arr, int n)
{
  sortName = "Tim Sort";
  int minRun = minRunLength(MIN_MERGE);

  // Sort individual subarrays of size RUN
  for (int i = 0; i < n; i += minRun) {
    timInsertionSort(arr, i, Math.min((i + MIN_MERGE - 1), (n - 1)));
  }

  // Start merging from size
  // RUN (or 32). It will
  // merge to form size 64,
  // then 128, 256 and so on
  // ....
  for (int size = minRun; size < n; size = 2 * size) {

    // Pick starting point
    // of left sub array. We
    // are going to merge
    // arr[left..left+size-1]
    // and arr[left+size, left+2*size-1]
    // After every merge, we
    // increase left by 2*size
    for (int left = 0; left < n; left += 2 * size) {

      // Find ending point of left sub array
      // mid+1 is starting point of right sub
      // array
      int mid = left + size - 1;
      int right = Math.min((left + 2 * size - 1),
        (n - 1));

      // Merge sub array arr[left.....mid] &
      // arr[mid+1....right]
      if (mid < right)
        timMerge(arr, left, mid, right);
    }
  }
}
// Java program for Bitonic Sort. Note that this program
// works only when size of input is a power of 2.

// The parameter dir indicates the sorting direction,
// ASCENDING or DESCENDING; if (a[i] > a[j]) agrees
// with the direction, then a[i] and a[j] are
// interchanged.

void compAndSwap(int a[], int i, int j, int dir)
{
  if ((a[i] > a[j] && dir == 1)
    || (a[i] < a[j] && dir == 0)) {
    // Swapping elements
    int temp = a[i];
    a[i] = a[j];
    a[j] = temp;
    snap(a, i, j);
  }
}

/* It recursively sorts a bitonic sequence in ascending
 order, if dir = 1, and in descending order otherwise
 (means dir=0). The sequence to be sorted starts at
 index position low, the parameter cnt is the number
 of elements to be sorted.*/
void bitonicMerge(int a[], int low, int cnt, int dir)
{
  if (cnt > 1) {
    int k = cnt / 2;
    for (int i = low; i < low + k; i++)
      compAndSwap(a, i, i + k, dir);
    bitonicMerge(a, low, k, dir);
    bitonicMerge(a, low + k, k, dir);
  }
}

/* This function first produces a bitonic sequence by
 recursively sorting its two halves in opposite
 sorting orders, and then calls bitonicMerge to make
 them in the same order */
void bitonicSort(int a[], int low, int cnt, int dir)

{
  sortName = "Bi-tonic Sort";
  if (cnt > 1) {
    int k = cnt / 2;

    // sort in ascending order since dir here is 1
    bitonicSort(a, low, k, 1);

    // sort in descending order since dir here is 0
    bitonicSort(a, low + k, k, 0);

    // Will merge whole sequence in ascending order
    // since dir=1.
    bitonicMerge(a, low, cnt, dir);
  }
}

//*************************************************************************************************************

// Java program to implement
// dual pivot QuickSort


static void dpqsSwap(int[] arr, int i, int j)
{
  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
  snap(arr, i, j);
}

static void dualPivotQuickSort(int[] arr, int low, int high)
{
  sortName = "Dual Pivot QuickSort";
  if (low < high)
  {

    // piv[] stores left pivot and right pivot.
    // piv[0] means left pivot and
    // piv[1] means right pivot
    int[] piv;
    piv = dpqsPartition(arr, low, high);

    dualPivotQuickSort(arr, low, piv[0] - 1);
    //      snap(arr, low, piv[0] -1);
    dualPivotQuickSort(arr, piv[0] + 1, piv[1] - 1);
    //     snap(arr, piv[0] + 1, piv[1] -1);
    dualPivotQuickSort(arr, piv[1] + 1, high);
    //      snap(arr,piv[1] + 1, high);
  }
}

static int[] dpqsPartition(int[] arr, int low, int high)
{
  if (arr[low] > arr[high])
    dpqsSwap(arr, low, high);

  // p is the left pivot, and q
  // is the right pivot.
  int j = low + 1;
  int g = high - 1, k = low + 1,
    p = arr[low], q = arr[high];

  while (k <= g)
  {

    // If elements are less than the left pivot
    if (arr[k] < p)
    {
      dpqsSwap(arr, k, j);
      j++;
    }

    // If elements are greater than or equal
    // to the right pivot
    else if (arr[k] >= q)
    {
      while (arr[g] > q && k < g)
        g--;

      dpqsSwap(arr, k, g);
      g--;

      if (arr[k] < p)
      {
        dpqsSwap(arr, k, j);
        j++;
      }
    }
    k++;
  }
  j--;
  g++;

  // Bring pivots to their appropriate positions.
  dpqsSwap(arr, low, j);
  dpqsSwap(arr, high, g);

  // Returning the indices of the pivots
  // because we cannot return two elements
  // from a function, we do that using an array.
  return new int[] { j, g };
}
