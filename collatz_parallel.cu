#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>
#include <cuda.h>

typedef unsigned int uint32;
typedef unsigned long long int uint64;

__device__ int collatz_iter(uint64 start, bool* thread_overflow) {
    uint32 total = 0;
    uint64 a_i = start;
    while (a_i != 1) {
        total++;
        if (a_i % 2 == 0) {
            a_i /= 2;
        } else {
            if (a_i <= 6148914691236517204ULL) {
                a_i = 3 * a_i + 1;
            } else {
                *thread_overflow = true;
                break;
            }
        }
    }
    return total;
}

__device__ uint64 compress_info(int thread_total, uint64 start) {
    uint64 info = thread_total;
    info = info << 48;
    info += start;
    return info;
}


__global__ void collatz(uint64 m, uint64 n, uint64* max_info, int* total_overflow) {
    uint64 thread_num = (uint64)blockIdx.x * blockDim.x + threadIdx.x;
    if (thread_num < (uint64) n - m + 1) {
        uint64 value = m + thread_num;
        bool thread_overflow = false;
        int thread_total = collatz_iter(value, &thread_overflow);
        if (thread_overflow) {
            atomicAdd(total_overflow, 1);
        }
        uint64 info = compress_info(thread_total, value);
        atomicMax(max_info, info);
    }
}

void extract_info (uint64 info, int* thread_total, uint64* start) {
    *start = info & 0xFFFFFFFFFFFF;
    info = info >> 48;
    *thread_total = info;
}

int main (int argc, char** argv) {

    // get M and N from the command line
    if (argc < 4) {
        printf ("Command usage : %s %s %s %s\n",argv[0],"M","N","B");
        return 1;
    }
    uint64 M = atol(argv[1]);
    uint64 N = atol(argv[2]);
    uint64 B = atol(argv[3]);

    // start the timer
    clock_t start = clock();

    uint64* d_max_info;
    cudaMalloc(&d_max_info, sizeof(uint64));
    if (d_max_info == NULL) {
        printf("cudaMalloc failed\n");
        return 1;
    }

    int* d_total_overflow;
    cudaMalloc(&d_total_overflow, sizeof(int));
    if (d_total_overflow == NULL) {
        printf("cudaMalloc failed\n");
        return 1;
    }

    cudaMemset(d_max_info, 0, sizeof(uint64));
    cudaMemset(d_total_overflow, 0, sizeof(int));

    int G = (N - M + B - 1) / B;
    collatz<<<G, B>>>(M, N, d_max_info, d_total_overflow);
    cudaError_t err = cudaGetLastError();
    if (err != cudaSuccess) {
        printf("CUDA error: %s\n", cudaGetErrorString(err));
    }
    cudaDeviceSynchronize(); // Ensure kernel execution has finished

    int num_overflow;
    uint64 max_info;
    cudaMemcpy(&max_info, d_max_info, sizeof(uint64), cudaMemcpyDeviceToHost);
    cudaMemcpy(&num_overflow, d_total_overflow, sizeof(int), cudaMemcpyDeviceToHost);

    // stop the timer
    clock_t stop = clock();
    double elapsed = (double)(stop-start)/CLOCKS_PER_SEC;

    int max_total;
    uint64 max_start;
    extract_info(max_info, &max_total, &max_start);

    // output the results
    printf("M = %llu, N = %llu\n", M, N);
    printf("threads per block B = %llu\n", B);
    printf("number of thread blocks G = %u\n", G);
    printf("number of threads G*B = %llu\n", G*B);
    printf ("A starting value between %llu and %llu (inclusive)\n",M,N);
    printf ("  having the largest total stopping time is %llu\n",max_start);
    printf ("  which has %u steps\n",max_total);
    printf ("Number of start values that result in overflow = %d\n",num_overflow);
    printf ("elapsed time = %.2f seconds\n",elapsed);

    cudaFree(d_max_info);
    cudaFree(d_total_overflow);

    return 0;
}
