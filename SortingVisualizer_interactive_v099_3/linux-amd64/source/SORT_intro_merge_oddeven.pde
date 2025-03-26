// Java implementation of Introsort algorithm

// doesn't yet work

public class Introsort {

  // the actual data that has to be sorted
  private int a[];

  // the number of elements in the data
  private int n;

  // Constructor to initialize the size
  // of the data
  Introsort(int n)
  {
    a = new int[n];
    this.n = 0;
  }

  // The utility function to insert the data
  private void dataAppend(int temp)
  {
    a[n] = temp;
    n++;
  }

  // The utility function to swap two elements
  private void swap(int i, int j)
  {
    int temp = a[i];
    a[i] = a[j];
    a[j] = temp;
  }

  // To maxHeap a subtree rooted with node i which is
  // an index in a[]. heapN is size of heap
  private void maxHeap(int i, int heapN, int begin)
  {
    int temp = a[begin + i - 1];
    int child;

    while (i <= heapN / 2) {
      child = 2 * i;

      if (child < heapN
        && a[begin + child - 1] < a[begin + child])
        child++;

      if (temp >= a[begin + child - 1])
        break;

      a[begin + i - 1] = a[begin + child - 1];
      i = child;
    }
    a[begin + i - 1] = temp;
  }

  // Function to build the heap (rearranging the array)
  private void introHeapify(int begin, int end, int heapN)
  {
    for (int i = (heapN) / 2; i >= 1; i--)
      maxHeap(i, heapN, begin);
  }

  // main function to do heapsort
  private void introHeapSort(int begin, int end)
  {
    int heapN = end - begin;

    // Build heap (rearrange array)
    this.introHeapify(begin, end, heapN);

    // One by one extract an element from heap
    for (int i = heapN; i >= 1; i--) {

      // Move current root to end
      swap(begin, begin + i);

      // call maxHeap() on the reduced heap
      maxHeap(1, i, begin);
    }
  }

  // function that implements insertion sort
  private void introInsertionSort(int left, int right)
  {

    for (int i = left; i <= right; i++) {
      int key1 = a[i];
      int j = i;

      // Move elements of arr[0..i-1], that are
      // greater than the key, to one position ahead
      // of their current position
      while (j > left && a[j - 1] > key1) {
        a[j] = a[j - 1];
        j--;
      }
      a[j] = key1;
    }
  }

  // Function for finding the median of the three elements
  private int findPivot(int a1, int b1, int c1)
  {
    int max = Math.max(Math.max(a[a1], a[b1]), a[c1]);
    int min = Math.min(Math.min(a[a1], a[b1]), a[c1]);
    int median = max ^ min ^ a[a1] ^ a[b1] ^ a[c1];
    if (median == a[a1])
      return a1;
    if (median == a[b1])
      return b1;
    return c1;
  }

  // This function takes the last element as pivot, places
  // the pivot element at its correct position in sorted
  // array, and places all smaller (smaller than pivot)
  // to the left of the pivot
  // and greater elements to the right of the pivot
  private int partition(int low, int high)
  {

    // pivot
    int pivot = a[high];

    // Index of smaller element
    int i = (low - 1);
    for (int j = low; j <= high - 1; j++) {

      // If the current element is smaller
      // than or equal to the pivot
      if (a[j] <= pivot) {

        // increment index of smaller element
        i++;
        swap(i, j);
      }
    }
    swap(i + 1, high);
    return (i + 1);
  }

  // The main function that implements Introsort
  // low --> Starting index,
  // high --> Ending index,
  // depthLimit --> recursion level
  private void sortDataUtil(int begin, int end, int depthLimit)
  {
    if (end - begin > 16) {
      if (depthLimit == 0) {

        // if the recursion limit is
        // occurred call heap sort
        this.introHeapSort(begin, end);
        return;
      }

      depthLimit = depthLimit - 1;
      int pivot = findPivot(begin,
        begin + ((end - begin) / 2) + 1,
        end);
      swap(pivot, end);

      // p is partitioning index,
      // arr[p] is now at right place
      int p = partition(begin, end);

      // Separately sort elements before
      // partition and after partition
      sortDataUtil(begin, p - 1, depthLimit);
      sortDataUtil(p + 1, end, depthLimit);
    } else {
      // if the data set is small,
      // call insertion sort
      introInsertionSort(begin, end);
    }
  }

  // A utility function to begin the
  // Introsort module
  private void sortData()
  {

    // Initialise the depthLimit
    // as 2*log(length(data))
    int depthLimit
      = (int)(2 * Math.floor(Math.log(n) /
      Math.log(2)));

    this.sortDataUtil(0, n - 1, depthLimit);
  }
}

//***************************************************In-place Merge Sort*********************************

void mergeSort(int arr[], int left, int right) {



  if (left < right) {

    // Same as (l + r) / 2, but avoids overflow
    // for large l and r
    int mid = left + (right - left) / 2;

    // Sort first and second halves

    mergeSort(arr, left, mid);

    mergeSort(arr, mid + 1, right);

    merge(arr, left, mid, right);


    snap(arr, left, right+1);
  }

//  snap(arr, left, right+1);
}

// Merges two subarrays of arr[].
// First subarray is arr[l..m]
// Second subarray is arr[m+1..r]
// Inplace Implementation
void merge(int arr[], int start, int mid, int end)
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

/* l is for left index and r is right index of the
 sub-array of arr to be sorted */




//public static void oddEvenSort(int[] arr) {
//  int threadNum = aSize/2;
//  CyclicBarrier barr = new CyclicBarrier(threadNum);
//  ExecutorService exec = Executors.newFixedThreadPool(threadNum);
//  Future<?>[] awaits = new Future<?>[threadNum];
//  for (int i = 0; i < threadNum; i++) {
//    awaits[i] = exec.submit(new CompareSwapThread(arr, 2*i + 1, barr));
//  }
//  for (int i = 0; i < threadNum; i++) {
//    try {
//      awaits[i].get();
//    }
//    catch (InterruptedException | ExecutionException e) {
//      e.printStackTrace();
//    }
//  }
//}


//  class CompareSwapThread implements Runnable {
//    private int[] arr;
//    private int index;
//    private CyclicBarrier barr;

//    public CompareSwapThread(int[] arr, int index, CyclicBarrier barr) {
//      this.arr = arr;
//      this.index = index;
//      this.barr = barr;
//    }

//    @Override
//      public void run() {
//      for (int i = 0; i < aSize; i++) {
//        if (arr[index - 1] > arr[index]) {
//          int t = arr[index - 1];
//          arr[index - 1] = arr[index];
//          arr[index] = t;
//        }
//        try {
//          barr.await();
//        }
//        catch (InterruptedException | BrokenBarrierException e) {
//          e.printStackTrace();
//        }
//        if (index + 1 < aSize && arr[index] > arr[index + 1]) {
//          int t = arr[index];
//          arr[index] = arr[index + 1];
//          arr[index + 1] = t;
//        }
//        try {
//          barr.await();
//        }
//        catch (InterruptedException | BrokenBarrierException e) {
//          e.printStackTrace();
//        }
//      }
//    }
//  }
