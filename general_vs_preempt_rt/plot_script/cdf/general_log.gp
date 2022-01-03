reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency general'
set term png enhanced font 'Verdana,10'
set output 'general_log.png'

set log x

plot \
'../../general/clean/latency_cdf.txt' using 1:2 with lines title 'clean', \
'../../general/cpu-bound/latency_cdf.txt' using 1:2 with lines title 'cpu-bound', \
'../../general/io-bound/latency_cdf.txt' using 1:2 with lines title 'io-bound'