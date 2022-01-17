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
for stress in io cpu
do
    for idle in 20 40 60 80
    do
        for prio in 49 79 80 81
        do
            mkdir -p ${main_dir}/${stress}/${idle}/{$prio}
        done
    done
done

make
sleep 5s

for stress in io cpu
do
	for idle in 20 40 60 80
	do
        for prio in 49 79 80 81
        do
   	        echo "=====test latency with stress ${stress} not idle ${idle} & prio ${prio}====="
            sudo ./test_latency > ${main_dir}/${stress}-bound/${idle}/${prio}/latency.txt
            for i in $(ps aux | grep stress_${stress} | awk '{print $2}')
            do
                sudo kill -9 ${i}
            done
            sleep 5s
        done
    done
done

for stress in io cpu
do
    for idle in 20 40 60 80
	do
        for prio in 49 79 80 81
        do
            python3 plot_script/val_to_ctr.py ${main_dir}/${stress}-bound/${idle}/${prio}/${test}.txt ${main_dir}/${stress}-bound/${idle}/${prio}/${test}_ctr.txt
            python3 plot_script/ctr_to_cdf.py ${main_dir}/${stress}-bound/${idle}/${prio}/${test}_ctr.txt ${main_dir}/${stress}-bound/${idle}/${prio}/${test}_cdf.txt
        done
    done
done

make clean
