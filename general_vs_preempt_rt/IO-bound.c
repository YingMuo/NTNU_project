#include <stdlib.h>
#include <stdio.h>

void test_work(void *test_data)
{
    for (int i = 0; i < 40; ++i)
    {
        FILE *fin = fopen("input", "r");
        FILE *fout = fopen("output", "w");
        char buf[1000000] = {0};
        fscanf(fin, "%s", buf);
        fprintf(fout, "%s", buf);
        fclose(fin);
        fclose(fout);
    }
}