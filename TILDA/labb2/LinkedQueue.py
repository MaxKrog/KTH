#Class som skapar en kö/länkad lista med hjälp av länkade noder
#LinkedQueue.doctest är medföljande test
#För att köra testet med full utmatning kör "python3 -m doctest -v LinkedQueue.doctest"


class LinkedQueue:

	def __init__(self):
		self.top = None

	def put(self,x):
		new = Node(x)

		if self.isEmpty(): #Om listan är tom pekar köns tom och bottom mot samma nod
			self.top = new
			self.bottom = new
		else:		
			self.bottom.next = new #Om listan inte är tom så flyttas köns egna pekare mot den nya noden
			self.bottom = new

	def get(self):
		x = self.top.value #Ta värdet av topnoden
		self.top = self.top.next  #Flytta köns top-pekare till nästa objekt i listan
		return x

	def isEmpty(self):
		if self.top == None: 
			return True
		else: 
			return False

class Node: #Alla noder i listan byggs av denna klass.

	def __init__(self, x):
		self.value = x #Denna nods "payload"
		self.next = None #Pekare till noden efter den i kön. Sätts först när en annan nod läggs till bakom.
