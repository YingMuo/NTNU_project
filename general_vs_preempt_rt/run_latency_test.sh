#!/bin/sh
echo $1
if [ "$1" = "preempt_rt" ]
then
    main_dir="preempt_rt"
else
    main_dir="general"
fi

mkdir ${main_dir}
mkdir ${main_dir}/clean
mkdir ${main_dir}/io-bound
mkdir ${main_dir}/cpu-bound

make

sudo ./test_latency > ${main_dir}/clean/latency.txt
sleep 1m

sudo ./stress_io&
sudo ./test_latency > ${main_dir}/io-bound/latency.txt
sleep 1m

sudo ./stress_cpu&
sudo ./test_latency > ${main_dir}/cpu-bound/latency.txt
sleep 1m

python3 plot_script/val_to_ctr.py ${main_dir}/clean/latency.txt ${main_dir}/clean/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/latency.txt ${main_dir}/io-bound/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/latency.txt ${main_dir}/cpu-bound/latency_ctr.txt

python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/latency_ctr.txt ${main_dir}/clean/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/latency_ctr.txt ${main_dir}/io-bound/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/latency_ctr.txt ${main_dir}/cpu-bound/latency_cdf.txt

make clean