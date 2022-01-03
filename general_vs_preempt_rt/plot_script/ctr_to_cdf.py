import sys

with open(sys.argv[1], 'r') as f:
    text = f.readlines()

# print(text)
counter = dict()
for s in text:
    sl = s.split(' ')
    counter[int(sl[0])] = int(sl[1])

l = [(k, v) for k, v in counter.items()]
l.sort(key=lambda k: int(k[0]))

for i in range(0, len(l)):
    l[i] = list(l[i])

for i in range(1, len(l)):
    l[i][1] += l[i-1][1]

with open(sys.argv[2], 'w') as f:
    for sl in l:
        f.write(str(sl[0]) + ' ' + str(sl[1]) + '\n')