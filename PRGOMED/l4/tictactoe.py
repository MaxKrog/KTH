# -*- coding: utf-8 -*-
import tictactoe_functions
import random

def createGamePlan(size, sign):
  gPlan = []
  #row = [sign]*size
  for i in range(size):
    gPlan.append([sign]*size) #gPlan.append(row) pointed all items in list to the same variable
  return gPlan


def showGamePlan(gamePlan):
  i = 0
  numbers=list(range(0,len(gamePlan)))
  rowNr = [" "]+numbers
  for row in [numbers]+gamePlan:
    print(rowNr[i],end = " ")
    i += 1
    for cell in row:
      print(cell,end = " ")
    print()


def updateGamePlan(row,col,gamePlan,sign):
  gamePlan[row][col] = sign


def anyVacantBoxes(gamePlan,EMPTY):
  for row in gamePlan: # gamePlan[0], finish game too soon, only checks first row for empty
      if EMPTY in row: # if EMPTY in gamePlan kollar om EMPTY är lika med hela elementet
        return True
  return False


def humanSelectABox(sign, gamePlan, EMPTY):
  print("\n---Din tur ("+sign+")---")
  
  x=1
  while x: ############### loop and input-tests until success
    try:
      row = int(input("Ange raden: "))
      col = int(input("Ange kolumnen: "))

      if gamePlan[row][col] == EMPTY: ### checks if box is empty
        x=0
        return row,col
      else:
        print("Upptagen ruta! Försök igen.")

    except ValueError:
      print("Var vänligen skriv ett nummer! Försök igen.")
    except IndexError:
      print("Utanför spelplanen! Försök igen.") ################


def play2win(gamePlan, sign, message,EMPTY,WINROW):
  if sign == HUMAN:
    row,col = humanSelectABox(sign, gamePlan, EMPTY)
  else:
    row,col = tictactoe_functions.computerSelectABox(gamePlan,sign,EMPTY)

  updateGamePlan(row,col,gamePlan,sign)


  if(tictactoe_functions.lookForWinner(gamePlan,row,col,WINROW)):
    print(message)
    return True
    ## Swapped lookForWinner and anyVacantBoxes. Gave no winner if win on last turn
  if not anyVacantBoxes(gamePlan,EMPTY): 
    print("No winner!")
    return True

  return False


if __name__ == "__main__":
  WINROW = 3
  SIZE = 3
  EMPTY = '-'
  HUMAN = 'X'
  COMPUTER = 'O'
  playersInfo = ((HUMAN,"\n****** You won! ******\n"), (COMPUTER, "\n****** Computer won! ******\n"))
  playerIndx = random.choice([0,1])
  gamePlan = createGamePlan(SIZE, EMPTY)
  showGamePlan(gamePlan)
  gameFinished = False
  while not gameFinished:
    gameFinished = play2win(gamePlan, playersInfo[playerIndx][0], playersInfo[playerIndx][1], EMPTY,WINROW)
    showGamePlan(gamePlan)

    if playerIndx == 0:
      playerIndx = 1
    else:
      playerIndx = 0

"""
1 - Programmet slumpar vem som ska börja spelet, datorn eller den som kör programmet
2 - Spelplanet skapas
3 - Första spelare väljer en ruta
4 - Programmet uppdaterar spelplanen med vad som inputades
5 - Programmet kollar om det finns lediga rutor, avslutar om det inte finns
6 - Programmet anropar funktion som kollar om det finns en vinnande rad.
7 - Spelplanet skriv ut och beroende på om spelet är slut eller inte så loopar det tillbaka till 1 eller avslutas.
8 - Loopar i en while-loop så länge gameFinished är False

"""