from Bintree import Bintree

sweTree = Bintree()
engTree = Bintree()

#Read the swedish words
sweFile = open("word3.txt","r")
sweLines = sweFile.readlines()

#Insert them into a BST
for line in sweLines:
	line = line.rstrip("\n")
	if sweTree.exists(line):
		print(line)
	else:
		sweTree.put(line)

#Read english words
engFile = open("engelska.txt","r")
engLines = engFile.readlines()

for line in engLines:
	line = line.rstrip("\n")
	line = line.split(" ")
	for word in line:
		if word == "": 					#That's not much of a word is it?
			pass
		else:
			if engTree.exists(word): 	#It's allready been inserted
				pass
			else:
				engTree.put(word) 			#Insert the word into the english BST
				if sweTree.exists(word): 	#If it exists in the swedish BST - print it!
					print(word)
	


