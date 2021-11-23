reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'latency_cpu bound'
set term png enhanced font 'Verdana,10'
set output 'latency_cpu.png'
set xtic 100000

plot \
'latency_cpu.txt' using 1:2 with points title 'latency_cpu'
