#!/bin/bash
set -e
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today (1st Drink)?" drinks selected_drink

food=( 'Chicken Rice' 'Lor Mee' 'Nasi Lemak' 'Bak Kut Teh' )
list_input "What would you like to eat today?" food selected_food

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input_index "What would you like to drink today (2nd Drink)?" drinks selected_drink_index

echo "Drink: $selected_drink"
echo "Food: $selected_food"
echo "2nd Drink: $selected_drink_index"
