reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency general'
set term png enhanced font 'Verdana,10'
set output 'latency_general.png'

plot \
'../../general/clean/latency_ctr.txt' using 1:2 with lines title 'clean', \
'../../general/cpu-bound/latency_ctr.txt' using 1:2 with lines title 'cpu-bound', \
'../../general/io-bound/latency_ctr.txt' using 1:2 with lines title 'io-bound'
