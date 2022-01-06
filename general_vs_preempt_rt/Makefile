OBJS=run.o super_run.o run_latency.o cpu-bound.o IO-bound.o super_run2.o
EXEC=test_cpu test_io test_latency stress_cpu
CC=gcc
FLAGS=
all: test_latency test_io test_cpu stress_io stress_cpu
test_cpu: run.o cpu-bound.o
	$(CC) $^ -o $@
test_io: run.o IO-bound.o
	$(CC) $^ -o $@
test_latency: run_latency.o
	$(CC) $^ -o $@
stress_cpu: super_run.o cpu-bound.o
	$(CC) $^ -o $@
stress_io: super_run2.o IO-bound.o
	$(CC) $^ -o $@
$(OBJS):

main:
	gcc -c main.c
	gcc main.o IO-bound.o -o main_io
	gcc main.o cpu-bound.o -o main_cpu

.PHONY: clean
clean:
	rm *.o test_* stress_*
