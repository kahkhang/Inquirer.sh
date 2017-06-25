#!/bin/bash
set -e
source common.sh

on_list_input_up() {
  remove_list_instructions
  tput cub "$(tput cols)"
  tput el

  printf "  ${list[$selected_index]}"


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
  tput el

  printf "  ${list[$selected_index]}"

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
  tput el
  printf "${cyan}${list[$selected_index]}${normal}"

  tput cud1
  tput cub "$(tput cols)"
  tput el

  inquirer_break_keypress=true
  IFS=$OLD_IFS
}

remove_list_instructions() {
  if [ $first_keystroke = true ]; then
    tput cuu $((${selected_index}+1))
    tput cub "$(tput cols)"
    tput cuf $((${#prompt}+3))
    tput el
    tput cud $((${selected_index}+1))
    first_keystroke=false
  fi
}

list_input() {
  prompt=$1
  shift
  list=("${@}")
  selected_index=0
  first_keystroke=true

  trap control_c SIGINT EXIT

  stty -echo
  tput civis

  echo "${normal}${green}?${normal} ${bold}${prompt}${normal} ${dim}(Use arrow keys)${normal}"

  for i in $(gen_index ${#list[@]}); do
    tput cub "$(tput cols)"
    tput el
    if [ $i = 0 ]; then
      echo "${cyan}${arrow} ${list[$i]} ${normal}"
    else
      echo "  ${list[$i]}"
    fi
  done

  for j in $(gen_index ${#list[@]}); do
    tput cuu1
  done

  on_keypress on_list_input_up on_list_input_down on_list_input_enter_space on_list_input_enter_space
  unset list
}
