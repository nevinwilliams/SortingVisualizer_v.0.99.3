// Java program to implement cycle sort



// Function sort the array using Cycle sort
public static void cycleSort(int arr[])
{
  // count number of memory writes
  int writes =0;
  int n = aSize;

  // traverse array elements and put it to on
  // the right place
  for (int cycle_start = 0; cycle_start <= n - 2; cycle_start++) {
    // initialize item as starting point
    int item = arr[cycle_start];
    aas++;
    // Find position where we put the item. We basically
    // count all smaller elements on right side of item.
    int pos = cycle_start;
    for (int i = cycle_start + 1; i < n; i++)
      if (arr[i] < item) {
        pos++;
        aas++;
        comps++;
        snap(arr, 0, i);
      }

    // If item is already in correct position
    if (pos == cycle_start)
      continue;

    // ignore all duplicate elements
    while (item == arr[pos])
      pos += 1;
    aas++;

    // put the item to it's right position
    if (pos != cycle_start) {
      int temp = item;
      item = arr[pos];
      arr[pos] = temp;
      writes++;
      aas+=2;
      snap(arr, 0, pos);
    }

    // Rotate rest of the cycle
    while (pos != cycle_start) {
      pos = cycle_start;

      // Find position where we put the element
      for (int i = cycle_start + 1; i < n; i++)
        if (arr[i] < item)
          pos += 1;
      aas++;
      comps++;
      // ignore all duplicate elements
      while (item == arr[pos])
        pos += 1;

      // put the item to it's right position
      if (item != arr[pos]) {
        int temp = item;
        item = arr[pos];
        arr[pos] = temp;
        writes++;
        comps++;
        aas+=3;
        snap(arr, 0, pos);
      }
      aas++;
      comps++;
      snap(arr, 0, pos);
    }
    snap (arr, 0, pos);
  }
  snap(arr, 0, aSize);
}

// To heapify a subtree rooted with node i
// which is an index in arr[].
static void heapify(int arr[], int n, int i) {

  // Initialize largest as root
  int largest = i;

  // left index = 2*i + 1
  int l = 2 * i + 1;

  // right index = 2*i + 2
  int r = 2 * i + 2;

  // If left child is larger than root
  if (l < n && arr[l] > arr[largest]) {
    largest = l;
    aas+=2;
    comps++;
  }

  // If right child is larger than largest so far
  if (r < n && arr[r] > arr[largest]) {
    largest = r;
    aas+=2;
    comps++;
  }

  // If largest is not root
  if (largest != i) {
    int temp = arr[i];
    arr[i] = arr[largest];
    arr[largest] = temp;
    swaps++;
    aas+=3;
    snap(arr, i, largest);
    // Recursively heapify the affected sub-tree
    heapify(arr, n, largest);
  }
}

// Main function to do heap sort
static  void heapSort(int arr[]) {
  int n = aSize;
  // Build heap (rearrange array)
  for (int i = n / 2 - 1; i >= 0; i--) {

    heapify(arr, n, i);
  }

  // One by one extract an element from heap
  for (int i = n - 1; i > 0; i--) {

    // Move current root to end
    int temp = arr[0];
    arr[0] = arr[i];
    arr[i] = temp;
    swaps++;
    aas+=3;
    snap(arr, 0, i);

    // Call max heapify on the reduced heap
    heapify(arr, i, 0);
  }
  //        snap(arr, 0, 0);
  //      return(arr);   //replace if method nees to be int[]
}


void insertionSort(int arr[])
{


  int n = aSize;
  for (int i = 1; i < n; ++i) {
    int key1 = arr[i];
    int j = i - 1;

    snap(arr, i, j+1);

    /* Move elements of arr[0..i-1], that are
     greater than key, to one position ahead
     of their current position */
    while (j >= 0 && arr[j] > key1) {
      arr[j + 1] = arr[j];
      j = j - 1;

      snap(arr, i, j+1);
    }
    arr[j + 1] = key1;



    snap(arr, i, j+1);
  }

  snap(arr, 0, aSize - 1);
}
