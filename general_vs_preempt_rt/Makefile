OBJS=run.o super_run.o run_latency.o cpu-bound.o IO-bound.o
EXEC=test_cpu test_io test_latency stress_cpu
CC=gcc
FLAGS=
test_cpu: run.o cpu-bound.o
	$(CC) $^ -o $@
test_io: run.o IO-bound.o
	$(CC) $^ -o $@
test_lantency: run_latency.o
	$(CC) $^ -o $@
stress_cpu: super_run.o cpu-bound.o
	$(CC) $^ -o $@
stress_io: super_run.o IO-bound.o
	$(CC) $^ -o $@
$(OBJS):

.PHONY: clean
clean:
	rm *.o test_* stress_*
