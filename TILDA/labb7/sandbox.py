atomList = ["H", "He", "Li", "Be", "B", "C", "N", "O", "F", "Ne", "Na", "Mg", "Al", "Si", "P", "S", "Cl", "Ar"]
from molgrafik import *

class Box:
	def __init__(self, parent=None):
		self.atom = "( )"
		self.num = 1
		self.next = None
		self.down = None
		self.parent = parent

	def formelCheck(self, var):
		if( len(var) == 0):
			raise Exception("Okänd atom vid radslutet")
		var = self.groupCheck(var)
		if len(var) > 0:
			raise Exception("Felaktig gruppstart vid radslutet " +str(var))

	def groupCheck(self, var):
		#print("GroupCheck " + var)
		if(len(var) == 0):
			self.parent.next = None
			return var

		if var[0] == "(":
			lengthBefore = len(var[1:])

			self.down = Box(self)
			var = self.down.groupCheck(var[1:])
			if len(var) == lengthBefore:
				raise Exception("Felaktig gruppstart vid radslutet " + str(var))

			if len(var) > 0 and var[0] == ")":
				var, didChange = self.numCheck(var[1:])

				if didChange:
					self.next = Box(self)
					return self.next.groupCheck(var)

				else:
					raise Exception("Saknad siffra vid radslutet " + str(var))

			else:
				raise Exception("Saknad högerparentes vid radslutet " + str(var))

		else:
			var, didChange = self.atomCheck(var)
			if didChange:
				var, didChange = self.numCheck(var)
				self.next = Box(self)
				return self.next.groupCheck(var)
			else:
				if(self.parent):
					self.parent.next = None
				return var

	def atomCheck(self, var):
		#print("atomCheck " + var)

		if var[0].isupper():

			if len(var) > 1 and var[1].islower() : #If first letter big, second should be small
				if var[:2] in atomList:			#Check if it is an atom
					self.atom = var[:2]
					return var[2:], True

				else:
					raise Exception("Okänd atom vid radslutet " + var[2:])

			elif var[0] in atomList:			#Check if it is an Atom
				self.atom = var[:1]
				return var[1:], True
			else:
				raise Exception("Okänd atom vid radslutet " + var[1:])

		elif var[0].islower() :
			raise Exception("Saknad stor bokstav vid radslutet " + str(var))

		else:
			return var, False

	def numCheck(self, var):
		#print("numCheck " + var)
		length = len(var)

		if length > 0:
			numIndex = 0

			for i in range(length):
				if var[i].isdigit():
					numIndex += 1
					if int(var[0]) == 0:
						break

				else:
					break

			if numIndex == 0:
				return var, False
			else:
				if int(var[:numIndex]) > 1 :

					self.num = int(var[:numIndex])

					return var[numIndex:], True
				else:
					raise Exception("För litet tal vid radslutet " + str(var[numIndex:]))

		return var, False


def molWeight(node):
	if node == None:
		return 0
	if node.down:
		down = node.num * molWeight(node.down)
		if node.next:
			return down + molWeight(node.next)
		else:
			return down
	else:
		return node.num + molWeight(node.next)

mg = Molgrafik()
print("Detta program tar emot molekyler och ritar upp deras träd.")
while True:
	molString = input("En molekyl tack (avsluta med tomt):")
	molString = molString.rstrip("\n")
	if molString == "":
		break

	try:
		box = Box()
		box.formelCheck(molString)
		weight = molWeight(box)
		mg.show(box, weight)

	except Exception as error:
		print(error)

