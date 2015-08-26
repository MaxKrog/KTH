# -*- coding: utf-8 -*-

import random,sys,time

def isBoxBusy(gamePlan,row, col, EMPTY):
  if gamePlan[row][col] == EMPTY:
    return False
  return True

def computerSelectABox(gamePlan,sign,EMPTY):
  size = len(gamePlan)
  print("\n---Datorns tur ("+str(sign)+")---")
  row = random.randrange(0,size)
  col = random.randrange(0,size)
  while isBoxBusy(gamePlan, row, col,EMPTY):
      row = random.randrange(0,size)
      col = random.randrange(0,size)
  print("Ange raden:",end = " ")
  sys.stdout.flush()
  time.sleep(0.6)
  print(row)
  print("Ange kolumnen:",end = " ")
  sys.stdout.flush()
  time.sleep(1)
  print(col)
  time.sleep(0.6)
  return row,col

def count(spelplan,x,y, xr, yr, tecken):
        if -1<x+xr<len(spelplan) and -1<y+yr<len(spelplan):
            if spelplan[x+xr][y+yr] != tecken :
                return 0
            else:
                return 1+count(spelplan,x+xr,y+yr,xr,yr,tecken)
        else:
            return 0

def lookForWinner(spelplan,x,y,VINRAD):
        t=spelplan[x][y]
        if (count(spelplan,x,y,1,0,t) + count(spelplan,x,y,-1,0,t)+1==VINRAD):
            return True
        if (count(spelplan,x,y,0,1,t) + count(spelplan,x,y,0,-1,t)+1==VINRAD):
            return True
        if (count(spelplan,x,y,1,1,t) + count(spelplan,x,y,-1,-1,t)+1==VINRAD):
            return True
        if (count(spelplan,x,y,-1,1,t) + count(spelplan,x,y,1,-1,t)+1==VINRAD):
            return True
        else: return False


if __name__=="__main__":
    pass
