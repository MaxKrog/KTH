from tkinter import *
import tkinter.simpledialog
import os

#Denna highscore-vy kan användas i alla program där highscores med poäng & namn är av intresse.
#Inkludera denna modul och packa in modulen.container på lämpligt ställe.
#När en omgång är avslutad kallar du modulen.finishedGame() och kastar in användarens poäng.
#Om poängen är tillräckligt hög så tar modulen hand om att låta användaren fylla i ett namn osv.
#Omrendrar även vyn om ett nytt highscore har lagts till.


class Highscore(): #
	def __init__(self,root,filename): #Filename är strängen som pekar till .txt-filen där du vill spara highscores.
		self.root = root
		self.container = Frame(self.root)
		self.filename = filename
		self.list = []
		self.renderedScores = []
		self.render()

	def getHighscores(self): #Funktion som hämtar alla poäng på formen [[score,name],[score,name]...]
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

	def finishedGame(self,score): #Kallas när en omgång är avslutad.
		index = self.compare(score)
		if not index == -1 :
			self.save(index,score)
			self.render()
		else:
			tkinter.simpledialog.askstring("Du är för dålig!", "Skriv av dig din ilska här:")



	def render(self): #Om-rendrar vyn med de senaste highscorsen.
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

	#Undersöker om användarens poäng platsar på highscore-listan. Isf returneras index som den ska sättas in på. Om inte returneras -1
	def compare(self,score):
		highscores = self.getHighscores()

		index = 0
		for highscore in highscores:
			if score > int(highscore[1]): 
				return index
			index +=1
		if len(highscores) < 5: #Kollar om highscore-listan är full. 
			return len(highscores)

		return -1

	#Sparar poäng + namn på rätt plats. Om listans längd då blir > 5 så kapas det sista elementet bort.
	def save(self,index,score):
		name = tkinter.simpledialog.askstring("Grattis, nytt highscore!", "Namn:")
		highscores = self.getHighscores()
		highscores.insert(index,[name,str(score)])
		highscores = highscores[:5] 
		write = []

		for highscore in highscores:
			write.append(highscore[0]+"?"+str(highscore[1]+"\n"))
		if os.path.exists(self.filename):
			f = open(self.filename,"r+")
		else:
			f = open(self.filename,"w")
		f.writelines(write)
		f.close()












