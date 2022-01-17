#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define NUM (30000)

char buf[NUM * 10];

void test_work(void *test_data)
{
    int n = *(int *)(*(size_t *)test_data) * NUM;
    int infd = open("/dev/urandom", O_RDONLY);
    int outfd = open((char *)(*(size_t *)test_data + 1), O_WRONLY);
    read(infd, buf, n);
    write(outfd, buf, n);
    close(infd);
    close(outfd);
}
