#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <sched.h>
#include <sys/mman.h>
#include <string.h>
#include <unistd.h>

#define MY_PRIORITY (80)
#define MAX_SAFE_STACK (8*1024)
#define NSEC_PER_SEC (1000000000)
#define LOOP_TIME (10000)
#define INTERVAL (1000000)

void test_work(void *test_data);

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
    int interval = INTERVAL; // 0.1s
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

    fork();
    fork();

    t.tv_sec++;
    for (int i = 0; i < LOOP_TIME; ++i)
    {
        clock_nanosleep(CLOCK_MONOTONIC, TIMER_ABSTIME, &t, NULL);
        test_work(NULL);
        t.tv_nsec += interval;
        while (t.tv_nsec >= NSEC_PER_SEC)
        {
            t.tv_nsec -= NSEC_PER_SEC;
            t.tv_sec++;
        }
    }

    return 0;
}
