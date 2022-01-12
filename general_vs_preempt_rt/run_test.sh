#!/bin/sh

if [ "$1" = "" ]
then
        echo "./run_test <dir>"
        exit
fi

main_dir=$1
echo "=====${main_dir}====="

rm -r ${main_dir}
mkdir ${main_dir}
mkdir ${main_dir}/clean
for stress in io cpu
do
        for i in 49 79 80 81
        do
                mkdir -p ${main_dir}/${stress}-bound/${i}
        done
done

make
sleep 10s

for test in latency io cpu
do
        echo "=====test ${test}====="
        sudo ./test_${test} > ${main_dir}/clean/${test}.txt
        sleep 10s

        for stress in io cpu
        do
                for i in 49 79 80 81
                do
                        echo "=====test ${test} with ${stress} stress ${i}====="
                        sudo ./stress_${stress} ${i} &
                        sudo ./test_${test} > ${main_dir}/${stress}-bound/${i}/${test}.txt &
                        cnt=$(ps aux | grep stress_${stress} | awk '{print $2}' | wc | awk '{print $1}')
                        while [ ${cnt} -gt 1 ]
                        do
                                sleep 10s
                                cnt=$(ps aux | grep stress_${stress} | awk '{print $2}' | wc | awk '{print $1}')
                        done
                done
        done
done

for test in latency io cpu
do
        python3 plot_script/val_to_ctr.py ${main_dir}/clean/${test}.txt ${main_dir}/clean/${test}_ctr.txt
        python3 plot_script/ctr_to_cdf.py ${main_dir}/clean/${test}_ctr.txt ${main_dir}/clean/${test}_cdf.txt
        for stress in io cpu
        do
                for i in 49 79 80 81
                do
                        python3 plot_script/val_to_ctr.py ${main_dir}/${stress}-bound/${i}/${test}.txt ${main_dir}/${stress}-bound/${i}/${test}_ctr.txt
                        python3 plot_script/ctr_to_cdf.py ${main_dir}/${stress}-bound/${i}/${test}_ctr.txt ${main_dir}/${stress}-bound/${i}/${test}_cdf.txt
                done
        done
done

make clean
