reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency cpu-bound 79'
set term png enhanced font 'Verdana,10'
set output 'latency_cpu_79.png'

plot \
'../../general/cpu-bound/79/latency_cdf.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/cpu-bound/79/latency_cdf.txt' using 1:2 with lines title 'preemp\_rt'
