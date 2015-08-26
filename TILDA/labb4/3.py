from module import BST
from module import LinkedQueue
from module import ParentNode
import sys

def writeChain(node, stepNumber=1): #Recursively writes all the connections from node and upwards.
	if node.parent:
		writeChain(node.parent, stepNumber+1)
	print(str(stepNumber) + ": " + node.value)

def makeChildren(node):
	for n in range(3):
		for char in sweAlpha:
			testWord = list(node.value)
			testWord[n] = char
			testWord = "".join(testWord)

			if testWord == endWord:
				print("En väg hittad mellan " + startWord + " och " + testWord)
				writeChain(ParentNode(testWord,node))
				sys.exit()

			elif sweTree.exists(testWord):
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

print("Detta program kommer hitta den snabbaste vägen mellan två trekaraktärs-ord.")
startWord = input("Startord:")
endWord = input("Slutord:")

startNode = ParentNode(startWord)

dumbTree.put(startNode.value)
queue.put(startNode)

while not queue.isEmpty():
	node = queue.get()
	makeChildren(node)

print("Ingen möjlig väg. Testa igen med nytt slut/startord.")




