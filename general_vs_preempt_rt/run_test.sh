#!/bin/sh

if [ "$1" = "preempt_rt" ]
then
    main_dir="preempt_rt"
else
    main_dir="general"
fi

echo ${main_dir}

rm -r ${main_dir}
mkdir ${main_dir}
mkdir ${main_dir}/clean
mkdir -p ${main_dir}/io-bound/49
mkdir -p ${main_dir}/io-bound/79
mkdir -p ${main_dir}/io-bound/80
mkdir -p ${main_dir}/io-bound/81
mkdir -p ${main_dir}/cpu-bound/49
mkdir -p ${main_dir}/cpu-bound/79
mkdir -p ${main_dir}/cpu-bound/80
mkdir -p ${main_dir}/cpu-bound/81

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

echo "=====test latency with io stress 49====="
sudo ./stress_io 49&
sudo ./test_latency > ${main_dir}/io-bound/49/latency.txt
cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with io stress 79====="
sudo ./stress_io 79&
sudo ./test_latency > ${main_dir}/io-bound/79/latency.txt
cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with io stress 80====="
sudo ./stress_io 80 &
sudo ./test_latency > ${main_dir}/io-bound/80/latency.txt
cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with io stress 81====="
sudo ./stress_io 81&
sudo ./test_latency > ${main_dir}/io-bound/81/latency.txt
cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_io | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with cpu stress 49====="
sudo ./stress_cpu 49&
sudo ./test_latency > ${main_dir}/cpu-bound/49/latency.txt
cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with cpu stress 79====="
sudo ./stress_cpu 79&
sudo ./test_latency > ${main_dir}/cpu-bound/79/latency.txt
cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with cpu stress 80====="
sudo ./stress_cpu 80&
sudo ./test_latency > ${main_dir}/cpu-bound/80/latency.txt
cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

echo "=====test latency with cpu stress 81====="
sudo ./stress_cpu 81&
sudo ./test_latency > ${main_dir}/cpu-bound/81/latency.txt
cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
while [ ${cnt} -gt 1 ]
do
        sleep 10s
        cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
done

python3 plot_script/val_to_ctr.py ${main_dir}/clean/latency.txt ${main_dir}/clean/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/clean/io.txt ${main_dir}/clean/io_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/clean/cpu.txt ${main_dir}/clean/cpu_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/49/latency.txt ${main_dir}/io-bound/49/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/79/latency.txt ${main_dir}/io-bound/79/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/80/latency.txt ${main_dir}/io-bound/80/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/io-bound/81/latency.txt ${main_dir}/io-bound/81/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/49/latency.txt ${main_dir}/cpu-bound/49/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/79/latency.txt ${main_dir}/cpu-bound/79/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/80/latency.txt ${main_dir}/cpu-bound/80/latency_ctr.txt
python3 plot_script/val_to_ctr.py ${main_dir}/cpu-bound/81/latency.txt ${main_dir}/cpu-bound/81/latency_ctr.txt

python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/latency_ctr.txt ${main_dir}/clean/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/io_ctr.txt ${main_dir}/clean/io_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/cpu_ctr.txt ${main_dir}/clean/cpu_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/49/latency_ctr.txt ${main_dir}/io-bound/49/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/79/latency_ctr.txt ${main_dir}/io-bound/79/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/80/latency_ctr.txt ${main_dir}/io-bound/80/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/io-bound/81/latency_ctr.txt ${main_dir}/io-bound/81/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/49/latency_ctr.txt ${main_dir}/cpu-bound/49/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/79/latency_ctr.txt ${main_dir}/cpu-bound/79/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/80/latency_ctr.txt ${main_dir}/cpu-bound/80/latency_cdf.txt
python3 plot_script/ctr_to_cdf.py ${main_dir}/cpu-bound/81/latency_ctr.txt ${main_dir}/cpu-bound/81/latency_cdf.txt

make clean
