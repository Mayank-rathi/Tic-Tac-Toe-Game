#!/bin/bash
echo "Welcome To Tic Tac Toe Game"

declare -a arrayBoard

#Variable
player=X
computer=O
count=0
player_Position=0
arrayBoard=( " " " " " " " " " " " " " " " " " " " " " " )
user=0
function displayBoard(){
echo "|===|===|===|"
echo "| ${arrayBoard[1]} | ${arrayBoard[2]} | ${arrayBoard[3]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[4]} | ${arrayBoard[5]} | ${arrayBoard[6]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[7]} | ${arrayBoard[8]} | ${arrayBoard[9]} |"
echo "|===|===|===|"
}
if(($((RANDOM%2))==0))
then
	flag=true
else
	flag=false
fi

function forRowOneChecking() {
	for(( i=1;i<=9;i+=3))
	do
		if [[ ${arrayBoard[$i]} == ${arrayBoard[$(($i+1))]} && ${arrayBoard[$(($i+1))]} == ${arrayBoard[$(($i+2))]} && ${arrayBoard[$i]} == "$user" ]]
		then
			echo "Win"
			exit
		fi
	done
}

function forcolumnChecking() {
	for(( j=1;j<=9;j++))
	do
		if [[ ${arrayBoard[$j]} == ${arrayBoard[$((j+3))]} && ${arrayBoard[$((j+3))]} == ${arrayBoard[$((j+6))]} && ${arrayBoard[$j]} == "$user" ]]
		then
			echo "Win"
			exit
		fi
	done
}
function forDiagonalChecking(){
		if [[ ${arrayBoard[1]} == ${arrayBoard[5]} && ${arrayBoard[5]} == ${arrayBoard[9]} && ${arrayBoard[1]} == $player ]]
		then
			echo "Win"
			exit
		elif [[ ${arrayBoard[3]} == ${arrayBoard[5]} && ${arrayBoard[7]} == ${arrayBoard[5]} && ${arrayBoard[3]} == $player ]]
		then
			echo "Win"
			exit
		fi
}

function valueRangeOneToNine(){
	if [[ $player_Position -le 9 && $player_Position -ge 1 ]]
	then
		echo "$1 Enter value is:" $player_Position
	else
		echo "Value range is 1-9 try other value"
	fi
}
function duplicateCheck(){
	valueRangeOneToNine
	if [[ ${arrayBoard[$player_Position]} == " " ]]
	then
		echo "Enter value is" $player_Position
	
	elif [[ $count == 9 ]]
	then
		echo "TIE"
		exit
	else
		echo "Already occuipied,Enter another value"
		changeTurn
	fi
}
function changeTurn(){
	if [[ $flag == true ]]
	then
		user=$player
		echo "User playing "
		read -p "Enter value 1-9 " player_Position
		duplicateCheck user
		arrayBoard[$player_Position]=$player
		displayBoard
		flag=false
	else
		user=$computer
		echo "computer playing "
		player_Position=$((RANDOM%9+1))
		duplicateCheck computer
		arrayBoard[$player_Position]=$computer
		displayBoard
		flag=true
	fi
}


function userInputValue() {
	while [[ $count -le 20 ]]
	do
		if [[ $count == 9 ]]
   	then
     		echo "Game is tie"
     		exit
		fi
			echo "count is $count"
			changeTurn
			((count++))
			echo "countwr is $count"	
			forRowOneChecking
			forcolumnChecking
			forDiagonalChecking
	done
}
userInputValue

