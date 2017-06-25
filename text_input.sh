#!/bin/bash
set -e
source common.sh

text_input() {
  local prompt=$1
  local var_name=$2
  local input
  _read_prompt_start=$'\e[32m?\e[39m\e[1m'
  _read_prompt_end=$'\e[22m'
  _read_prompt="$( echo "$_read_prompt_start ${prompt} $_read_prompt_end")"
  read -p "$_read_prompt" input
  tput cuu1
  tput cub "$(tput cols)"
  tput cuf $((${#_read_prompt}-19))
  printf "${cyan}${input}${normal}"
  tput el
  tput cud1
  tput cub "$(tput cols)"
  tput el
  eval $2=\'"${input}"\'
}
