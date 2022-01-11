#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define NUM (200000)

char buf[NUM];

void test_work(void *test_data)
{
    int infd = open("io_file/input", O_RDONLY);
    int outfd = open("io_file/output", O_WRONLY);
    read(infd, buf, NUM);
    write(outfd, buf, NUM);
    close(infd);
    close(outfd);
}
