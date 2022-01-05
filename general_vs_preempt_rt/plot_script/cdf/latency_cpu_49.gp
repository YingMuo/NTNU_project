reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency cpu-bound 49'
set term png enhanced font 'Verdana,10'
set output 'latency_cpu_49.png'

plot \
'../../general/cpu-bound/49/latency_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/cpu-bound/49/latency_cdf.txt' using 1:2 with lines title 'preemp\_rt'
