from tkinter import *
import random
from highscore import Highscore
from chessboard import ChessBoard


class MainView(): #Main view of the program. Ties the game & highscore-views together.
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

		#Highscore-vyn
		self.highscoreView = Highscore(self.root,"highscores.txt")
		self.highscoreBool = False

		#Spel-vyn
		self.gameView = ChessBoard(self,self.root)
		self.gameView.container.pack()

	def finished(self,score): #Kallas från self.gameView när det inte finns några möjliga förflyttningar
		index = self.highscoreView.finishedGame(score)
		self.toggleHighscore() #Visar automatiskt highscore när en omgång är över.


		#Creates a new game instance.
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

		self.highscoreBool = not self.highscoreBool


if __name__ == "__main__":
	root = Tk()
	root.wm_title("Springarens vandring")
	mainView = MainView(root)
	root.mainloop()


