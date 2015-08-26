class HashTableDict():

	def __init__(self,size):
		self.size = size
		self.dict = {}

	def put(self,key,payload):
		self.dict[key] = payload

	def get(self,key):
		try:
			return self.dict[key]
		except KeyError:
			raise(KeyError(key))
