#!/bin/bash
set -e
source list_input.sh
source checkbox_input.sh

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input "Which hawker centres do you prefer?" hawker_centres
selected_hawkers=( "${selected_options[@]}" )

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today?" drinks

selected_drink="${drinks[$selected_index]}"

food=( 'Chicken Rice' 'Lor Mee' 'Nasi Lemak' 'Bak Kut Teh' )
list_input "What would you like to eat today?" food

selected_food="${food[$selected_index]}"

print "              Your selections                   "
print "------------------------------------------------"
print "Drink: $selected_drink"
print "Food: $selected_food"
print "Hawker Centres: $(join "${selected_hawkers[@]}")"
print "------------------------------------------------"
