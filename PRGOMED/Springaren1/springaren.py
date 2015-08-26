from tkinter import *
import random
from highscore import Highscore
from chessboard import ChessBoard
import tkinter.simpledialog

class MainView(): #Klassens huvud-vy. Samlar ihop och bestämmer layout av de andra modulerna.
	
	def __init__(self,root):
		self.root = root

		#Knapparnas-container
		self.menu = Frame(self.root)
		self.menu.pack()

		#Ny-omgång knappen
		self.newGameButton = Button(self.menu,height=1,width=20,text="Ny spelomgång")
		self.newGameButton.bind("<Button-1>",self.newGame)
		self.newGameButton.pack(side=LEFT)

		#highscore-knappen
		self.highscoreButton = Button(self.menu,height=1,width=20,text="Toggla Highscores")
		self.highscoreButton.bind("<Button-1>",self.toggleHighscore)
		self.highscoreButton.pack(side=LEFT)

		#Highscore-vyn/modulen
		self.highscoreView = Highscore(self.root,"highscores.txt")
		self.highscoreBool = False

		#Spel-vyn/modulen
		self.gameView = ChessBoard(self,self.root)
		self.gameView.container.pack()

		#Absolut noll dokumentation på tkinter.simpledialog. Denna ruta presenterar programmet. Ingen input är nödvändig.
		tkinter.simpledialog.askstring("Info", "I detta spel rör du sig som en springare \npå ett shackbräde. Du får bara gå på \n varje ruta en gång och målet är att gå \nså många steg som möjligt. \n\nKlicka OK för att köra!")

		
	def finished(self,score): #Kallas från self.gameView när det inte finns några möjliga förflyttningar
		index = self.highscoreView.finishedGame(score)
		self.toggleHighscore() #Visar automatiskt highscore-vyn när en omgång är över.


		#När ny-omgång knappen klickas är det denna funktion som anropas. Startar en ny omgång.
	def newGame(self,event):
		if self.highscoreBool :
			self.highscoreView.container.pack_forget()
			self.highscoreBool = not self.highscoreBool

		self.gameView.container.pack_forget()
		self.gameView.container.destroy()
		self.gameView = ChessBoard(self,self.root) #Ny instans av ChessBoard.
		self.gameView.container.pack()

	def toggleHighscore(self,event=None): #Togglar visning av highscore/spelvyn
		if self.highscoreBool :
			self.highscoreView.container.pack_forget()
			self.gameView.container.pack()
		else:
			self.highscoreView.container.pack()
			self.gameView.container.pack_forget()

		self.highscoreBool = not self.highscoreBool #Switchar Boolean-värde 


if __name__ == "__main__":
	root = Tk()
	root.wm_title("Springarens vandring")
	mainView = MainView(root)
	root.mainloop()


