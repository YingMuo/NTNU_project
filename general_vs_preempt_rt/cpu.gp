reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'cpu bound'
set term png enhanced font 'Verdana,10'
set output 'cpu.png'
set xtic 1, 1, 10

plot \
'cpu.txt' using 1:2 with linespoints linewidth 2 title 'cpu'