#!/bin/bash
set -e

arrow=$(echo -e '\xe2\x9d\xaf')
filled_circle=$(echo -e '\xe2\x97\x89')
empty_circle=$(echo -e '\xe2\x97\xaf')

black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
bold=$(tput bold)
normal="$(tput sgr0)"

on_up() {
  tput cub "$(tput cols)"
  tput el

  printf "  ${list[$selected_index]}"


  if [ $selected_index = 0 ]; then
    selected_index=$((${#list[@]}-1))
    for j in $(gen_index $((${#list[@]}-1))); do
      tput cud1
    done
    tput cub "$(tput cols)"
  else
    selected_index=$((selected_index-1))

    tput cuu1
    tput cub "$(tput cols)"
    tput el
  fi

  printf "${cyan}${arrow} %s ${normal}" "${list[$selected_index]}"
}

on_down() {
  tput cub "$(tput cols)"
  tput el

  printf "  ${list[$selected_index]}"

  if [ $selected_index = $((${#list[@]}-1)) ]; then
    selected_index=0
    for j in $(gen_index $((${#list[@]}-1))); do
      tput cuu1
    done
    tput cub "$(tput cols)"
  else
    selected_index=$((selected_index+1))
    tput cud1
    tput cub "$(tput cols)"
    tput el
  fi
  printf "${cyan}${arrow} %s ${normal}" "${list[$selected_index]}"
}

on_left() {
  true;
}

on_right() {
  true;
}

on_space() {
  true;
}

on_enter() {
  true;
}

on_keypress() {
  local OLD_IFS
  local IFS
  local key
  OLD_IFS=$IFS
  while IFS="" read -rsn1 key; do
      case "$key" in
      $'\x1b')
          read -rsn1 key
          if [[ "$key" == "[" ]]; then
              read -rsn1 key
              case "$key" in
              'A') on_up;;
              'B') on_down;;
              'C') on_right;;
              'D') on_left;;
              esac
          fi
          ;;
      ' ') on_space;;
      '') break;;
      esac
  done
  IFS=$OLD_IFS
}

gen_index() {
  local k=$1
  local l=0
  if [ $k -gt 0 ]; then
    for l in $(seq $k)
    do
       echo "$l-1" | bc
    done
  fi
}

control_c() {
  tput cud 100000
  tput cub "$(tput cols)"
  tput cnorm
  stty echo
  exit $?
}

list_input() {
  prompt=$1
  shift
  list=("${@}")
  selected_index=0

  trap control_c SIGINT

  stty -echo
  tput civis

  echo "${normal}${green}?${normal} ${bold}${prompt}${normal}"

  for i in $(gen_index ${#list[@]}); do
    if [ $i = 0 ]; then
      echo "${cyan}${arrow} ${list[$i]} ${normal}"
    else
      echo "  ${list[$i]}"
    fi
  done

  for j in $(gen_index ${#list[@]}); do
    tput cuu1
  done

  on_keypress


  tput cud 100000
  tput cub "$(tput cols)"
  tput cnorm
  stty echo
}
