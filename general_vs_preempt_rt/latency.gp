reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'latency bound'
set term png enhanced font 'Verdana,10'
set output 'latency.png'
set xtic 1000

plot \
'latency.txt' using 1:2 with points title 'latency'
