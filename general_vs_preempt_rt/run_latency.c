#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sched.h>
#include <sys/mman.h>
#include <string.h>

#define MY_PRIORITY (49)
#define MAX_SAFE_STACK (8*1024)
#define NSEC_PER_SEC (1000000000)

void stack_prefault(void)
{
    unsigned char dummy[MAX_SAFE_STACK];
    memset(dummy, 0, MAX_SAFE_STACK);
    return;
}

int main(int argc, char *argv[])
{
    struct timespec t;
    struct timespec t2;
    struct timespec diff;
    struct timespec sum = {0, 0};
    long avg = 0;
    long min = __LONG_MAX__;
    long max = 0x8000000000000000;
    int ctr = 0;
    struct sched_param param;
    int interval = 1000000; // 1 ms
    param.sched_priority = MY_PRIORITY;

    if (sched_setscheduler(0, SCHED_FIFO, &param) == -1)
    {
        perror("sched_setscheduler failed");
    }

    if (mlockall(MCL_CURRENT|MCL_FUTURE) == -1)
    {
        perror("mlockall failed");
    }

    stack_prefault();
    clock_gettime(CLOCK_MONOTONIC, &t);

    t.tv_sec++;
    // while (1)
    for (int i = 0; i < 100000; ++i)
    {
        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);
        clock_gettime(CLOCK_MONOTONIC, &t2);
        diff.tv_sec = t2.tv_sec - t.tv_sec;
        diff.tv_nsec = t2.tv_nsec - t.tv_nsec;
        sum.tv_sec += diff.tv_sec;
        sum.tv_nsec += diff.tv_nsec;
        ++ctr;
        if (sum.tv_nsec >= NSEC_PER_SEC)
        {
            sum.tv_nsec -= NSEC_PER_SEC;
            sum.tv_sec += 1;
        }
        else if (sum.tv_nsec < 0)
        {
            sum.tv_nsec += NSEC_PER_SEC;
            sum.tv_sec -= 1;
        }

        long nsec = diff.tv_sec * NSEC_PER_SEC + diff.tv_nsec;
        if (min > nsec)
            min = nsec;
        if (max < nsec)
            max = nsec;
        printf("%d %ld\n", ctr, nsec);

        t.tv_nsec += interval;
        while (t.tv_nsec >= NSEC_PER_SEC)
        {
            t.tv_nsec -= NSEC_PER_SEC;
            t.tv_sec++;
        }
    }

    avg = (sum.tv_sec * NSEC_PER_SEC + sum.tv_nsec) / ctr;
    printf("# sum: %ld\n", avg);
    printf("# min: %ld\n", min);
    printf("# max: %ld\n", max);

    return 0;
}
