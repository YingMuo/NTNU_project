import sys

# print ('Number of arguments:', len(sys.argv), 'arguments.')
# print ('Argument List:', str(sys.argv))

counter = dict()

with open(sys.argv[1], 'r') as input_file:
    while input_file.readable():
        text = input_file.readline().split()
        try:
            if text[0] == '#':
                break
        except:
            break
        try:
            counter[text[1]] += 1
        except:
            counter[text[1]] = 1
l = [(k, v) for k, v in counter.items()]
l.sort(key=lambda k: int(k[0]))
# for (k, v) in l:
#     print(k + ' ' + str(v))
with open(sys.argv[2], 'w') as output_file:
    for (k, v) in l:
        output_file.write(k + ' ' + str(v) + '\n')