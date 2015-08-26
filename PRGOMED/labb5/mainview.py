from tvcontroller import TVController
import os

class MainController(object):
	TVControllers = []
	def __init__(self,TVApparater):
		for namn in TVApparater:
			self.TVControllers.append(TVController(namn,self)) #Skapar en ny TVController.
		self.mainMenu()

	def mainMenu(self): #Printar menyn och callar sen self.select()
		index = 1
		os.system('clear')
		print("Welcome to the TV-simulator")
		for TVController in self.TVControllers:
			print(str(index) +". " + TVController.TV.name)
			index += 1
		print(str(index) +". Avsluta och spara")
		self.select()

	def select(self): #Processar input och leder alltid vidare till att en funktion callas.
		choice = input("Choice: ")
		while True:
			try:
				choice = int(choice) #Är det ens en siffra?
				if choice >= 1 and choice <= len(self.TVControllers) +1 : #Ligger choice i rätt spann?
					if choice == len(self.TVControllers) + 1 : #Är choice samma värde som exit?
						self.exit()
						break
					else:
						self.chooseTV(choice) #Välj en TV att ändra.
						break

				else:
					raise ValueError(".")

			except: #Alla fel ska leda hit.
				choice = input("Wrong TV-choice input, try again")

	def chooseTV(self,choice): #Starta upp en TV-modul
		choice -= 1 #Korigerar för indexet i TVControllersListan.
		self.TVControllers[choice].mainMenu()

	def exit(self): #Stäng ner programmet. Ska även calla .save på alla TVs.
		for TVController in self.TVControllers:
			TVController.TV.save()
		print("Bye bye, everything is saved so you can pick up right where you left off")

MainController(["Köks-TV","Vardagsrums-TV"])
