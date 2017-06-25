#!/bin/bash
set -e
source checkbox_input.sh

hawker_centres=( 'Old Airport Road Hawker Centre' 'Golden Mile Food Complex' 'Maxwell Food Centre' 'Newton Food Centre' )
checkbox_input "Which hawker centres do you prefer?" "${hawker_centres[@]}"
selected_hawkers=( "${selected_options[@]}" )
print "Selected indices $(join "${selected_indices[@]}")"
print "Hawker Centres: $(join "${selected_hawkers[@]}")"
