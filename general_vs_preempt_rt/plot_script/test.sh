#!/bin/sh
echo $1
if [ "$1" = "preempt_rt" ]
then
    echo "preempt_rt"
else
    echo "general"
fi
