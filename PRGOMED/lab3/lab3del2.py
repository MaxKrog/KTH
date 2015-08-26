

def returnNumbers(lineList): #Takes a string and returns a list with the numbers within the string.
	retList=[]

	for key in lineList:
		if(key.isdigit()):
			retList.append(int(key))

	return retList

def printLineBool(lineList): #Returns True if the line has a character (not blankspace)
	retBool = False

	for n in lineList:
		try:
			kuken = float(n)
		except ValueError: #Blankspace is not a word/character.
			retBool = True

	return retBool

def medianen(numList): #Input a list and get back the median.
	medianList= sorted(numList)
	length = len(numList)
	half = length/2
	index = int(half)
	if length % 2 != 0:
		return medianList[index]
	else:
		leftValue = index - 1
		return (medianList[leftValue] + medianList[index]) / 2		



def medelvarde(numList): #Input a list and get back the medelvärde.
	return sum(lenList)/len(numList)


def processFile(file): #Delegates the file read to the different functions that should process it.
	allNumbers= []

	index = 1 
	for line in file:
		lineList = (line.rstrip('\n')).split() #Turn into list and get rid of newline-char.

		if( printLineBool(lineList) ): #Should the line be printed?
			print("rad " + str(index) + ": " + line)
		index +=1

		allNumbers.extend(returnNumbers(lineList)) #extend with the list of numbers returned.

	medelVarde = medelvarde(allNumbers)
	medianValue = medianen(allNumbers)

	print("")
	print("Medelvärdet är " + str(medelVarde))
	print("Medianen är " + str(medianValue))
	print("Största talet är " + str(max(allNumbers)))
	print("Minsta talet är " + str(min(allNumbers)))

def getFile(triedBefore=False): #Takes a string and tries to read it from disc. Then delegates to processFile to process the file.
	if(not triedBefore):
		fileName = input("Vad heter filen?")
	else:
		fileName = input("Ange ett annat filnamn:")
	try:
		file = open(fileName,"r") #öppnar filen med endast läsbehörighet
		processFile(file)
		file.close()


	except IOError:
		print(fileName + " finns ju inte.")
		getFile(True)	



#getFile()