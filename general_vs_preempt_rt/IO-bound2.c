#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>

#define NUM (200000)

char buf[NUM];

void test_work(char **name)
{
    int infd = open(name[0], O_RDONLY);
    int outfd = open(name[1], O_WRONLY);
    read(infd, buf, NUM);
    write(outfd, buf, NUM);
    close(infd);
    close(outfd);
}
