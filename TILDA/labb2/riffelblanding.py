from LinkedQueue import LinkedQueue

def shuffle(deck): #Denna funktion blandar kortleken EN gång
	returnDeck = [] #Denna variabel kommer fyllas av den färdigblandade kortleken och sedan returneras
	half = int((len(deck))/2) #Index för halva kortleken

	topHalf = deck[:half] 		#Första halvan av kortleken
	topHalf.reverse() 			#Med pop kommer vi åt slutet av leken. Men vi vill ta kort uppifrån. Därav reverse.

	bottomHalf = deck[half:] 	#Andra halvan av kortleken
	bottomHalf.reverse()

	while len(topHalf) > 0: #Eftersom kortleken antas vara jämn behöver vi inte kolla båda halvorna.
		returnDeck.append(bottomHalf.pop())
		returnDeck.append(topHalf.pop())

	return returnDeck

print("Detta program simulerar blanding av kortlek. Metoden för blandning som används är 'riffel'")
numberOfCards = int(input("Hur många kort vill du ha i din kortlek?(Jämt tal)"))
numberOfShuffles = int(input("Hur många gånger vill du blanda kortleken?"))

deck = [str(x) for x in range(numberOfCards)] #Fejkad kortlek där varje kort representeras av en siffra

print("Innan blandning såg kortleken ut såhär:")
print(deck)

for n in range(numberOfShuffles):
	deck = shuffle(deck)

print("Efter blandning kommer kortleken se ut såhär:")
print(deck)
