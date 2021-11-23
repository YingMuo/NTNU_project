reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'io bound'
set term png enhanced font 'Verdana,10'
set output 'io.png'
set xtic 1000

plot \
'io.txt' using 1:2 with points title 'io'
