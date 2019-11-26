from sys import *
first = True
for line in open(argv[1]):
    if first:
        first = False
        print line.strip()
        continue
    if line[:9] == "average.X":
        print line[9:].strip()
    elif line[:8] == "average.":
        print line[8:].strip()

