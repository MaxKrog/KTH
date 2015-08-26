from tkinter import *

class ChessSquare: #ChessSquare-class.
	def __init__(self,parent,container,color,dim,row,col):
		self.color = color
		self.occupied = False
		self.available = False
		self.parent = parent
		self.container = container
		self.dim = dim
		self.row = row
		self.col = col

		#canvas-UI
		self.canvas = Canvas(self.container,width=dim,height=dim,background=color,bd=1, relief='solid')
		self.canvas.grid(row=row+1,column=col+1)
		
		#Event-handler
		self.canvas.bind("<Button-1>", self.clicked)

	#Called when the square is available for movement. Makes it "clickable".
	def setAvailable(self):
		self.canvas.config(bg="green")
		self.available = True
	#Called in the cleanup-process. Makes the square "unclickable".
	def removeAvailable(self):
		self.available = False
		self.canvas.config(bg=self.color)

	#Handles click of canvas
	def clicked(self,event):
		if self.available:
			self.parent.endTurn(self.row,self.col)

	#Sets the ChessSquare as occupied. There is no method for undoing this as it isn't needed.
	def setOccupied(self,counter):
		self.occupied = True
		middle = self.dim/2
		self.canvas.create_text(middle+2,middle+2,width=self.dim,text=str(counter))
