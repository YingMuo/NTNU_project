reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency io-bound'
set term png enhanced font 'Verdana,10'
set output 'latency_io.png'

plot \
'../../general/io-bound/latency_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/io-bound/latency_cdf.txt' using 1:2 with lines title 'preemp\_rt'
