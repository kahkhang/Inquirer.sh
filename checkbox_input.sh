#!/bin/bash
set -e
source common.sh

on_checkbox_input_up() {
  remove_checkbox_instructions
  tput cub "$(tput cols)"

  if [ "${selected[$_current_index]}" = true ]; then
    printf " ${green}${checked}${normal} ${list[$_current_index]} ${normal}"
  else
    printf " ${unchecked} ${list[$_current_index]} ${normal}"
  fi
  tput el

  if [ $_current_index = 0 ]; then
    _current_index=$((${#list[@]}-1))
    tput cud $((${#list[@]}-1))
    tput cub "$(tput cols)"
  else
    _current_index=$((_current_index-1))

    tput cuu1
    tput cub "$(tput cols)"
    tput el
  fi

  if [ "${selected[$_current_index]}" = true ]; then
    printf "${cyan}${arrow}${green}${checked}${normal} ${list[$_current_index]} ${normal}"
  else
    printf "${cyan}${arrow}${normal}${unchecked} ${list[$_current_index]} ${normal}"
  fi
}

on_checkbox_input_down() {
  remove_checkbox_instructions
  tput cub "$(tput cols)"

  if [ "${selected[$_current_index]}" = true ]; then
    printf " ${green}${checked}${normal} ${list[$_current_index]} ${normal}"
  else
    printf " ${unchecked} ${list[$_current_index]} ${normal}"
  fi

  tput el

  if [ $_current_index = $((${#list[@]}-1)) ]; then
    _current_index=0
    tput cuu $((${#list[@]}-1))
    tput cub "$(tput cols)"
  else
    _current_index=$((_current_index+1))
    tput cud1
    tput cub "$(tput cols)"
    tput el
  fi

  if [ "${selected[$_current_index]}" = true ]; then
    printf "${cyan}${arrow}${green}${checked}${normal} ${list[$_current_index]} ${normal}"
  else
    printf "${cyan}${arrow}${normal}${unchecked} ${list[$_current_index]} ${normal}"
  fi
}

on_checkbox_input_enter() {
  local OLD_IFS
  OLD_IFS=$IFS
  selected_indices=()
  selected_options=()
  IFS=$'\n'
  tput cuu $((${_current_index}+1))
  tput cub "$(tput cols)"

  for i in $(gen_index ${#list[@]}); do
    if [ "${selected[$i]}" = true ]; then
      selected_indices+=($i)
      selected_options+=("${list[$i]}")
    fi
  done

  tput cuf $((${#prompt}+3))
  printf "${cyan}$(join "${selected_options[@]}")${normal}"
  tput el

  tput cud1
  tput cub "$(tput cols)"
  tput el

  inquirer_break_keypress=true
  IFS=$OLD_IFS
}

on_checkbox_input_space() {
  remove_checkbox_instructions
  tput cub "$(tput cols)"
  tput el
  if [ "${selected[$_current_index]}" = true ]; then
    selected[$_current_index]=false
  else
    selected[$_current_index]=true
  fi

  if [ "${selected[$_current_index]}" = true ]; then
    printf "${cyan}${arrow}${green}${checked}${normal} ${list[$_current_index]} ${normal}"
  else
    printf "${cyan}${arrow}${normal}${unchecked} ${list[$_current_index]} ${normal}"
  fi
}

remove_checkbox_instructions() {
  if [ $_first_keystroke = true ]; then
    tput cuu $((${_current_index}+1))
    tput cub "$(tput cols)"
    tput cuf $((${#prompt}+3))
    tput el
    tput cud $((${_current_index}+1))
    _first_keystroke=false
  fi
}

checkbox_input() {
  prompt=$1
  shift
  list=("${@}")
  _current_index=0
  _first_keystroke=true

  trap control_c SIGINT EXIT

  stty -echo
  tput civis

  print "${normal}${green}?${normal} ${bold}${prompt}${normal} ${dim}(Press <space> to select, <enter> to finalize)${normal}"

  for i in $(gen_index ${#list[@]}); do
    selected[$i]=false
  done
  for i in $(gen_index ${#list[@]}); do
    tput cub "$(tput cols)"
    if [ $i = 0 ]; then
      if [ "${selected[$i]}" = true ]; then
        print "${cyan}${arrow}${green}${checked}${normal} ${list[$i]} ${normal}"
      else
        print "${cyan}${arrow}${normal}${unchecked} ${list[$i]} ${normal}"
      fi
    else
      if [ "${selected[$i]}" = true ]; then
        print " ${green}${checked}${normal} ${list[$i]} ${normal}"
      else
        print " ${unchecked} ${list[$i]} ${normal}"
      fi
    fi
    tput el
  done

  for j in $(gen_index ${#list[@]}); do
    tput cuu1
  done

  on_keypress on_checkbox_input_up on_checkbox_input_down on_checkbox_input_space on_checkbox_input_enter
  unset list
}
