from module import BST

sweTree = BST()
dumbTree = BST()

sweAlpha = list("abcdefghijklmnopqrstuvwxyzåäö")


with open("texts/word3.txt","r") as wordLines: #Loads words into a Binary Search Tree.
	for word in wordLines:
		word = word.rstrip("\n")
		if not sweTree.exists(word):
			sweTree.put(word)

print("Detta program visar alla 'barn' till ett ord")
startWord = input("Faderord:")
dumbTree.put(startWord)

for n in range(3): 						#Change all the letters to all the possible. One at a time.
	for char in sweAlpha:
		testWord = list(startWord) 		# "str.." -> ["s","t","r",...]
		testWord[n] = char
		testWord = "".join(testWord) 	# ["s","t","r",...] -> "str.."
		if sweTree.exists(testWord):	
			if not dumbTree.exists(testWord):
				print(testWord)
				dumbTree.put(testWord)


