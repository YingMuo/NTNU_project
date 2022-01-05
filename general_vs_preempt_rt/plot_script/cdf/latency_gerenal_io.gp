reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency general io'
set term png enhanced font 'Verdana,10'
set output 'latency_general_io.png'

plot \
'../../general/io-bound/49/latency_cdf.txt' using 1:2 with lines title 'io-bound 49', \
'../../general/io-bound/79/latency_cdf.txt' using 1:2 with lines title 'io-bound 79', \
'../../general/io-bound/80/latency_cdf.txt' using 1:2 with lines title 'io-bound 80', \
'../../general/io-bound/81/latency_cdf.txt' using 1:2 with lines title 'io-bound 81'
