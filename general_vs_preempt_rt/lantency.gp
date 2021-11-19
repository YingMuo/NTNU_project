reset                                                                           
set xlabel 'task counter'
set ylabel 'time(ns)'
set title 'lantency bound'
set term png enhanced font 'Verdana,10'
set output 'lantency.png'
set xtic 1000

plot \
'lantency.txt' using 1:2 with points title 'lantency'