void test_work(void *test_data)
{
    for (int i = 0; i < 40000; ++i)
    {
        int m1[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
        int m2[3][3] = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
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
