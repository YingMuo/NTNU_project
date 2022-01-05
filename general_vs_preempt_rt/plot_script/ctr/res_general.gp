reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response general'
set term png enhanced font 'Verdana,10'
set output 'res_general.png'

plot \
'../../general/clean/io_ctr.txt' using 1:2 with lines title 'io', \
'../../general/clean/cpu_ctr.txt' using 1:2 with lines title 'cpu'
