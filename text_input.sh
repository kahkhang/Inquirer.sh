#!/bin/bash
set -e
source common.sh

on_text_input_left() {
  if [ $_current_pos -gt 0 ]; then
    tput cub1
    _current_pos=$(($_current_pos-1))
  fi
}

on_text_input_right() {
  if [ $_current_pos -lt ${#input} ]; then
    tput cuf1
    _current_pos=$(($_current_pos+1))
  fi
}

on_text_input_enter() {
  tput cub "$(tput cols)"
  tput cuf $((${#_read_prompt}-19))
  printf "${cyan}${input}${normal}"
  tput el
  tput cud1
  tput cub "$(tput cols)"
  tput el
  eval $var_name=\'"${input}"\'
  _break_keypress=true
}

on_text_input_ascii() {
  local c=$1

  if [ "$c" = '' ]; then
    c=' '
  fi

  local rest="${input:$_current_pos}"
  input="${input:0:$_current_pos}$c$rest"
  _current_pos=$(($_current_pos+1))

  tput civis
  printf "$c$rest"
  tput el
  if [ ${#rest} -gt 0 ]; then
    tput cub ${#rest}
  fi
  tput cnorm
}

on_text_input_backspace() {
  if [ $_current_pos -gt 0 ]; then
    local start="${input:0:$(($_current_pos-1))}"
    local rest="${input:$_current_pos}"
    _current_pos=$(($_current_pos-1))
    tput cub 1
    tput civis
    printf "$rest"
    tput el
    input="$start$rest"
    if [ ${#rest} -gt 0 ]; then
      tput cub ${#rest}
    fi
    tput cnorm
  fi
}

text_input() {
  prompt=$1
  local var_name=$2

  _read_prompt_start=$'\e[32m?\e[39m\e[1m'
  _read_prompt_end=$'\e[22m'
  _read_prompt="$( echo "$_read_prompt_start ${prompt} $_read_prompt_end")"
  _current_pos=0
  input=""
  printf "$_read_prompt"


  trap control_c SIGINT EXIT

  stty -echo

  on_keypress on_default on_default on_text_input_ascii on_text_input_enter on_text_input_left on_text_input_right on_text_input_ascii on_text_input_backspace
  eval $var_name=\'"${input}"\'
}
