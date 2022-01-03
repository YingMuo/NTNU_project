#!/bin/sh

cnt=$(ps aux | grep stress_cpu | awk '{print $2}' | wc | awk '{print $1}')
echo ${cnt}

while [ ${cnt} -gt 1 ]
do
	echo $(ps aux | grep stress_cpu | awk '{print $2}' | sed '1!d')
	echo $(ps aux | grep stress_cpu | awk '{print $2}' | sed '2!d')
	echo $(ps aux | grep stress_cpu | awk '{print $2}' | sed '3!d')
	echo $(ps aux | grep stress_cpu | awk '{print $2}' | sed '4!d')
	echo $(ps aux | grep stress_cpu | awk '{print $2}' | sed '5!d')
done
