OBJS=run.o run_lantency.o cpu-bound.o IO-bound.o
EXEC=test_cpu test_io test_lantency
CC=gcc
FLAGS=
test_cpu: run.o cpu-bound.o
	$(CC) $^ -o $@
test_io: run.o IO-bound.o
	$(CC) $^ -o $@
test_lantency: run_lantency.o
	$(CC) $^ -o $@
$(OBJS):

.PHONY: clean
clean:
	rm *.o test_*