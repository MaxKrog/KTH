from Bintree import Bintree

tree = Bintree()

f = open("word3.txt","r")
lines = f.readlines()

for line in lines:
	line = line.rstrip("\n")
	if tree.exists(line):
		print(line)
	else:
		tree.put(line)

#tree.write()
