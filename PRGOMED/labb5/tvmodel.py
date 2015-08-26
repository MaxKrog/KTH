import os
class TV(object):

	def save(self): 
		if os.path.exists("./saves/" + self.name + ".txt"): #Does a previous version exist?
			f = open("./saves/" +self.name +".txt","r+")
		else:
			f = open("./saves/" +self.name +".txt","w")

		f.write( str(self.selectedChannel) + "_" + str(self.volume) +"\n")
		f.close()

	def load(self):
		if os.path.exists("./saves/" + self.name + ".txt"):
			f = open("./saves/" +self.name +".txt","r+")
			line = f.readlines()
			line = line[0].rstrip("\n")
			line = line.split("_")
			try:
				self.selectedChannel = int(line[0])
				self.volume = int(line[1])
			except:
				pass

	def __init__(self,name):
		self.name = name
		self.channels = [
			["MTV","Music is life"],
			["TV 3","Har du tur i kärlek?"],
			["SVT 1","Pengar är inte allt"],
			["Kanal 4","Vem vill inte bli miljonär?"]]
		self.volume = 3
		self.selectedChannel = 0;
		self.load()


	def selectedChannelFunc(self):
		return self.channels[self.selectedChannel][0]

	def selectedProgramme(self):
		return self.channels[self.selectedChannel][1]

	def changeChannel(self,channelNumber):
		self.selectedChannel = channelNumber

	def higherVolume(self): #Higher the volume
		if self.volume < 10:
			self.volume += 1
		return self.volume

	def lowerVolume(self): #Lower the volume
		if self.volume > 0:
			self.volume -= 1
		return self.volume

