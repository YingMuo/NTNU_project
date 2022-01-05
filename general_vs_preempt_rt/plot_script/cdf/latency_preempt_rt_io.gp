reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency preempt_rt io'
set term png enhanced font 'Verdana,10'
set output 'latency_preempt_rt_io.png'

plot \
'../../preempt_rt/io-bound/49/latency_cdf.txt' using 1:2 with lines title 'io-bound 49', \
'../../preempt_rt/io-bound/79/latency_cdf.txt' using 1:2 with lines title 'io-bound 79', \
'../../preempt_rt/io-bound/80/latency_cdf.txt' using 1:2 with lines title 'io-bound 80', \
'../../preempt_rt/io-bound/81/latency_cdf.txt' using 1:2 with lines title 'io-bound 81'