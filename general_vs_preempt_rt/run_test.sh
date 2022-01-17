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
	for idle in 20 40 60 80
	do
	        for i in 49 79 80 81
        	do
                	mkdir -p ${main_dir}/${stress}-bound/${idle}/${i}
	        done
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
		for idle in 20 40 60 80
		do
                	for i in 49 79 80 81
	                do
        	                echo "=====test ${test} with ${stress} stress idle ${idle} & prio ${i}====="
				if [ ${test} = "latency" ]
				then
					num=$((${idle}/10))
				else
					num=$((${idle}/10-1))
				fi
                	        sudo ./stress_${stress} ${i} ${num} $ &
                        	sudo ./test_${test} > ${main_dir}/${stress}-bound/${idle}/${i}/${test}.txt
                for i in $(ps aux | grep stress_${stress} | awk '{print $2}')
                do
                    sudo kill -9 ${i}
                done
                sleep 10s
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
		for idle in 20 40 60 80
		do
                	for i in 49 79 80 81
	                do
        	                python3 plot_script/val_to_ctr.py ${main_dir}/${stress}-bound/${idle}/${i}/${test}.txt ${main_dir}/${stress}-bound/${idle}/${i}/${test}_ctr.txt
                	        python3 plot_script/ctr_to_cdf.py ${main_dir}/${stress}-bound/${idle}/${i}/${test}_ctr.txt ${main_dir}/${stress}-bound/${idle}/${i}/${test}_cdf.txt
	                done
		done
        done
done

make clean
