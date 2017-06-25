#!/bin/bash
set -e
source common.sh

on_list_input_up() {
  remove_list_instructions
  tput cub "$(tput cols)"

  printf "  ${list[$selected_index]}"
  tput el

  if [ $selected_index = 0 ]; then
    selected_index=$((${#list[@]}-1))
    tput cud $((${#list[@]}-1))
    tput cub "$(tput cols)"
  else
    selected_index=$((selected_index-1))

    tput cuu1
    tput cub "$(tput cols)"
    tput el
  fi

  printf "${cyan}${arrow} %s ${normal}" "${list[$selected_index]}"
}

on_list_input_down() {
  remove_list_instructions
  tput cub "$(tput cols)"

  printf "  ${list[$selected_index]}"
  tput el

  if [ $selected_index = $((${#list[@]}-1)) ]; then
    selected_index=0
    tput cuu $((${#list[@]}-1))
    tput cub "$(tput cols)"
  else
    selected_index=$((selected_index+1))
    tput cud1
    tput cub "$(tput cols)"
    tput el
  fi
  printf "${cyan}${arrow} %s ${normal}" "${list[$selected_index]}"
}

on_list_input_enter_space() {
  local OLD_IFS
  OLD_IFS=$IFS
  IFS=$'\n'
  tput cuu $((${selected_index}+1))
  tput cub "$(tput cols)"


  tput cuf $((${#prompt}+3))
  printf "${cyan}${list[$selected_index]}${normal}"
  tput el

  tput cud1
  tput cub "$(tput cols)"
  tput el

  _break_keypress=true
  IFS=$OLD_IFS
}

remove_list_instructions() {
  if [ $_first_keystroke = true ]; then
    tput cuu $((${selected_index}+1))
    tput cub "$(tput cols)"
    tput cuf $((${#prompt}+3))
    tput el
    tput cud $((${selected_index}+1))
    _first_keystroke=false
  fi
}

list_input() {
  prompt=$1
  eval list=( '"${'${2}'[@]}"' )
  selected_index=0
  _first_keystroke=true

  trap control_c SIGINT EXIT

  stty -echo
  tput civis

  print "${normal}${green}?${normal} ${bold}${prompt}${normal} ${dim}(Use arrow keys)${normal}"

  for i in $(gen_index ${#list[@]}); do
    tput cub "$(tput cols)"
    if [ $i = 0 ]; then
      print "${cyan}${arrow} ${list[$i]} ${normal}"
    else
      print "  ${list[$i]}"
    fi
    tput el
  done

  for j in $(gen_index ${#list[@]}); do
    tput cuu1
  done

  on_keypress on_list_input_up on_list_input_down on_list_input_enter_space on_list_input_enter_space
  unset list
}
