#Class som skapar en kö med hjälp av Pythons inbyggda lista.
#ListQueue.doctest är medföljande test
#För att köra testet med full utmatning kör "python3 -m doctest -v ListQueue.doctest"

class ListQueue(): 
	
	def __init__(self):
		self.list = []

	def isEmpty(self): 			#Kollar om listan är tom
		if len(self.list) == 0:
			return True
		return False

	def put(self,obj): 			#Lägger till obj sist i listan
		self.list.append(obj)

	def get(self): 				#Plocka ut det objektet som varit i kön längst
		self.list.reverse() 	#Vänd på listan
		ret = self.list.pop() 	#Ta ut det som ligger sist (förut först)
		self.list.reverse() 	#Vänd tillbaka listan
		return ret
