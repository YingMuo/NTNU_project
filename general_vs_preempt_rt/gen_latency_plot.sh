#!/bin/sh
mkdir plot
cd plot
gnuplot plot_script/ctr/*.gp
gnuplot plot_script/cdf/*.gp
