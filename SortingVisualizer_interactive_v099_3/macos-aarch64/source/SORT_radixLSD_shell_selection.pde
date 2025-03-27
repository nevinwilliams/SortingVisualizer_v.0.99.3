// Radix sort Java implementation

// A utility function to get maximum value in arr[]
static int getMax(int arr[], int n)
{
  int mx = arr[0];
  for (int i = 1; i < n; i++) {
    if (arr[i] > mx) {
      mx = arr[i];
    }
  }
  return mx;
}

// A function to do counting sort of arr[] according to
// the digit represented by exp.
static void countSort(int arr[], int n, int exp)
{
  int output[] = new int[n]; // output array
  int i;
  int count[] = new int[base];
  Arrays.fill(count, 0);

  // Store count of occurrences in count[]
  for (i = 0; i < n; i++) {
    count[(arr[i] / exp) % base]++;
  }
  // Change count[i] so that count[i] now contains
  // actual position of this digit in output[]
  for (i = 1; i < base; i++) {
    count[i] += count[i - 1];
  }
  // Build the output array
  for (i = n - 1; i >= 0; i--) {
    output[count[(arr[i] / exp) % base] - 1] = arr[i];
    count[(arr[i] / exp) % base]--;
    snap(output, 0, arr[i]);
  }

  //  snap(output, 0, iter);

  // Copy the output array to arr[], so that arr[] now
  // contains sorted numbers according to current
  // digit
  for (i = 0; i < n; i++) {
    arr[i] = output[i];
  }
}

// The main function to that sorts arr[] of
// size n using Radix Sort
static void radixSort(int arr[])
{
  sortName = "Radix LSD Sort";
  int n = aSize;
  // Find the maximum number to know number of digits
  int m = getMax(arr, n);

  // Do counting sort for every digit. Note that
  // instead of passing digit number, exp is passed.
  // exp is 10^i where i is current digit number
  for (int exp = 1; m / exp > 0; exp *= base)
    countSort(arr, n, exp);
}


static void selectionSort(int arr[])
{
  sortName = "Selection Sort";
  int n = aSize;
  for (int i = 0; i < n-1; i++)
  {
    int index = i;
    int min = arr[i];
    for (int j = i+1; j < n; j++)
    {
      if (arr[j] < arr[index])
      {
        index = j;

        min = arr[j];
        snap(arr, i-1, j);
      }
      snap (arr, i-1, j);
    }
    int t = arr[index];
    arr[index] = arr[i];
    arr[i] = t;
    snap(arr, i, index);
  }
  snap(arr, 0, aSize -1);
}

static void shellSort(int[] arr) {

  sortName = "Shell's Sort";
  
  int n = aSize;


  for (int gap = n / 2; gap > 0; gap /= 2) {

    for (int i = gap; i < n; i++) {
      int key1 = arr[i];
      aas++;
      int j = i;



      while (j >= gap && arr[j - gap] > key1) {
        arr[j] = arr[j - gap];
        j -= gap;
        comps++;
        swaps++;
        aas+=3;

        snap(arr, i, j - gap);
      }

      arr[j] = key1;
      aas++;
      snap(arr, i, j);
    }
    // needed to complete sort drawing
    snap(arr, 0, aSize - 1);
  }
  // needed to complete sort.
  snap(arr, 0, aSize -1);
}
