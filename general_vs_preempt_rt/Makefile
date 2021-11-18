OBJS=run.o cpu-bound.o IO-bound.o
EXEC=test_cpu test_io
CC=gcc
FLAGS=
test_cpu: run.o cpu-bound.o
	$(CC) $^ -o $@
test_io: run.o IO-bound.o
	$(CC) $^ -o $@

$(OBJS):

.PHONY: clean
clean:
	rm *.o test