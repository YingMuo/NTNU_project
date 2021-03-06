reset                                                                           
set xlabel 'latency (us)'
set ylabel 'time'
set title 'latency cpu-bound'
set term png enhanced font 'Verdana,10'
set output 'latency_cpu.png'

plot \
'../../general/cpu-bound/latency_ctr.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/cpu-bound/latency_ctr.txt' using 1:2 with lines title 'preemp\_rt'
