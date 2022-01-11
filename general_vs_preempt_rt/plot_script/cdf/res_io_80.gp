reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response io-bound 80'
set term png enhanced font 'Verdana,10'
set output 'res_io_80.png'

plot \
'../../general/io-bound/80/io_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/io-bound/80/io_cdf.txt' using 1:2 with lines title 'preemp\_rt'
