from tkinter import *
#Detta är en shack-rute modul som används tillsammans med ChessBoard-modulen.
#Varje ruta har logik nog att avgöra om den har besökts och för att sätta på/stänga av möjligheten till förflyttning.
#row/col i init motsvarar rutans plats

class ChessSquare:
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

	#Kallas när rutan är tillgänglig för förflyttning. Gör rutan klickbar.
	def setAvailable(self):
		self.canvas.config(bg="green")
		self.available = True

	#Kallas när rutan inte längre ska vara klicbar. Gör den oklickbar.
	def removeAvailable(self):
		self.available = False
		self.canvas.config(bg=self.color)

	#Kallas när rutan är klickad. Testar först om den är klickbar.
	def clicked(self,event):
		if self.available:
			self.parent.endTurn(self.row,self.col)

	#Sätter rutan som ockuperad och renderar ut numret som kastats in i funktionen på rutan.
	def setOccupied(self,counter):
		self.occupied = True
		middle = self.dim/2
		self.canvas.create_text(middle+2,middle+2,width=self.dim,text=str(counter))
