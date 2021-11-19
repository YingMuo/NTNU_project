reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'cpu bound'
set term png enhanced font 'Verdana,10'
set output 'cpu.png'
set xtic 1000

plot \
'cpu.txt' using 1:2 with points title 'cpu'
