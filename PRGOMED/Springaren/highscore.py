from tkinter import *
import tkinter.simpledialog
import os

class Highscore(): #Highscore-module including views etc. module.container = an insertable frame.
	def __init__(self,root,filename):#Lägga till fileName - variabel för att kunna doctesta en separat lista.
		self.root = root
		self.container = Frame(self.root)
		self.filename = filename
		self.list = []
		self.renderedScores = []
		self.render()

	def getHighscores(self): #Function that retrieves all the scores in form [[score,name],[score,name]...]
		scoreList=[]
		if os.path.exists(self.filename):
			f = open(self.filename,"r+")
			lines = f.readlines()
			f.close()
			for line in lines:
				line = line.rstrip("\n")
				line = line.split("?")
				scoreList.append(line)
		return scoreList

	def finishedGame(self,score): #Called when a game is finished. Checks if score is highscore-worthy.
		index = self.compare(score)
		if not index == -1 :
			self.save(index,score)
			self.render()
		else:
			tkinter.simpledialog.askstring("Du är för dålig!", "Skriv av dig din ilska här:")



	def render(self): #Re-renders the view. Cleans upp old elements if there are any.
		if len(self.renderedScores) > 0 :
			for renderedScore in self.renderedScores:
				renderedScore.pack_forget()
				renderedScore.destroy()

			self.renderedScores = []	

		highscores = self.getHighscores()

		for highscore in highscores:
			rowText = highscore[1] + " " + highscore[0]
			scoreRow = Label(self.container,width=40,height=1,text=rowText)
			scoreRow.pack()
			self.renderedScores.append(scoreRow)

	#Decides whetever a score is highscore-worthy. In that case returns the insertion index. If not it returns -1
	def compare(self,score):
		highscores = self.getHighscores()

		index = 0
		for highscore in highscores:
			if score > int(highscore[1]): #Check if user-score is higher than any scores on the list. In that case returns insertion-index
				return index
			index +=1
		if len(highscores) < 5: #Is the highscore-list full? Otherwise return index of last element.
			return len(highscores)

		return -1 #The score isn't good enough.

	#Saves the score and name at the index returned from self.compare.
	def save(self,index,score):
		name = tkinter.simpledialog.askstring("Grattis, nytt highscore!", "Namn:")
		highscores = self.getHighscores()
		highscores.insert(index,[name,str(score)])
		highscores = highscores[:5] #Makes sure len(highscores) is <= 5
		write = [] #Empty list to contain all the rows to be written.

		for highscore in highscores:
			write.append(highscore[0]+"?"+str(highscore[1]+"\n"))
		if os.path.exists(self.filename): #Finns det redan en highscores-fil?
			f = open(self.filename,"r+")
		else:
			f = open(self.filename,"w")
		f.writelines(write)
		f.close()












