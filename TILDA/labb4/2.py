from module import BST
from module import LinkedQueue
import sys

def makeChildren(word): #Creates all the possible children of a word.
	for n in range(3):
		for char in sweAlpha:
			testWord = list(word)
			testWord[n] = char
			testWord = "".join(testWord)

			if testWord == endWord:
				print("Det finns en väg till " + endWord +".")
				sys.exit()

			elif sweTree.exists(testWord):
				if not dumbTree.exists(testWord):
					dumbTree.put(testWord)
					queue.put(testWord)

sweTree = BST()
dumbTree = BST()
queue = LinkedQueue()
sweAlpha = list("abcdefghijklmnopqrstuvwxyzåäö")


with open("texts/word3.txt","r") as wordLines:
	for word in wordLines:
		word = word.rstrip("\n")
		if not sweTree.exists(word):
			sweTree.put(word)

print("Detta program avgör om det finns en väg från startord till slutord som går via korrekta ord")
startWord = input("Startord:")
endWord = input("Slutord:")

dumbTree.put(startWord)
queue.put(startWord)

while not queue.isEmpty():
	node = queue.get()
	makeChildren(node)

print("Det finns ingen väg mellan de två orden.")




