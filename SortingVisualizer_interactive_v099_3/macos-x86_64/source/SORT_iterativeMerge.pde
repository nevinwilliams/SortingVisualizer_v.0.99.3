// Java program to perform
// iterative merge sort.

// Helper function to merge two sorted portions of the array
static void iterativeMerge(int arr[], int start, int mid, int end)
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
      comps+=2;
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
      snap(arr, start, start2+1);

      // Update all the pointers
      start++;
      mid++;
      start2++;
    }

    //   snap(arr, start, mid+1);
  }
  snap(arr, start, end+1);
}

// Main sorting function
static void iterativeMergeSort(int[] arr) {
  int n = aSize;

  // Iterate through subarrays of increasing size
  for (int currSize = 1; currSize <= n - 1;
    currSize = 2 * currSize) {

    // Pick starting points of different
    // subarrays of current size
    for (int leftStart = 0; leftStart < n - 1;
      leftStart += 2 * currSize) {

      // Find endpoints of the subarrays to be merged
      int mid = Math.min(leftStart + currSize - 1, n - 1);
      int rightEnd = Math.min(leftStart + 2 * currSize - 1, n - 1);

      // Merge the subarrays arr[leftStart...mid]
      // and arr[mid+1...rightEnd]
      iterativeMerge(arr, leftStart, mid, rightEnd);
    }
    snap(arr,0, aSize);
  }
  snap(arr, 0, aSize);
}
