class LinkedQueue:

	def __init__(self):
		self.top = None

	def put(self,x):
		new = Node(x)

		if self.isEmpty(): #Inserted Node will be refered to as both top and bottom.
			self.top = new
			self.bottom = new
		else:		
			self.bottom.next = new #When only one Node in queue this is also self.top
			self.bottom = new

	def get(self):
		x = self.top.value
		self.top = self.top.next 
		return x

	def isEmpty(self):
		if self.top == None: 
			return True
		else: 
			return False


class Node:

	def __init__(self, x):
		self.value = x
		self.next = None
