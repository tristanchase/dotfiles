# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return
# History
# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
# EndHistory

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# Functions

if [[ -e ~/.functions.sh ]]; then
	source ~/.functions.sh
fi

# EndFunctions

# Colors

if [[ -e ~/.colors.sh ]]; then
	source ~/.colors.sh
fi


COLOR_DEFAULT="\[\033[0m\]"    # unsets color to term's fg color

# regular colors
COLOR_NORMAL_BLACK="\[\033[0;30m\]"
COLOR_NORMAL_RED="\[\033[0;31m\]"
COLOR_NORMAL_GREEN="\[\033[0;32m\]"
COLOR_NORMAL_YELLOW="\[\033[0;33m\]"
COLOR_NORMAL_BLUE="\[\033[0;34m\]"
COLOR_NORMAL_MAGENTA="\[\033[0;35m\]"
COLOR_NORMAL_CYAN="\[\033[0;36m\]"
COLOR_NORMAL_WHITE="\[\033[0;37m\]"

# empahsized (bolded) colors
COLOR_BOLD_BLACK="\[\033[1;30m\]"
COLOR_BOLD_RED="\[\033[1;31m\]"
COLOR_BOLD_GREEN="\[\033[1;32m\]"
COLOR_BOLD_YELLOW="\[\033[1;33m\]"
COLOR_BOLD_BLUE="\[\033[1;34m\]"
COLOR_BOLD_MAGENTA="\[\033[1;35m\]"
COLOR_BOLD_CYAN="\[\033[1;36m\]"
COLOR_BOLD_WHITE="\[\033[1;37m\]"

# background colors
COLOR_BACKGROUND_BLACK="\[\033[40m\]"
COLOR_BACKGROUND_RED="\[\033[41m\]"
COLOR_BACKGROUND_GREEN="\[\033[42m\]"
COLOR_BACKGROUND_YELLOW="\[\033[43m\]"
COLOR_BACKGROUND_BLUE="\[\033[44m\]"
COLOR_BACKGROUND_MAGENTA="\[\033[45m\]"
COLOR_BACKGROUND_CYAN="\[\033[46m\]"
COLOR_BACKGROUND_WHITE="\[\033[47m\]"
# EndColors

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# Git prompt tricks

if [[ -e ~/.git-prompt.sh ]]; then
	source ~/.git-prompt.sh
	export GIT_PS1_SHOWDIRTYSTATE=true      # staged '+', unstaged '*'
	export GIT_PS1_SHOWUNTRACKEDFILES=true  # '%' untracked files
	export GIT_PS1_SHOWUPSTREAM="auto"      # '<' behind, '>' ahead, '<>' diverged, '=' no difference
	export GIT_PS1_SHOWSTASHSTATE=true      # '$' something is stashed
	export GIT_PS1_SHOWCOLORHINTS=true
fi

# $SHLVL prompt tricks
#TOPLVL=
ANCHOR=$(echo -e "\xE2\x9A\x93")

# Add ↻ to prompt if system needs to restart
function __reboot_required__ {
	_reboot_req_file="${HOME}/.reboot-required.icon"
	if [[ -f /var/run/reboot-required ]]; then
		echo -e "\xe2\x86\xbb" > "${_reboot_req_file}"
	else
		echo "" > "${_reboot_req_file}"
	fi
	cat "${_reboot_req_file}"
}

# Prompt
if [ "$color_prompt" = yes ]; then
	PS1='${debian_chroot:+($debian_chroot)}'$bold_red'$(__reboot_required__)'$bold_magenta'[$TMUX_PANE/$TOPLVL/$SHLVL:$?]'$bold_green'\u@\h'$reset':'$bold_blue'\w'$bold_cyan'$(__git_prompt__)'$reset'\n'$COLOR_DEFAULT'\$ '
	#PS1='${debian_chroot:+($debian_chroot)}'$COLOR_BOLD_MAGENTA'[$TMUX_PANE/$TOPLVL/$SHLVL:$?]'$COLOR_BOLD_GREEN'\u@\h'$COLOR_DEFAULT':'$COLOR_BOLD_BLUE'\w'$COLOR_BOLD_CYAN'$(__git_ps1 " (%s)")'$COLOR_DEFAULT'\n'$COLOR_DEFAULT'\$ '
	#PS1='${debian_chroot:+($debian_chroot)}'$bold_magenta'[$TMUX_PANE/$TOPLVL/$SHLVL:$?]'$bold_green'\u@\h'$reset':'$bold_blue'\w'$bold_cyan'$(__git_prompt__)'$reset'\n'$COLOR_DEFAULT'\$ '
else
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1 " (%s)")\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac
# EndPrompt

# Alias
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias lf='ls -Fa'
alias ll='ls --color=always -alF | less -RF'
alias la='ls --color=always -A | less -RF'
alias l='ls --color=always -CF | less -RF'
alias lh='ls --color=always -lasth | less -RF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# EndAlias

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Use vi keybindings
set -o vi
bind '"jk":vi-movement-mode'
bind 'set show-mode-in-prompt on'

# Path modifications
#PATH=$PATH:"$HOME/todo.txt-cli/"

# Disables Ctrl-S flow control (which stops the terminal)
#stty -ixon
stty ixany # Lets any key resume

# Allow bash to expand subdirectories and files using '**'
shopt -s globstar

# ssh-agent stuff
# Dynamically find known keys in ~/.ssh and activate them
_keylist=( "$(printf "%b\n" ~/.ssh/* | grep -Ev 'pub|config|known_hosts' | xargs basename -a)" )
for _key in $_keylist; do
	if [[ -f ~/.ssh/$_key ]]; then
		eval $(keychain --eval $_key)
	fi
done
