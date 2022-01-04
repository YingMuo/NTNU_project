#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sched.h>
#include <sys/mman.h>
#include <string.h>

#define MY_PRIORITY (80)
#define MAX_SAFE_STACK (8*1024)
#define NSEC_PER_SEC (1000000000)
#define LOOP_TIME (100000)
#define INTERVAL (1000000)

int ctr_err = 0;

void test_work(void *test_data);

void get_work_time(void (*test_work)(void *), void *test_data, struct timespec *ts, int *ctr, struct timespec *sum, long *min, long *max)
{
    struct timespec te;
    struct timespec diff;
    test_work(test_data);
    clock_gettime(CLOCK_MONOTONIC, &te);
    diff.tv_sec = te.tv_sec - ts->tv_sec;
    diff.tv_nsec = te.tv_nsec - ts->tv_nsec;
    sum->tv_sec += diff.tv_sec;
    sum->tv_nsec += diff.tv_nsec;
    ++*ctr;
    if (sum->tv_nsec >= NSEC_PER_SEC)
    {
        sum->tv_nsec -= NSEC_PER_SEC;
	    sum->tv_sec += 1;
    }
    else if (sum->tv_nsec < 0)
    {
        sum->tv_nsec += NSEC_PER_SEC;
	    sum->tv_sec -= 1;
    }

    long nsec = diff.tv_sec * NSEC_PER_SEC + diff.tv_nsec;
    if (nsec >= INTERVAL)
    {
        --*ctr;
        ++ctr_err;
        return;
    }

    if (*min > nsec)
        *min = nsec;
    if (*max < nsec)
        *max = nsec;
    printf("%d %ld\n", *ctr, nsec);
}

void stack_prefault(void)
{
    unsigned char dummy[MAX_SAFE_STACK];
    memset(dummy, 0, MAX_SAFE_STACK);
    return;
}

int main(int argc, char *argv[])
{
    struct timespec t;
    struct timespec sum = {0, 0};
    long avg = 0;
    long min = __LONG_MAX__;
    long max = 0x8000000000000000;
    int ctr = 0;
    struct sched_param param;
    int interval = INTERVAL;
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
    // for (int i = 0; i < LOOP_TIME; ++i)
    while(ctr < LOOP_TIME)
    {
        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);
        get_work_time(test_work, NULL, &t, &ctr, &sum, &min, &max);
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
    printf("# err cnt: %d\n", ctr_err);

    return 0;
}
