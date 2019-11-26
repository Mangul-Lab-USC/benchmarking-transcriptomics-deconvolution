from sys import *
AllSigs = []
for line in open(argv[1]):
    parts = line.strip().split("\t")
    AllSigs = AllSigs + parts[1:]

print "\t".join(AllSigs)
