from module import BST
from module import LinkedQueue
from module import ParentNode
import sys

def countChain(node,currentLength = 0): #return int with distance from startword.
	if node.parent:
		return countChain(node.parent,currentLength+1)
	return currentLength

def makeChildren(node): 
	for n in range(3):
		for char in sweAlpha:
			testWord = list(node.value)
			testWord[n] = char
			testWord = "".join(testWord)

			if sweTree.exists(testWord):
				if not dumbTree.exists(testWord):
					dumbTree.put(testWord)
					queue.put(ParentNode(testWord,node))

sweTree = BST()

sweAlpha = list("abcdefghijklmnopqrstuvwxyzåäö")

sweWords = open("texts/word3.txt","r")
sweWords = sweWords.readlines()
for word in sweWords:
	word = word.rstrip("\n")
	if not sweTree.exists(word):
		sweTree.put(word)


print("Detta program kommer att hitta vilka ord som ligger längst ifrån ditt startord.")

maxDistance = 0
words = []
queue = LinkedQueue()
dumbTree = BST()

for word in sweWords:
	print(word)
	word = word.rstrip("\n")

	queue = LinkedQueue()
	dumbTree = BST()

	startNode = ParentNode(word)
	dumbTree.put(startNode.value)
	queue.put(startNode)

	while not queue.isEmpty():
		node = queue.get()

		distance = countChain(node)

		if distance > maxDistance:
			maxDistance = distance
			words = [[word,node.value]]

		if distance == maxDistance:
			words.append([word,node.value])



		makeChildren(node)

print(maxDistance)
#print(words)
