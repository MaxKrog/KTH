from Bintree import Bintree
import random
import time

tree = Bintree()

print("This program compares search-time between linear search and BST-search")
totalEntries = int(input("Please enter how many total entries there should be : "))

numberArray = [x for x in range(totalEntries)] 
random.shuffle(numberArray) 				#Randomizes the array.

for number in numberArray: 				#Puts all the numbers into the binary-tree
	tree.put(number)

numberToFind = int(random.random() * totalEntries // 1) #Make up a random number in the right interval.

print("\nLooking for number " + str(numberToFind)+" in shuffled intervall 0 - " + str(totalEntries) + "\n")

startTime = time.clock()
tree.exists(numberToFind) #BST-SEARCH PROCESS
treeStop = time.clock() #Time until BinarySearch was completed.

linStop = None #Allocate memory

for number in numberArray: #LINEAR-SEARCH PROCESS
	if number == numberToFind:
		linStop = time.clock() #If this goes through the number is found. Stop time.
		break

#Actual time consumed calculated below
treeTime = treeStop - startTime
linTime = linStop - treeStop

ratio = linTime/treeTime

print("BST-search found it after " + str(treeStop - startTime) + " seconds")
print("Linear-search found it after " + str(linStop - treeStop) +" seconds\n")
print("The binary search was " + str(ratio) + " times quicker")