reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response io'
set term png enhanced font 'Verdana,10'
set output 'res_io.png'
set log x

plot \
'../../general/clean/io_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/clean/io_cdf.txt' using 1:2 with lines title 'preemp\_rt'
