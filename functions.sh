#!/bin/bash

#-----------------------------------

#//Description: This script allows you to reuse functions in your scripts.
#//To use it, copy it to ~/.functions.sh and source it from your .bashrc/.zshrc.
#//Color variables are defined in ~/.colors.sh.

# Created: 2020-08-31T14:22:57-04:00
# Tristan M. Chase <tristan.m.chase@gmail.com>

# Depends on:
#  list
#  of
#  dependencies

#-----------------------------------

# Source colors
if [[ -e ~/.colors.sh ]]; then
	source ~/.colors.sh
fi

function __be_root__ {
# Test rootworthiness of user.
	test $( id -u )  -eq 0 || exec sudo $0 "$@"
}

function __find_trailing_whitespace__ {
# Find files with trailing whitespace (but not .pdf's or other binary files)
	if [[ -n "$(grep -r --files-with-matches --binary-files=without-match '\s$' 2>/dev/null "${_dir}"/*)" ]]; then
		printf "${WHT:-}${CYNB:-}%s\n" ">>>These files have trailing whitespace:"
		grep -r  --files-with-matches --binary-files=without-match '\s$' 2>/dev/null "${_dir}"/* | xargs realpath
		printf ""${reset:-}"%b\n"
	fi
}

function __debugger__ {
# Low-tech debug mode
if [[ "${1:-}" =~ (-d|--debug) ]]; then
	set -o verbose
	set -o xtrace
	_debug_file=""${HOME}"/script-logs/$(basename "${0}")/$(basename "${0}")-debug-$(date -Iseconds)"
	mkdir -p $(dirname ${_debug_file})
        touch ${_debug_file}
	exec > >(tee "${_debug_file:-}") 2>&1
	shift
fi
}

function __check_dependencies__

function __cleanup__ {
	case "$?" in
		0) # exit 0; success!
			#do nothing
			;;
		1) # exit 1; General error
			#do nothing
			;;
		2) # exit 2; Missing keyword or command, or permission problem
			__fatal__ "$(basename "${0}"): missing keyword or command, or permission problem."
			;;
		126) # exit 126; Cannot execute command (permission denied or not executable)
			#do nothing
			;;
		127) # exit 127; Command not found (problem with $PATH or typo)
			#do nothing
			;;
		128) # exit 128; Invalid argument to exit (integers from 0 - 255)
			#do nothing
			;;
		130) # exit 130; user termination
			__fatal__ ""$(basename $0).$$": script terminated by user."
			;;
		255) # exit 255; Exit status out of range (e.g. exit -1)
			#do nothing
			;;
		*) # any other exit number; indicates an error in the script
			#clean up stray files
			#__fatal__ ""$(basename $0).$$": [error message here]"
			;;
	esac

	# Move this up?
	if [[ -n "${_debug_file:-}" ]]; then
		echo "Debug file is: "${_debug_file:-}""
	fi
}


function __ctrl_c__ { exit 130 ; }

function __logger__ {
readonly LOG_FILE=""${HOME}"/script-logs/$(basename "${0}")/$(basename "${0}").log"
mkdir -p $(dirname ${LOG_FILE})
}
function __info__    { echo "$(date -Iseconds) [INFO]    $*" | tee -a "${LOG_FILE}" >&2 ; }
function __warning__ { echo "$(date -Iseconds) [WARNING] $*" | tee -a "${LOG_FILE}" >&2 ; }
function __error__   { echo "$(date -Iseconds) [ERROR]   $*" | tee -a "${LOG_FILE}" >&2 ; }
function __fatal__   { echo "$(date -Iseconds) [FATAL]   $*" | tee -a "${LOG_FILE}" >&2 ; exit 1 ; }

function __options__

function __trap_err__ {
	 "${FUNCNAME[1]}: ${BASH_COMMAND}: $?: ${BASH_SOURCE[1]}.$$ at line ${BASH_LINENO[0]}"
	 #__error__ "${FUNCNAME[1]}: ${BASH_COMMAND}: $?: ${BASH_SOURCE[1]}.$$ at line ${BASH_LINENO[0]}"
}


function __usage__ {
	# Low-tech help option. Begin any lines you want to include with "#//".
	grep '^#//' "${0}" | cut -c4- ; exit 0
  }
