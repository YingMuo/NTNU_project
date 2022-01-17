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
for idle in 20 40 60 80
do
        mkdir -p ${main_dir}/${idle}
done

make
sleep 1s

for test in io cpu
do
		for idle in 20 40 60 80
		do
        	    echo "=====test ${test} with not idle ${idle}====="
				num=$((${idle}/10))
                sudo ./test_${test} ${num} > ${main_dir}/${idle}/${test}.txt
        done
done

for test in io cpu
do
		for idle in 20 40 60 80
		do
                python3 plot_script/val_to_ctr.py ${main_dir}/${idle}/${test}.txt ${main_dir}/${idle}/${test}_ctr.txt
       	        python3 plot_script/ctr_to_cdf.py ${main_dir}/${idle}/${test}_ctr.txt ${main_dir}/${idle}/${test}_cdf.txt
        done
done

make clean
