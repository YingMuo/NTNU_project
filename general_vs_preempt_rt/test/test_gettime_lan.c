#include <time.h>
#include <stdio.h>

 #define NSEC_PER_SEC (1000000000)

int main(void)
{
    struct timespec ts;
    struct timespec te;
    long diff = 0;
    for (int i = 0; i < 10000; ++i)
    {
        clock_gettime(CLOCK_MONOTONIC, &ts);
        clock_gettime(CLOCK_MONOTONIC, &te);
        diff = (te.tv_sec - ts.tv_sec) * NSEC_PER_SEC + (te.tv_nsec - ts.tv_nsec);
        printf("%ld\n", diff);
    }

    return 0;
}
