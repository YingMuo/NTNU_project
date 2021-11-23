reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency clean'
set term png enhanced font 'Verdana,10'
set output 'clean.png'

plot \
'../../general/clean/latency_ctr.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/clean/latency_ctr.txt' using 1:2 with lines title 'preemp\_rt'
