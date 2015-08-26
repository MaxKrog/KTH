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
dumbTree = BST()

queue = LinkedQueue()

sweAlpha = list("abcdefghijklmnopqrstuvwxyzåäö")

with open("texts/word3.txt","r") as wordLines:
	for word in wordLines:
		word = word.rstrip("\n")
		if not sweTree.exists(word):
			sweTree.put(word)

print("Detta program kommer att hitta vilka ord som ligger längst ifrån ditt startord.")
startWord = input("Startord:")

startNode = ParentNode(startWord)

dumbTree.put(startNode.value)
queue.put(startNode)

maxDistance = 0
words = []

while not queue.isEmpty():
	node = queue.get()

	distance = countChain(node)

	if distance > maxDistance:  	#Is this node further away then last node?
		maxDistance = countChain(node)
		words = [node.value]
	elif distance == maxDistance: 	#Is this node on same distance as last node?	
		words.append(node.value)

	makeChildren(node)

for word in words:
	print(word + (" " if word == words[-1] else ", "), end="" ) #Printar ord + "," för alla utom sista ordet
print("ligger på avståndet " + str(maxDistance) + " från startordet.")

