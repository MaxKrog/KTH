from tvmodel import TV
import os

class TVController(object):

	def __init__(self,name,master=None): #master = Referens till den class som skapade en instans av denna klass.
		self.master = master
		self.TV = TV(name)

	def mainMenu(self):
		os.system('clear')
		print(self.TV.name)
		print("TV-programme: " + self.TV.selectedProgramme())
		print("Channel: " + self.TV.selectedChannelFunc())
		print("Volume: " + str(self.TV.volume))
		print()
		print("1. Change Channel")
		print("2. Lower Volume")
		print("3. Higher Volume")
		print("4. Back to main menu")
		self.mainMenuChoice()

	def mainMenuChoice(self):
		choice = input("Choice: ")
		while True:
			try:
				choice = int(choice) #Är det ens en siffra?
				if choice == 1:  ##HELA DENNA SKA BYTAS UT MOT EN CASE-SATS
					self.changeChannelMenu()
					break					
				elif choice == 2:
					self.TV.lowerVolume()
					self.mainMenu()
					break
				elif choice == 3:
					self.TV.higherVolume()
					self.mainMenu()
					break
				elif choice == 4:
					self.exit()
					break
				else:
						raise ValueError("Not a correct number")

			except: #Alla fel ska leda hit.
				choice = input("Wrong input, try again")

	def changeChannelMenu(self):
		index = 1
		os.system('clear')
		print(self.TV.name +" Har dessa kanaler:");
		for channel in self.TV.channels:
			print(str(index) +". " + channel[0] +" - " + channel[1])
			index +=1
		self.changeChannelChoice()

	def changeChannelChoice(self):
		choice = input("Choice: ")
		loop = True
		while loop:	
			try:
				choice = int(choice)
				if choice > 0 and choice <= len(self.TV.channels):
					loop = False
					choice -=1
					self.TV.changeChannel(choice)
					self.mainMenu()
				else:
					raise ValueError(".")
			except:
				choice = input("Wrong channel input, try again: ")
		

	def exit(self): #Kör MainControllers mainMenu() och kör vidare från den.
		self.master.mainMenu()

	def save(self):
		self.TV.save()



