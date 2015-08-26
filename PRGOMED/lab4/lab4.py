def rollLengthFunc(twoChars): #Tar en sträng "AB" och returnerar längden som alla bokstäver ska "rullas"
	length = ord(twoChars[1]) - ord(twoChars[0])
	if(not length == abs(length)): #Blir start - stop negativt?
		length = 26 - abs(length)
	return length

def convertLine(line,rollLength): #Line = rad från filen. rollLength = hur långt ska varje bokstav rullas?
	retLine=""
	for char in line:
		if char == " " or not char.istitle(): #Är bokstaven liten eller ett mellanslag?
			appendChar = char
		else:
			if ( ord(char) + rollLength) > 90: #Kommer rullningen att "börja om från A"?
				appendChar = chr( ord(char) -26 + rollLength)
			else:
				appendChar = chr(ord(char) + rollLength)

		retLine += appendChar #Lägg till bokstaven i slutet på den ursprungligen tomma strängen.

	return retLine + "\n" #Returnerar den krypterade sträng




def crypto():
	fromFileString = input("What file would you like to read from?")
	encryptionString = input("What does ur encryption look like?")

	rollLength = rollLengthFunc(encryptionString) #Hur långt ska bokstäverna rullas?
	
	try:
		fromFile = open(fromFileString,"r") 
		toFile = open("encryptedWith" +encryptionString +".txt" , 'w')#Skapar en ny fil som berättar vilken krypteringsnyckel som använts.

		for line in fromFile:
			line.rstrip('\n')
			toFile.write( convertLine(line, rollLength)) #Skriv det som convertLine returnear.


		fromFile.close()
		toFile.close()

	except IOError:
		print("You entered an invalid filename, closing down \n")
		pass


if __name__ =="__main__": #Gör det möjligt att köra doctest utan att kommentera ut något.
	crypto()

