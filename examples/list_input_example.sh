#!/bin/bash
set -e
source list_input.sh

drinks=( 'Teh' 'Teh Ping Gao Siu Dai' 'Kopi O' 'Yuan Yang' )
list_input "What would you like to drink today?" "${drinks[@]}"

echo "Selected: ${drinks[$selected_index]}"
