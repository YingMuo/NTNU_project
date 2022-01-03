reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency'
set term png enhanced font 'Verdana,10'
set output 'latency_cdf.png'

plot \
'latency_cdf.txt' using 1:2 with lines title 'latency'