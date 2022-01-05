reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response preempt_rt'
set term png enhanced font 'Verdana,10'
set output 'res_preempt_rt.png'

plot \
'../../preempt_rt/clean/io_cdf.txt' using 1:2 with lines title 'io', \
'../../preempt_rt/clean/cpu_cdf.txt' using 1:2 with lines title 'cpu'
