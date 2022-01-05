reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency general cpu'
set term png enhanced font 'Verdana,10'
set output 'latency_general_cpu.png'

plot \
'../../general/cpu-bound/49/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 49', \
'../../general/cpu-bound/79/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 79', \
'../../general/cpu-bound/80/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 80', \
'../../general/cpu-bound/81/latency_cdf.txt' using 1:2 with lines title 'cpu-bound 81'