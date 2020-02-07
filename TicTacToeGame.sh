#!/bin/bash 
echo "Welcome To Tic Tac Toe Game"

declare -a arrayBoard

arrayBoard=( 1 2 3 4 5 6 7 8 9 )

displayBoard(){
echo "|===|===|===|"
echo "| ${arrayBoard[0]} | ${arrayBoard[1]} | ${arrayBoard[2]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[3]} | ${arrayBoard[4]} | ${arrayBoard[5]} |"
echo "|===|===|===|"
echo "| ${arrayBoard[6]} | ${arrayBoard[7]} | ${arrayBoard[8]} |"
echo "|===|===|===|"
}




