reset                                                                           
set xlabel 'response (us)'
set ylabel 'time'
set title 'response cpu'
set term png enhanced font 'Verdana,10'
set output 'res_cpu.png'

plot \
'../../general/clean/cpu_ctr.txt' using 1:2 with lines title 'general', \
'../../preempt_rt/clean/cpu_ctr.txt' using 1:2 with lines title 'preemp\_rt'
