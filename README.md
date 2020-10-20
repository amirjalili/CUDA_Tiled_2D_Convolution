# CUDA_Tiled_2D_Convolution

Tiled implementation of a 2D matrix convolution by utilizing the shared and global constant memory within GPU thread blocks to minimize the memory bandwidth bottleneck and achieve a higher performance speedup. 

Matrix convolution is primarily used in image processing for tasks such as image enhancing, blurring, etc. A standard image convolution formula for a 5x5 convolution filter M with an Image N is:
```
P (i, j) = sum over a=0->4(sum over b=0->4(M [a][b] ∗ N [i + a − 2][j + b − 2])), where 0 ≤ i < N.height and 0 ≤ j < N.width
```

**Execution:**

* Run "make" to build the executable of this file.
* For debugging, run "make dbg=1" to build a debuggable version of the executable binary.
* Run the binday using the command "./matrixmul"

There are several modes of operation for the application:
* No arguments: The application will create a randomized Filter M and Image N. A CPU implementation of the convolution algorithm will be used to generate a correct solution which will be compared with your program’s output. If it matches (within a certain tolerance), it will print out “Test PASSED” to the screen before exiting.
* One argument: The application will create a randomized Filter M and Image N, and write the device-computed output to the file specified by the argument.
* Three arguments: The application will read the filter and image from provided files. The first argument should be a file containing two integers representing the image height and width respectively. The second and third function arguments should be files which have exactly enough entries to fill the Filter M and Image N respectively. No output is written to file.
* Four arguments: The application will read its inputs using the files provided by the first three arguments, and write its output to the file provided in the fourth.



**Input File Format:**

The (optional) input files should have a single line containing whitespace- separated floating point numbers representing the matrix data. There should be m · n numbers on this line for a m × n matrix, where the first n numbers are the first row, the second n numbers are the second row, etc. For example, to represent the following matrix: [1 2 3] [4 5 6] [7 8 9] 

The corresonding input file should contain the following line (without quotes): “1 2 3 4 5 6 7 8 9”

If you wish to use the output file from one run of the application as an input in a later run, you must delete the first line in the output file, which displays the accuracy of the values within the file.
