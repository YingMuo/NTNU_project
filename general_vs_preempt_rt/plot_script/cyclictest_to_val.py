import sys

with open(sys.argv[1], 'r') as input_file:
    with open(sys.argv[2], 'w') as output_file:
        for i in range(6):
            input_file.readline()
        idx = 1
        while True:
            try:
                text = input_file.readline().split()
                input_file.readline()
                input_file.readline()
                output_file.write(str(idx) + ' ' + text[11] + '\n')
                idx += 1
            except:
                break