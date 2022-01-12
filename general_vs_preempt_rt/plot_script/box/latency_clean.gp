reset
set ylabel 'latency (us)'
set xtics ('general' 1, 'preempt\_rt' 2,)
set title 'latency clean'
set term png enhanced font 'Verdana,10'
set output 'latency_clean.png'

set style fill solid 0.25 border -1
set style boxplot outliers pointtype 2
set style data boxplot

plot \
'../../general/clean/latency.txt' using (1):2 title 'general', \
'../../preempt_rt/clean/latency.txt' using (2):2 title 'preemp\_rt'