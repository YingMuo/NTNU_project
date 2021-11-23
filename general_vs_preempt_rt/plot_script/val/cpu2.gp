reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'cpu2 bound'
set term png enhanced font 'Verdana,10'
set output 'cpu2.png'
set xtic 1000

plot \
'cpu2.txt' using 1:2 with points title 'cpu2'