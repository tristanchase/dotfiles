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

# Source helper files
if [[ -e ~/.colors.sh ]]; then
	source ~/.colors.sh
fi

if [[ -e ~/.git-prompt.sh ]]; then
	source ~/.git-prompt.sh
fi

function __be_root__ {
# Test rootworthiness of user. Be wary. Check this.
	test $( id -u )  -eq 0 || exec sudo $0 "$@"
}

#function __check_dependencies__

function __cleanup__ {
	if [[ -n "${_tempfiles:-}" ]]; then
		rm "$(printf "%b\n" "${_tempfiles:-}")"
	fi

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

	#__local_cleanup__

	if [[ -n "${_debug_file:-}" ]]; then
		echo "Debug file is: "${_debug_file:-}""
	fi

}


function __ctrl_c__ {
	printf "%b\n"
	__fatal__ ""$(basename $0).$$": script terminated by user."
	exit 130
}

function __debugger__ {
# Low-tech debug mode
	set -o verbose
	set -o xtrace
	_debug_file=""${HOME}"/script-logs/$(basename "${0}")/$(basename "${0}")-$(date -Iseconds).debug.$$"
	mkdir -p $(dirname ${_debug_file})
        touch ${_debug_file}
	exec > >(tee "${_debug_file:-}") 2>&1
	shift
}

function __find_trailing_whitespace__ {
	# Find files with trailing whitespace (but not .pdf's or other binary files)
	_dir="$(pwd)"
	# Add -r to grep for recursive search
	_whitespace=( "$(grep --files-with-matches --binary-files=without-match '\s$' 2>/dev/null "${_dir}"/*)" )
	if [[ -n "${_whitespace[@]}" ]]; then
		printf "${black_fg:-}${light_green_bg:-}%s\n" ">>>These files have trailing whitespace:"
		printf "%b\n" "${_whitespace[@]}" | xargs realpath
		printf ""${reset:-}"%b\n"
	fi
}
function __git_ps1__ {
	source ~/.git-prompt.sh
	__git_ps1 2>/dev/null
}


function __git_prompt__ {
	if [[ "$(printf "%b\n" "$(__git_ps1__)" | grep '[\*\+%<>\$]')" ]]; then
		_git_prompt_color="${bold_orange}"
	else
		_git_prompt_color="${BCYN}"
	fi

	printf ""${_git_prompt_color:-}"%s"${reset:-}"" "$(__git_ps1__)"
}

function __globstar__ {
	# Only set this if your $SHELL is bash
	if [[ $SHELL =~ (bash) ]]; then
		shopt -s globstar
	fi
}

function __it_works__ {
	printf ""${orange_bold}"%s\n"${reset_colors}"" "It works!"
}

function __logger__ {
	readonly LOG_FILE=""${HOME}"/script-logs/$(basename "${0}")/$(basename "${0}").log"
	mkdir -p $(dirname ${LOG_FILE})
}
function __info__    { __logger__; echo "$(date -Iseconds) [INFO]    $*" | tee -a "${LOG_FILE}" >&2 ; }
function __warning__ { __logger__; echo "$(date -Iseconds) [WARNING] $*" | tee -a "${LOG_FILE}" >&2 ; }
function __error__   { __logger__; echo "$(date -Iseconds) [ERROR]   $*" | tee -a "${LOG_FILE}" >&2 ; }
function __fatal__   { __logger__; echo "$(date -Iseconds) [FATAL]   $*" | tee -a "${LOG_FILE}" >&2 ; }

#function __options__

function __traperr__ {
	 "${FUNCNAME[1]}:: ${BASH_COMMAND}:: $?:: ${BASH_SOURCE[1]}.$$ at line ${BASH_LINENO[0]}"
}


function __usage__ {
	# Low-tech help option. Begin any lines you want to include with "#//".
	grep '^#//' "${0}" | cut -c4- ; exit 0
  }

function __usage_section__ {

	cat >> ${_newfile} << EOF
#!/usr/bin/env bash

#-----------------------------------
# Usage Section

#<usage>
#//Usage: ${_name} [ {-d|--debug} ] [ {-h|--help} | <options>] [<arguments>]
#//Description: ${_description}
#//Examples: ${_name} foo; ${_name} --debug bar
#//Options:
#//	-d --debug	Enable debug mode
#//	-h --help	Display this help message
#</usage>

#<created>
# Created: $(date -Iseconds)
# Tristan M. Chase <tristan.m.chase@gmail.com>
#</created>

#<depends>
# Depends on:
#  list
#  of
#  dependencies
#</depends>

EOF
}
