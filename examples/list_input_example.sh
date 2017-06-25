#!/bin/bash
set -e
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today?" drinks

selected_drink="${drinks[$selected_index]}"

food=( 'Chicken Rice' 'Lor Mee' 'Nasi Lemak' 'Bak Kut Teh' )
list_input "What would you like to eat today?" food

selected_food="${food[$selected_index]}"

print "Drink: $selected_drink"
print "Food: $selected_food"
