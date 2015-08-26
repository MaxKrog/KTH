class BST(): #Binary Search Tree "Controller".

	def __init__(self):
		self.root = None

	def put(self,x): #For adding value to the tree
		if self.root == None:	
			self.root = Node(x)
		else:
			self._put(self.root,x)

	def _put(self,node,x): #Recursively finds were to put that value.
		if x > node.x :
			if node.hasRightChild():
				self._put(node.right,x)
			else:
				node.right = Node(x)
		else:
			if node.hasLeftChild():
				self._put(node.left,x)
			else:
				node.left = Node(x)

	def exists(self,x): #Check if value exists in tree
		if self.root == None:
			return False
		else:
			return self._exists(self.root,x)

	def _exists(self,node,x): #Recursively checks for value. Either returns False or calls _exists with ONE child-node.
		if node.x == x:
			return True
		if x > node.x :
			if node.hasRightChild():
				return self._exists(node.right,x)
			else:
				return False
		else:
			if node.hasLeftChild():
				return self._exists(node.left,x)
			else:
				return False

	def write(self): #Print out the tree
		if self.root == None:
			print("Empty Tree")
		else:
			self._write(self.root," ")

	def _write(self,node,indentation): #Indentation increases recursively for better visual printing.
		print(indentation + str(node.x))
		if node.hasLeftChild():
			self._write(node.left,indentation + " ")
		if node.hasRightChild():
			self._write(node.right,indentation + " ")

class Node():

	def __str__(self):
		return str(self.x)

	def __init__(self,x):
		self.x = x
		self.left = None
		self.right = None

	def hasRightChild(self): 
		return self.right #Python translates None to False and Object to True.

	def hasLeftChild(self):
		return self.left

