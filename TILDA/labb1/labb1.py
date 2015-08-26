import time

class Location(): #Class that represents one location

	def __init__(self,name,desc,lat,lon,date):
		self.name = name
		self.desc = desc
		self.lat = lat #North/South
		self.lng = lon
		self.date = date

	def __str__(self):
		return self.name + self.desc + self.lat + self.lng + self.date

class LocationCollection(): #Class that sorts and makes Location:s searchable.

	def __init__(self,countryCode):
		self.locations = []
		start = time.clock()
		self.load(countryCode)
		self.loadTime = time.clock() - start 
		
	def search(self,searchString): #Uses binary-search to find the post matching searchstring.

		low = 0
		high = len(self.locationsByName) - 1
		while low <= high:
			mid = (low+high)//2
			post = self.locationsByName[mid]
			if searchString == post.name: 
				return post
			if searchString < post.name: #We're to far into the array
				high = mid-1
			else:						#We're not far enough into the array.
				low = mid+1
		return None #Nothing found, low was higher than high before any result was detected.


	def load(self,countryCode): #Loads all countries from disk.
		f = open("geodata"+countryCode+".txt","r")
		lines = f.readlines()

		n = 6 					#Start reading from line at index 6
		while( n < len(lines) ):
			newLocation = Location(lines[n],lines[n+1],lines[n+2],lines[n+3],lines[n+4]) #Check location-class for order of info.

			self.locations.append(newLocation)

			n += 6 				#6 lines read, so jump 6 steps 

		#Locations sorted by name
		self.locationsByName = sorted(self.locations, key=lambda location: location.name) 
		#Locations sorted by "southness"
		self.locationsBySouth = sorted(self.locations, key=lambda location:location.lat) 

	def findSouthest(self): #Returns index 0 in the array sorted by "southness"
		return self.locationsBySouth[0] #First entry will be the most north





print("Välkommen till plats-sökaren")
choice = int(input("Vill du söka efter Svenska(1) eller kinesiska(2) platser"))
print("Okej. Vänta några sekunder medans programmet laddar in platserna")

if choice == 2:
	locCollection = LocationCollection("CH")
else:
	locCollection = LocationCollection("SW") #Default är Svenska platser.


print("Du kan söka efter en plats mha:")
print("1. Namn")
print("2. Direkt ta emot den sydligaste platsen")

choice = int(input("Vad vill du göra:"))

if choice == 1:
	searchString = input("Ok. Vilken plats vill du ha information om? \nMåste vara en perfekt matchning:")+"\n"
	startTime = time.clock()
	result = locCollection.search(searchString)
	endTime = time.clock()
elif choice == 2:
	startTime = time.clock()
	result = locCollection.findSouthest()
	endTime = time.clock()

print("Sökningen tog " + str(startTime - endTime) + " sekunder.")
print("Och resultatet blev: \n")

if result == None:
	print("Inget hittades. Försök igen.")
else:
	print(result)
	


