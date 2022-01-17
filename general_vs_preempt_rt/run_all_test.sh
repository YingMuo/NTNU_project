if [ "$1" = "" ]
then
	echo "./run_all_test <dir>"
	exit
fi

main_dir=$1
./run_test_idle.sh ${main_dir}_dile
./run_test_idle_aff.sh ${main_dir}_dile_aff
./run_test_latency.sh ${main_dir}_latency
