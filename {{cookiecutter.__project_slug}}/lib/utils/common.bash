#!/usr/bin/env bash
#
# You have to include this in your program:
#
# PROGRAM=`basename $0 .sh`
# or
# PROGRAM=`basename $0 .bash`
#
# You can also (optional) include this:
#
# read -d '' USAGE << EOF
# Usage: ${PROGRAM} [options]
#
# Description of my program
#
# Options:
# - this one
# - or this one
#
# EOF
#

#####
## VARIABLES
###

BOLD="\033[1m"
RED_COLOR="\033[31m"
GREEN_COLOR="\033[32m"
BLUE_COLOR="\033[34m"
YELLOW_COLOR="\033[1;33m"

DEFAULT_COLOR="\033[0m"          # Reset color
INFO_COLOR="\033[7;49;34m"       # Blue background
SUCCESS_COLOR="\033[7;49;32m"    # Green background
WARNING_COLOR="\033[7;49;33m"    # Yellow/orange background
ERROR_COLOR="\033[7;49;31m"      # Red background
SPECIAL_COLOR="\033[1;49;34m"    # Bold blue writing with normal background

#####
## FUNCTIONS
###

# Messages with colors, like rainbows :-)
# Cf. https://misc.flogisoft.com/bash/tip_colors_and_formatting
colored_msg() {
  # 1: choosen color
  # 2: title
  # 3: message
  echo -e "${1}[${2}]${DEFAULT_COLOR} ${3}" 1>&2
}
# Default message
msg() {
  echo -e "${DEFAULT_COLOR}${1}" 1>&2
}
# Special message
special_msg() {
  echo -e "${SPECIAL_COLOR}${1}${DEFAULT_COLOR}" 1>&2
}
# Message of information, more visible
info_msg() {
  colored_msg "${INFO_COLOR}" "INFO" "${1}"
}
# Focus on important information
warning_msg() {
  colored_msg "${WARNING_COLOR}" "WARN" "${1}"
}
# Error ç_ç
error_msg() {
  colored_msg "${ERROR_COLOR}" "ERR " "${1}"
}
# Success !
success_msg() {
  colored_msg "${SUCCESS_COLOR}" " OK " "${1}"
}
# Fail, I'm out of the program!
err_msg_and_exit() {
  error_msg "${1}" && exit 1
}
# DEBUG messages for development periods
debug_msg() {
  if [[ ${DEBUG} == true ]]; then
    msg "$1"
  fi
}

# Contextual default help
usage() {
  if [[ -n "${USAGE}" ]]; then
    msg "${USAGE}"
  else
    msg "Usage: ${PROGRAM}"
    msg "\nWARNING: Options/Commands for this program not implemented yet!"
  fi
}

# Display contextual help before exiting program!
usage_and_exit() {
  usage
  exit 1
}

# Check program exist in system
# 1: name for exported variable which value is program path to use
# 2: program exact name
check_program_present() {
  message="'$2' command not found!"
  # prepare command to be executed
  # except for nvm that is a function
  if [[ "$2" == "nvm" ]]; then
    variable_value="$2"
  else
    variable_value=`which $2` || err_msg_and_exit "${message}"
  fi

  # check command availability
  if test -n $(command -v $2 &> /dev/null); then
    export $1="${variable_value}"
  else
    err_msg_and_exit "${message}"
  fi
}

# Execute script given in parameter 1. If this one exists.
# 1: to be executed script
# 2: (optional) pre-execution message
# 3: (optional) post-execution message
script_exec() {
  # If file doesn't exists: do nothing
  if [[ -f "${1}" ]]; then
    # pre-execution message
    if [[ -n "${2}" ]]; then
      info_msg "${2}"
    fi
    # execution
    source "${1}"
    # post-execution message
    if [[ -n "${3}" ]]; then
      info_msg "${3}"
    fi
  fi
}

# vim: ts=2 sw=2 et nu syn=bash
