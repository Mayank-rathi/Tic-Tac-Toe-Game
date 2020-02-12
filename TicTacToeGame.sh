#!/bin/bash
echo "Welcome To Tic Tac Toe Game"

declare -a arrayBoard

#Variable
player=X
computer=O
count=0
player_Position=0
arrayBoard=( - - - - - - - - - - )
winner=false
#Display the empty board
function displayBoard(){
echo "|===|===|===|"
echo "| ${arrayBoard[1]} | ${arrayBoard[2]} | ${arrayBoard[3]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[4]} | ${arrayBoard[5]} | ${arrayBoard[6]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[7]} | ${arrayBoard[8]} | ${arrayBoard[9]} |"
echo "|===|===|===|"
}

#Checking Who play first
function toss(){
if(($((RANDOM%2))==0))
then
	flag=true
else
	flag=false
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
		echo "$1 Enter value is:" $player_Position
	else
		echo "Enter value in 1-9 or Already occuipied,Enter another value"
		changeTurn
	fi
}
function changeTurn(){
	if [[ $flag == true ]]
	then
		echo "User playing "
		read -p "Enter value 1-9 " player_Position
		valueRangeOneToNine $player_Position
		arrayBoard[$player_Position]=$player
		winningConditionCheck  $player
		if [[ $winner == true ]]
		then
			displayBoard
			echo "user is winner"
			exit
		fi
		displayBoard
		flag=false
	else
		computerCheckWinningPosition
		echo "Computer playing "
		player_Position=$((RANDOM%9+1))
		valueRangeOneToNine
		arrayBoard[$player_Position]=$computer
		displayBoard
		flag=true
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
			echo "computer is winner"
			exit
		else
			arrayBoard[$k]="-"
		fi
	fi
done
}

#Checking user input and tie condition
function userInputValue() {
	while [[ $count -le 9 ]]
	do
		if [[ $count == 9 ]]
   	then
     		echo "Game is tie"
     		exit
		fi
		changeTurn

	#		 valueRangeOneToNine
			((count++))

			winningConditionCheck
	done
}
toss
userInputValue
