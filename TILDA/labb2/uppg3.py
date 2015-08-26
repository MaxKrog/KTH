#from ListQueue import ListQueue
#queue = ListQueue()

	#Kön kan importeras från båda klasserna. 

from LinkedQueue import LinkedQueue
queue = LinkedQueue()


deck = input("Vilken ordning ligger korten i? Mellanslag mellan kortnamnen tack.")
deck = deck.split(" ")

for card in deck: #Lägg in korten i listan
	queue.put(card)

print("Dom kommer att presenteras i följande ordning: ",end="")

while not queue.isEmpty():  	#Sålänge det finns kort kvar i kön
	card = queue.get()			#Ta upp ett kort
	queue.put(card)				#Lägg samma kort sist
	print(queue.get(),end=" ") 	#Ta upp ett nytt kort och printa dess värde (det är nu ute ur kön)
print()
