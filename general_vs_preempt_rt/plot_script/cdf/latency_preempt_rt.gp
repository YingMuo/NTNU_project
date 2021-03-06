reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency preempt_rt'
set term png enhanced font 'Verdana,10'
set output 'latency_preempt_rt.png'

plot \
'../../preempt_rt/clean/latency_cdf.txt' using 1:2 with lines title 'clean', \
'../../preempt_rt/cpu-bound/49/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 49', \
'../../preempt_rt/cpu-bound/79/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 79', \
'../../preempt_rt/cpu-bound/80/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 80', \
'../../preempt_rt/cpu-bound/81/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 81', \
'../../preempt_rt/io-bound/49/latency_cdf.txt' using 1:2 with lines title 'io-bound 49', \
'../../preempt_rt/io-bound/79/latency_cdf.txt' using 1:2 with lines title 'io-bound 79', \
'../../preempt_rt/io-bound/80/latency_cdf.txt' using 1:2 with lines title 'io-bound 80', \
'../../preempt_rt/io-bound/81/latency_cdf.txt' using 1:2 with lines title 'io-bound 81'