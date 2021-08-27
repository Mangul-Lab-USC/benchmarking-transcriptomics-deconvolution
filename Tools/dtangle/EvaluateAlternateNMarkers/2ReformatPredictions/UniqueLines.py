myD = {}
for line in open("temp.tsv","r"):
    if line not in myD:
        myD[line] = 0
        print line.strip()
