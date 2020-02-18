#!/bin/bash
echo "Welcome To Tic Tac Toe Game"

declare -a arrayBoard

#Variable
player=X
computer=O
count=0
player_Position=0
winner=false
block=0
flag=false
arrayBoard=( - - - - - - - - - - )

#Display the empty board
function displayBoard(){
echo "| ${arrayBoard[1]} | ${arrayBoard[2]} | ${arrayBoard[3]} |"
echo "| ${arrayBoard[4]} | ${arrayBoard[5]} | ${arrayBoard[6]} |"
echo "| ${arrayBoard[7]} | ${arrayBoard[8]} | ${arrayBoard[9]} |"
}

#Checking Who play first
function toss(){
if(($((RANDOM%2))==0))
then
	flag=true
  player=X
  echo "player is playing First"
else
	flag=false
  computer=O
  echo "Computer is playing first"
fi
}
#Check winning condition in row,column,daigonal
function winningConditionCheck() {
	for(( i=1;i<=9;i+=3))
	do
		if [[ ${arrayBoard[$i]} == ${arrayBoard[$(($i+1))]} && ${arrayBoard[$(($i+1))]} == ${arrayBoard[$(($i+2))]} && ${arrayBoard[$i]} == $1 ]]
		then
			winner=true
		fi
	done
	for(( j=1;j<=9;j++))
	do
		if [[ ${arrayBoard[$j]} == ${arrayBoard[$((j+3))]} && ${arrayBoard[$((j+3))]} == ${arrayBoard[$((j+6))]} && ${arrayBoard[$j]} == $1 ]]
		then
			winner=true
		fi
	done
		if [[ ${arrayBoard[1]} == ${arrayBoard[5]} && ${arrayBoard[5]} == ${arrayBoard[9]} && ${arrayBoard[1]} == $1 ]]
		then
			winner=true
		elif [[ ${arrayBoard[3]} == ${arrayBoard[5]} && ${arrayBoard[7]} == ${arrayBoard[5]} && ${arrayBoard[3]} == $1 ]]
		then
			winner=true
		fi
}

#Check value in one to nine range and board is fill or empty.
function valueRangeOneToNine(){
	if [[ $player_Position -le 9 && $player_Position -ge 1  && $player_Position  != ' ' && ${arrayBoard[$player_Position]} == "-" ]]
	then
		echo "Enter value is:" $player_Position
	else
		echo "Enter value in 1-9 or Already occuipied value, Enter another value"
		changeTurn
	fi
}
#Condition for player and computer
#I)If player is playing 
#1)Take user value
#2)Check value in the range 1-9
#3)Place the value in board And checks for win or loss
#4)Then tag will be false and computer is play next the next turn
#II)If computer is playing then
#1)It will enter the value and
#2)Check value in range 1-9
#3)Place the value in board and check for win or loss
#4)check if user can be blocked condition for user
#5)Place value at i)corner ii)center iii)sides
function changeTurn(){
if [[ $flag == true ]]
	then
		echo "player is playing "
		read -p "Enter value in range 1-9 " player_Position
		valueRangeOneToNine $player_Position
		arrayBoard[$player_Position]=$player
		winningConditionCheck  $player
		if [[ $winner == true ]]
		then
			displayBoard
			echo "player is winner" $player
			exit
		fi
		displayBoard
		flag=false
	else
		echo "Computer is playing "
		computerCheckWinningPosition
		[[ $block == 0 ]] && computerBlockUserFromWinning
		[[ $block == 0 ]]	&& checkCorner
		[[ $block == 0 ]] && checkCenter
		[[ $block == 0 ]] && checkSide
		flag=true
		block=0
	fi
}

#Computer Check it's own winning position
function computerCheckWinningPosition() {
for((k=1;k<=9;k++))
do
	if [[ ${arrayBoard[$k]} == "-" ]]
	then
		arrayBoard[$k]=$computer
		winningConditionCheck  $computer
		if [[ $winner == true ]]
		then
			displayBoard
			block=1
			echo "computer is winner" $computer
			exit
			return 1
		else
			arrayBoard[$k]="-"
		fi
	fi
done
}
#Blocking condition for user 
function computerBlockUserFromWinning(){
for((k=1;k<=9;k++))
do
	if [[ ${arrayBoard[$k]} == "-" ]]
	then
		arrayBoard[$k]=$player
		winningConditionCheck  $player
		if [[ $winner == true ]]
		then
			arrayBoard[$k]=$computer
			displayBoard
			winner=false
			block=1
			return 1
		else
			arrayBoard[$k]="-"
		fi
	fi
done
}
#Computer check corner value first
function checkCorner(){
   for((i=1;i<=9;i+=2))
   do
      if(($i != 5))
      then
			if [[ ${arrayBoard[$i]} == "-" ]]
			then
				arrayBoard[$i]=$computer
				displayBoard
				block=1
				return 1
        break
			fi
      fi
   done
}
#Computer check for placing its position to center after corner is check
function checkCenter(){
			if [[ ${arrayBoard[$i]} == "-" ]]
			then
				arrayBoard[$i]=$computer
				displayBoard
				block=1
				return 1
			fi
}
#If side of board is empty then computer place to its side
function checkSide(){
   for((i=2;i<=9;i+=2))
   do
         if [[ ${arrayBoard[$i]} == "-" ]]
         then
         	arrayBoard[$i]=$computer
         	displayBoard
				  block=1
				  return 1        
 				  break
         fi
   done
}
#Checking user input and tie condition
function userInputValue() {
	while [[ $count -lt 9 ]]
	do
		if [[ $count == 10 ]]
   	then
    		echo "Game is tie"
   		exit
		fi
			changeTurn
			((count++))
	done
}

toss
userInputValue
