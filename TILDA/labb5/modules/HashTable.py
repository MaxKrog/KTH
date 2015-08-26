# Exposes HashTable(int {size of table}) class.
# Collision-sorting: Linked List
# KeyError : Raises KeyError


class Node():

	def __init__(self,key,payload):
		self.key = key
		self.payload = payload
		self.next = None

class HashTable():

	def __setitem__(self, key, value): 	#HashTable[key] = Value
		self.put(key,value)

	def __getitem__(self, key): 		# x = HashTable[key]
		return self.get(key)

	def __init__(self, expectedSize):
		self.setSize(expectedSize)
		print("Hashtabellens förväntade storlek är:" + str(expectedSize))
		self.list = [None for x in range(self.size)]
		print("Hashtabellens storlek är:" + str(self.size))

	def put(self,key,payload):
		index = self.hash(key)
		node = Node(key, payload)
		node.next = self.list[index]
		self.list[index] = node

	def get(self,key):
		index = self.hash(key)
		node = self.list[index]

		if node == None:
			raise KeyError(key)

		while True:
			if node.key == key:
				return node.payload
			elif not node.next == None:
				node = node.next
			else:
				raise KeyError

	def setSize(self,expectedSize): #Makes self.size a 2**n number (for speed)
		n = 2
		while True:
			if 2**n > 1.5 * expectedSize: #1.5 because some air is good.
				self.size = 2**n
				break
			n += 1

	def hash(self, word): #Function used to hash chars to integer
		h = 0
		for char in word:
			h = (h * 155 + ord(char)) % self.size
		return h




