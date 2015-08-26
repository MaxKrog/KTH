from tkinter import *
import random
from chesssquare import ChessSquare


#Detta är en shack-brädes modul. Den kan inkluderas i ditt projekt och sedan packar du in modulen.container på valt ställe.
#När omgången är slut kommer modulen.parent.finished() kallas och användarens resultat skickas in i denna metod/funktion. 

class ChessBoard:
	def __init__(self, parent,root):
		self.parent = parent
		self.container = Frame(root)
		self.score = 0

		self.chessBoard = []
		self.createBoard()

		self.moveList = []

		self.row = random.randrange(0,8)
		self.col = random.randrange(0,8)

		self.endTurn(self.row,self.col)

		self.startTurn()
		

	def createBoard(self): #Skapar shackrädet. Alla rutor (som är ett eget object) läggs till i sef.chessBoard på rätt index.
		color = ["white","darkgrey"] #De två färgerna som shackbrädet består av.
		for i in range(8):
			tempRow = []
			for n in range(8):
				tempRow.append( ChessSquare(self,self.container,color[(i+n)%2],30,i,n))
			self.chessBoard.append(tempRow)		

	def endTurn(self,row,col): #Andra halvan av en omgång. Kallas från den klickade rutan som skickar in sin row & col.
		self.chessBoard[row][col].setOccupied(self.score)
		self.row = row
		self.col = col
		for move in self.moveList:
			self.chessBoard[move[0]][move[1]].removeAvailable()
		self.moveList=[] #Tömmer listan med tillgängliga rörelser.
		self.startTurn()


	def startTurn(self): #Första halvan av en omgång. Tar reda på alla möjliga rörelser och gör dessa klickbara.
		self.availableMoves()
		if len(self.moveList) > 0 :
			self.score +=1
			for move in self.moveList:
				self.chessBoard[move[0]][move[1]].setAvailable()

		else:
			self.parent.finished(self.score)		


	def availableMoves(self): #Skickar alla teoretiskt möjliga rörelser till self.testMove
		row = self.row
		col = self.col
		self.testMove(row+2,col+1)
		self.testMove(row+2,col-1)
		self.testMove(row-2,col+1)
		self.testMove(row-2,col-1)
		self.testMove(row+1,col+2)
		self.testMove(row+1,col-2)
		self.testMove(row-1,col+2)
		self.testMove(row-1,col-2)

    
	def testMove(self,row,col): #Om rutan på den tänkta rörelsen inte är .occupied så läggs den rörelsen till i self.moveList
		try:
			if row <= 7 and row >=0 and col <= 7 and col >= 0:
				if not self.chessBoard[row][col].occupied:
					self.moveList.append([row,col])
		except:
			pass
        

		