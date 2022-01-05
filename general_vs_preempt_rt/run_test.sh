#!/bin/sh

if [ "$1" = "preempt_rt" ]
then
    main_dir="preempt_rt"
else
    main_dir="general"
fi

rm -r ${main_dir}
mkdir ${main_dir}
mkdir ${main_dir}/clean
mkdir ${main_dir}/io-bound
mkdir ${main_dir}/cpu-bound

make
sleep 10s

echo "=====test latency====="
sudo ./test_latency > ${main_dir}/clean/latency.txt
sleep 10s

echo "=====test io====="
sudo ./test_io > ${main_dir}/clean/io.txt
sleep 10s

echo "=====test cpu====="
sudo ./test_cpu > ${main_dir}/clean/cpu.txt
sleep 10s

echo "=====test latency with io stress====="
sudo ./stress_io&
sudo ./test_latency > ${main_dir}/io-bound/latency.txt
cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with cpu stress====="
sudo ./stress_cpu&
sudo ./test_latency > ${main_dir}/cpu-bound/latency.txt
cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

python3 plot_script/val_to_ctr.py ${main_dir}/clean/latency.txt ${main_dir}/clean/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/clean/io.txt ${main_dir}/clean/io_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/clean/cpu.txt ${main_dir}/clean/cpu_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/latency.txt ${main_dir}/io-bound/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/latency.txt ${main_dir}/cpu-bound/latency_ctr.txt

python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/latency_ctr.txt ${main_dir}/clean/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/io_ctr.txt ${main_dir}/clean/io_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/cpu_ctr.txt ${main_dir}/clean/cpu_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/latency_ctr.txt ${main_dir}/io-bound/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/latency_ctr.txt ${main_dir}/cpu-bound/latency_cdf.txt

make clean
