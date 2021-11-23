reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency preempt_rt'
set term png enhanced font 'Verdana,10'
set output 'preempt_rt_log.png'

set log y

plot \
'../../preempt_rt/mine/clean/latency_ctr.txt' using 1:2 with lines title 'clean', \
'../../preempt_rt/mine/cpu-bound/latency_ctr.txt' using 1:2 with lines title 'cpu-bound', \
'../../preempt_rt/mine/io-bound/latency_ctr.txt' using 1:2 with lines title 'io-bound'
