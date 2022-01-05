reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency io-bound 49'
set term png enhanced font 'Verdana,10'
set output 'latency_io_49.png'

plot \
'../../general/io-bound/49/latency_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/io-bound/49/latency_cdf.txt' using 1:2 with lines title 'preemp\_rt'
