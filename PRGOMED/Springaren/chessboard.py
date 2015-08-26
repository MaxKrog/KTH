from tkinter import *
import random
from chesssquare import ChessSquare


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

	def createBoard(self): #Creates the Chessboard
		color = ["white","darkgrey"] #The 2 colors that make up the chessboard.
		for i in range(8):
			tempRow = []
			for n in range(8):
				tempRow.append( ChessSquare(self,self.container,color[(i+n)%2],30,i,n))
			self.chessBoard.append(tempRow)		

	def endTurn(self,row,col): #Called from clicked chesssquare
		self.chessBoard[row][col].setOccupied(self.score)
		self.row = row
		self.col = col
		self.score +=1
		for move in self.moveList:
			self.chessBoard[move[0]][move[1]].removeAvailable()
		self.moveList=[]
		self.startTurn()


	def startTurn(self):
		self.availableMoves()
		if len(self.moveList) > 0 :
			for move in self.moveList:
				self.chessBoard[move[0]][move[1]].setAvailable()

		else:
			self.parent.finished(self.score)		


	def availableMoves(self): #Sends all maybe-possible moves to self.testMove
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

    
	def testMove(self,row,col): #If the move is available it pushes it to self.moveList
		try:
			if row <= 7 and row >=0 and col <= 7 and col >= 0:
				if not self.chessBoard[row][col].occupied:
					self.moveList.append([row,col])
		except:
			pass
        

		