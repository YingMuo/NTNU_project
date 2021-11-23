reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency io-bound'
set term png enhanced font 'Verdana,10'
set output 'io-bound_log.png'

set log y

plot \
'../../general/mine/io-bound/latency_ctr.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/mine/io-bound/latency_ctr.txt' using 1:2 with lines title 'preemp\_rt'
