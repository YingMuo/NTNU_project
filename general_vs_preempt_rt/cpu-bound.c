void test_work(void *test_data)
{
    for (int i = 0; i < 2100 * *(int *)test_data; ++i)
    {
        int m1[3][3] = {{1, 8, 13}, {87, 54, 62}, {777, 555, 2333}};
        int m2[3][3] = {{5566, 104, 1111}, {5252, 108, 42}, {59, 18, 2}};
        int sum[3][3] = {{0, 0, 0}, {0, 0, 0}, {0, 0, 0}};
        for (int o = 0; o < 3; ++o)
        {
            for (int p = 0; p < 3; ++p)
            {
                for (int j = 0; j < 3; ++j)
                {
                    sum[o][p] = m1[o][j] * m2[j][p];
                }
            }
        }
    }
}
