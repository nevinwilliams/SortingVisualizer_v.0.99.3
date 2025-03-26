/* Java program to implement Pigeonhole Sort */

public static void pigeonholeSort(int arr[])
{
  int min = arr[0];
  int max = arr[0];
  int range, i, j, index;
  int n = aSize;

  for (int a=0; a<n; a++)
  {
    if (arr[a] > max) {
      max = arr[a];
      aas+=2;
    }
    comps++;
    aas++;

    if (arr[a] < min) {
      min = arr[a];
      aas+=2;
    }
    comps++;
  }

  range = max - min + 1;

  int[] phole = new int[range];

  Arrays.fill(phole, 0);

  aas+= range;
  snap(phole, 0, aSize);

  for (i = 0; i<n; i++) {
    phole[arr[i] - min]++;
    aas++;
    snap(phole, i, aSize);
  }
snap(arr, 0, aSize);
  index = 0;

  for (j = 0; j<range; j++) {
    while (phole[j]-->0) {
      arr[index++]=j+min;
      aas++;
      snap(arr, 0, j);
    }
  }
}

//************************************************************************************************************
// The QuickSort function implementation

static void quickSort(int arr[], int low, int high) {



  if (low < high) {

    // partitionIndex is the partition return index of pivot

    int partitionIndex = qsPartition(arr, low, high);

    // Recursion calls for smaller elements
    // and greater or equals elements

    quickSort(arr, low, partitionIndex - 1);

    //      snap(arr, low, partitionIndex);

    quickSort(arr, partitionIndex + 1, high);
//    snap(arr, partitionIndex + 1, high);
  }

}

// Partition function
static int qsPartition(int[] arr, int low, int high)
{

  // Choose the pivot
  int pivot = arr[high];
  aas++; // array access.

  // Index of smaller element and indicates
  // the right position of pivot found so far
  int i = low - 1;

  // Traverse arr[low..high] and move all smaller
  // elements to the left side. Elements from low to
  // i are smaller after every iteration

  for (int j = low; j <= high - 1; j++) {


    if (arr[j] < pivot) {
      i++;

      comps++;  // counts as a comparison.
      aas++; // counts as an array access.

      qsSwap(arr, i, j);
    }
  }

  // Move pivot after smaller elements and
  // return its position

  qsSwap(arr, i + 1, high);

  return i + 1;
}

// Swap function

static void qsSwap( int[] arr, int i, int j)
{

  int temp = arr[i];
  arr[i] = arr[j];
  arr[j] = temp;
  aas+=4;
  // The _only_ snapshot needed. maybe.

  snap(arr, i, j);
}


//*******************************************************************************************

// Java implementation of MSD Radix Sort
// of MSD Radix Sort using counting sort()


// A utility function to get the digit
// at index d in a integer
static int digit_at(int x, int d)
{
  return (int)(x / Math.pow(base, d - 1)) % base;
}

// The main function to sort array using
// MSD Radix Sort recursively
static int[] MSD_sort(int[] arr, int lo, int hi, int d)
{
  //snap(arr, lo, hi);  // Snap 1
  // recursion break condition
  if (hi <= lo) {
    //    snap(arr, lo, hi); // Snap 2
    return arr;
  }

  int count[] = new int[base + 2];

  // temp is created to easily swap Strings in arr[]
  HashMap<Integer, Integer> temp = new HashMap<>();

  // Store occurrences of most significant character
  // from each integer in count[]
  for (int i = lo; i <= hi; i++) {
    int c = digit_at(arr[i], d);
    count[c + 2]++;
  }

  // Change count[] so that count[] now contains actual
  //  position of this digits in temp[]
  for (int r = 0; r < base + 1; r++) {
    count[r + 1] += count[r];
  }
  // Build the temp
  for (int i = lo; i <= hi; i++) {
    int c = digit_at(arr[i], d);

    if (temp.containsKey(count[c + 1]+1)) {

      temp.put(count[c + 1]++, arr[i]);
    } else {

      temp.put(count[c + 1]++, arr[i]);
    }
  }

  // Copy all integers of temp to arr[], so that arr[] now
  // contains partially sorted integers
  for (int i = lo; i <= hi; i++) {
    if (temp.containsKey(i-lo)) {
      arr[i] = temp.get(i - lo);
      snap(arr, i, hi); // Snap3
    }
  }
  // Recursively MSD_sort() on each partially sorted
  // integers set to sort them by their next digit
  for (int r = 0; r < base; r++) {
    arr = MSD_sort(arr, lo + count[r], lo + count[r + 1] - 1, d - 1);
    //   snap(arr, r, aSize); // Snap4
  }

  //  snap(arr, 0, aSize); // Snap5
  return arr;
}

// function find the largest integer
static int getMMax(int arr[], int n)
{
  int mx = arr[0];
  for (int i = 1; i < n; i++) {
    if (arr[i] > mx) {
      mx = arr[i];
    }
  }
  return mx;
}

// Main function to call MSD_sort
static int[] radixMSDSort(int[] arr)
{
  int n = aSize;
  // Find the maximum number to know number of digits
  int m = getMMax(arr, n);

  // get the length of the largest integer
  int d = (int)Math.floor((Math.log(Math.abs(m))/Math.log(base))) + 1;
//  int d = (int)Math.floor(Math.log10(Math.abs(m))) + 1;  original

  // function call
  return MSD_sort(arr, 0, n - 1, d);
}
