#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

typedef unsigned int uint32;
typedef unsigned long long int uint64;

// compute the total stopping time of a given start value
// sets *overflow to true if cannot finish calculating the total
// stopping time due to an intermediate value too large for uint64
// WARNING: If *overflow is true then the returned total stopping time
//          is not accurate!
uint32 total_stopping_time (uint64 start, bool* overflow) {
    uint32 total = 0;
    uint64 a_i = start;
    while (a_i != 1) {
        total += 1;
        if (a_i % 2 == 0) {
            a_i /= 2;
        } else {
	    if (a_i <= 6148914691236517204ULL) {
		a_i = 3*a_i + 1;
	    } else {
		*overflow = true;
		break;
	    }
        }
    }
    return total;
}

// Find a start value between M and N (inclusive) that 
// has the largest total stopping time.  
// Keep track of the number of start values that result in overflow.
// WARNING: If num_overflow > 0, then the output of this program
//          might not be accurate (i.e. one of the start values that
//          resulted in overflow might have a larger total stopping time).
int main (int argc, char** argv) {

    // get M and N from the command line
    if (argc < 3) {
        printf ("Command usage : %s %s %s\n",argv[0],"M","N");
        return 1;
    }
    uint64 M = atol(argv[1]);
    uint64 N = atol(argv[2]);

    // start the timer
    clock_t start = clock();

    // compute the start value between M and N (inclusive) 
    // with the largest total stopping time
    uint64 max_start;
    uint32 max_total = 0;
    int num_overflow = 0;
    for (uint64 start = M; start <= N; start++) {
	bool overflow = false;
	uint32 total = total_stopping_time(start,&overflow);
	if (overflow == false) {
	    if (total > max_total) {
		max_total = total;
		max_start = start;
	    }
	} else {
	    num_overflow += 1;
	}
    }

    // stop the timer
    clock_t stop = clock();
    double elapsed = (double)(stop-start)/CLOCKS_PER_SEC;

    // output the results
    printf ("A starting value between %llu and %llu (inclusive)\n",M,N);
    printf ("  having the largest total stopping time is %llu\n",max_start);
    printf ("  which has %u steps\n",max_total);
    printf ("Number of start values that result in overflow = %d\n",num_overflow);
    printf ("elapsed time = %.2f seconds\n",elapsed);

    return 0;
}

