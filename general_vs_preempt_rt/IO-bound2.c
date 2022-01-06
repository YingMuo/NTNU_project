#include <stdlib.h>
#include <stdio.h>

void test_work(void *test_data)
{
    FILE *fin = fopen("input2", "r");
    FILE *fout = fopen("output2", "w");
    char buf[100005] = {0};
    fscanf(fin, "%s", buf);
    fprintf(fout, "%s", buf);
    fclose(fin);
    fclose(fout);
}
