static void bubbleSort(int arr[])
{
  int i, j, temp;
  int n = aSize;
  boolean swapped;

  for (i = 0; i < n - 1; i++) {

    swapped = false;

    for (j = 0; j < n - i - 1; j++) {

      if (arr[j] > arr[j + 1]) {
        temp = arr[j];
        arr[j] = arr[j + 1];
        arr[j + 1] = temp;
        swapped = true;
      }

      snap(arr, j, j + 1);
    }
    // If no two elements were
    // swapped by inner loop, then break
    if (swapped == false)
    {
 //     snap(arr, 0, aSize -1);
      
    }
  }

//snap(arr, 0, aSize -1);
}

public static void cocktailSort(int[] nums)

    {
    boolean swapped;
    do {
    swapped = false;
    for (int i =0; i<=  aSize  - 2;i++) {
   
      if (nums[ i ] > nums[ i + 1 ]) {

        //test if two elements are in the wrong order
        int temp = nums[i];
        nums[i] = nums[i+1];
        nums[i+1]=temp;
        swapped = true;
        snap(nums, i, i);
      }
    }
    if (!swapped) {
      break;
    }
    swapped = false;
    for (int i= aSize - 2;i>=0;i--) {
      if (nums[ i ] > nums[ i + 1 ]) {
        int temp = nums[i];
        nums[i] = nums[i+1];
        nums[i+1]=temp;
        swapped = true;
        snap(nums, i-1, i-1);
      }
    }
  } while (swapped);
  snap(nums,0,aSize -1);
 
}



    // Java program for implementation of Comb Sort


public static int getNextGap(int gap)
    {
        // Shrink gap by Shrink factor
        gap = (gap*10)/13;
        if (gap < 1)
            return 1;
        return gap;
    }

public static void combSort (int[] array)

                            
{
   
        int n = aSize;
        snap(array, 0, n-1);
        // initialize gap
        int gap = n;

        // Initialize swapped as true to make sure that
        // loop runs
        boolean swapped = true;

        // Keep running while gap is more than 1 and last
        // iteration caused a swap
        while (gap >= 1 && swapped == true)
        {
            // Find next gap
            gap = getNextGap(gap);

            // Initialize swapped as false so that we can
            // check if swap happened or not
            swapped = false;

            // Compare all elements with current gap
            for (int i=0; i<n-gap; i++)
            {
              snap(array, i, i + gap);
              
                if (array[i] > array[i+gap])
                {
                    // Swap arr[i] and arr[i+gap]
                    int temp = array[i];
                    array[i] = array[i+gap];
                    array[i+gap] = temp;
                    
               //     snap(array, i, i + gap, aList, ptrList);

                    // Set swapped
                    swapped = true;
                }
            }
        }
    }
