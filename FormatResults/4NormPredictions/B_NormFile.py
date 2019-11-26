from sys import *
inMat = []
for line in open(argv[1],"r"):
  inMat.append(line.strip().split("\t"))

print "\t".join(inMat[0])
for parts in inMat[1:]:
  smallest = min([float(m) for m in parts[1:]])

  """
  If an entry is negative, subtract that value from all other entries
  that entry becomes 0, all others remain positive
  """
  if smallest < 0.0:
    posList = [parts[0]]
    for part in parts[1:]:
      posList.append(float(part)-smallest)
  else:
    posList = parts[:]

  normedList = [parts[0]]
  total = sum([float(m) for m in posList[1:]])
  if total == 0: #spread evenly among all fields
      equal = 1/float(len(parts[1:]))
      for el in parts[1:]:
        normedList.append(str(equal))
  else:
    for el in posList[1:]:
      normedList.append(str(float(el)/total))

  print "\t".join(normedList)
