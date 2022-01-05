reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response preempt_rt'
set term png enhanced font 'Verdana,10'
set output 'response_preempt_rt.png'

plot \
'../../preempt_rt/clean/io_ctr.txt' using 1:2 with lines title 'io', \
'../../preempt_rt/clean/cpu_ctr.txt' using 1:2 with lines title 'cpu'
