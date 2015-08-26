



class MainMenu():
	pass




class  TVMenu():
	
	def __init__(self,name):
		self.TV = TV(name)


	def menu(self):
		print( self.TV.name)
		print("TV-programme: " + self.TV.retrieveChannelProgramme() )
		print("Kanal: " + self.TV.retrieveChannelName() )
		print("Volym : " + str(self.TV.volume))
		print("")
		print("1. Byt kanal")
		print("2. Higher Volume")
		print("3. Lower Volume")
		print("4. Tillbaka till Huvudmenyn")
		self.menuChoice()

	def menuChoice(self):

		choice = input("Choose an alternative: ")

		while True:
			try:
				choice = int(choice)
				if choice == 1:
					self.changeChannel()
					break
				elif choice == 2:
					self.TV.higherVolume()
					break
				elif choice == 3:
					self.TV.lowerVolume()
					break
				elif choice == 4:
					self.showMainMenu()
					break
				else:
					choice = input("Knas: ")
			except:
				choice = input("Helvete... : ")
		self.menu()

	def changeChannelMenu(self):
		index = 1
		os.system('clear')
		print(self.TV.name +" Har dessa kanaler:");
		for channel in self.TV.channels:
			print(str(index) +". " + channel[0] +" - " + channel[1])
			index +=1
		self.changeChannelChoice()


class TV():

	def __init__(self,name):
		self.name = name
		self.volume = 5
		self.channels = [
			["MTV","Music is life"],
			["TV 3","Har du tur i kärlek?"],
			["SVT 1","Pengar är inte allt"],
			["Kanal 4","Vem vill inte bli miljonär?"]]
		self.selectedChannel = 0

	def changeChannel(self,channelNumber):
		self.selectedChannel = channelNumber

	def retrieveChannelName(self):
		return self.channels[self.selectedChannel][0]

	def retrieveChannelProgramme(self):
		return self.channels[self.selectedChannel][1]

	def higherVolume(self):
		if( self.volume  < 10):
			self.volume +=1

	def lowerVolume(self):
		if(self.volume > 0):
			self.volume -=1

if __name__ == "__main__":
	TVMeny = TVMenu("KTH-TV")
	TVMeny.menu()



