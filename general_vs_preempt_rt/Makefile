OBJS=run.o run_aff.o super_run.o super_run_aff.o run_latency.o run_latency_aff.o cpu-bound.o IO-bound.o super_run2.o cpu-bound2.o IO-bound2.o
EXEC=test_cpu test_io test_latency stress_cpu
CC=gcc
FLAGS=
all: test_latency test_io test_cpu stress_io stress_cpu test_latency_aff test_io_aff test_cpu_aff stress_io_aff stress_cpu_aff
test_cpu: run.o cpu-bound.o
	$(CC) $^ -o $@
test_io: run.o IO-bound.o
	$(CC) $^ -o $@
test_latency: run_latency.o
	$(CC) $^ -o $@
stress_cpu: super_run.o cpu-bound2.o
	$(CC) $^ -o $@
stress_io: super_run.o IO-bound2.o
	$(CC) $^ -o $@
test_cpu_aff: run_aff.o cpu-bound.o
	$(CC) $^ -o $@
test_io_aff: run_aff.o IO-bound.o
	$(CC) $^ -o $@
test_latency_aff: run_latency_aff.o
	$(CC) $^ -o $@
stress_cpu_aff: super_run_aff.o cpu-bound2.o
	$(CC) $^ -o $@
stress_io_aff: super_run_aff.o IO-bound2.o
	$(CC) $^ -o $@
$(OBJS):

main:
	gcc -c main.c
	gcc main.o IO-bound.o -o main_io
	gcc main.o cpu-bound.o -o main_cpu

.PHONY: clean
clean:
	rm *.o test_* stress_*
