reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency preempt_rt'
set term png enhanced font 'Verdana,10'
set output 'latency_preempt_rt.png'

plot \
'../../preempt_rt/clean/latency_ctr.txt' using 1:2 with lines title 'clean', \
'../../preempt_rt/cpu-bound/latency_ctr.txt' using 1:2 with lines title 'cpu-bound', \
'../../preempt_rt/io-bound/latency_ctr.txt' using 1:2 with lines title 'io-bound'
