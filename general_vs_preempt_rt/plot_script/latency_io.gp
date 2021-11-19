reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'latency_io bound'
set term png enhanced font 'Verdana,10'
set output 'latency_io.png'
set xtic 100000

plot \
'latency_io.txt' using 1:2 with points title 'latency_io'
