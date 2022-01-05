#!/bin/sh
mkdir plot
cd plot
# mkdir ctr
# cd ctr
# gnuplot ../../plot_script/ctr/*.gp
# cd ..
mkdir cdf
cd cdf
gnuplot ../../plot_script/cdf/*.gp
