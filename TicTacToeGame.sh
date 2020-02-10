#!/bin/bash 
echo "Welcome To Tic Tac Toe Game"

declare -a arrayBoard

#Variable
player=0
count=0
player_Position=0
arrayBoard=( " " " " " " " " " " " " " " " " " " " " " " )

function displayBoard(){
echo "|===|===|===|"
echo "| ${arrayBoard[1]} | ${arrayBoard[2]} | ${arrayBoard[3]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[4]} | ${arrayBoard[5]} | ${arrayBoard[6]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[7]} | ${arrayBoard[8]} | ${arrayBoard[9]} |"
echo "|===|===|===|"
}
function assignedLetter(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		player=X
	else
		player=O
	fi
	echo "Player Assigned Letter is $player"
}
function whoPlayFirst(){
	if [ $((RANDOM%2)) -eq 0 ]
	then
		echo "$player play first"
	else
		echo "$player play first"
	fi
}
function forRowOneChecking() {
	for(( i=1;i<=9;i=$(($i+3))))
	do
		if [[ ${arrayBoard[$i]} == ${arrayBoard[$(($i+1))]} && ${arrayBoard[$(($i+1))]} == ${arrayBoard[$(($i+2))]} && ${arrayBoard[$i]} == $player ]]
		then
			echo "Win: $player"
			exit
		fi
	done
}
function forcolumnChecking() {
	for(( j=1;j<=9;j++))
	do
		if [[ ${arrayBoard[$j]} == ${arrayBoard[$(($j+3))]} && ${arrayBoard[$(($j+3))]} == ${arrayBoard[$(($j+6))]} && ${arrayBoard[$j]} == $player ]]
		then
			echo "Win: $player"
			exit
		fi
	done
}
function forDiagonalChecking(){
		k=1
		if [[ ${arrayBoard[1]} == ${arrayBoard[5]} && ${arrayBoard[5]} == ${arrayBoard[9]} && ${arrayBoard[1]} == $player ]]
		then
			echo "Win: $player"
			exit
		elif [[ ${arrayBoard[3]} == ${arrayBoard[5]} && ${arrayBoard[7]} == ${arrayBoard[5]} && ${arrayBoard[3]} == $player ]]
		then
			echo "Win: $player"
			exit
		fi
}

function valueRangeOneToNine(){
	read -p "Enter value 1-9 " player_Position
	if [[ $player_Position -le 9 && $player_Position -ge 1 ]]
	then
		echo "User Enter value is:" $player_Position
	else
		echo "Value range is 1-9 try other value"
	fi
}
function duplicateCheck(){
	valueRangeOneToNine
	if [[ ${arrayBoard[$player_Position]} == " " ]]
	then
		arrayBoard[$player_Position]=$player
		((count++))
		displayBoard
	else
		echo "Already occuipied,Enter another value"
	fi
}


function userInputValue() {
	while [[ $count -lt 9 ]]
	do
		duplicateCheck
		forRowOneChecking
		forcolumnChecking
		forDiagonalChecking
	done
}

assignedLetter
whoPlayFirst
displayBoard
userInputValue
