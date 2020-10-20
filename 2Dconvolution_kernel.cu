#ifndef _2DCONVOLUTION_KERNEL_H_
#define _2DCONVOLUTION_KERNEL_H_

#include <stdio.h>
#include "2Dconvolution.h"

// Matrix multiplication kernel thread specification
__global__ void ConvolutionKernel(Matrix N, Matrix P)
{
    // Allocate Block_size x Block_size shared memory space
    __shared__ float N_s[BLOCK_SIZE][BLOCK_SIZE];

    int tx = threadIdx.x;
    int ty = threadIdx.y;

    int row_o = ty + blockIdx.y * TILE_SIZE;
    int col_o = tx + blockIdx.x * TILE_SIZE;


    // shift the indecies to get the correct input indecies 
    int row_i = row_o - KERNEL_SIZE/2;
    int col_i = col_o - KERNEL_SIZE/2;

    // Load all the elements needed for the tile 
    if(row_i >= 0 && row_i < N.height && col_i >= 0 && col_i < N.width)
        N_s[ty][tx] = N.elements[row_i*N.width + col_i];
    else
        N_s[ty][tx] = 0.0f;

    
    __syncthreads();

    // only the output threads compute and store the results
    if(tx < TILE_SIZE && ty < TILE_SIZE){
        float pValue = 0.0f;
        for(int y=0; y<KERNEL_SIZE; y++)
            for(int x=0; x<KERNEL_SIZE; x++)
                pValue += Mc[y*KERNEL_SIZE + x] * N_s[y+ty][x+tx];
    
        if(row_o < P.height && col_o < P.width)
            P.elements[row_o*P.width + col_o] = pValue;
    }

}

#endif // #ifndef _2DCONVOLUTION_KERNEL_H_
