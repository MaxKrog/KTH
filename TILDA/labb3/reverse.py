from Bintree import Bintree

wordTree = Bintree()
reversedTree = Bintree() #BST for printed reversed words.

f = open("word3.txt","r")
lines = f.readlines()


for line in lines:
	line = line.rstrip("\n")
	if not wordTree.exists(line):
		wordTree.put(line)
print("This app find words that are the same when reversed!")
input("Press enter to continue:")

for line in lines:
	line = line.rstrip("\n")
	reversedLine = line[::-1] 				#Reverses the string
	if not line == reversedLine: 			#Gets rid of symmetric words
		if not reversedTree.exists(line): 	#Storage of allready shown reversed words. Do this before other search since it's quicker.
			if wordTree.exists(reversedLine): 
				print(line)
				print(line[::-1])
				print()
				reversedTree.put(line)
