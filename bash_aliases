## alias stuff

# Anchor your top-level shell
alias anchor='export TOPLVL=$SHLVL; PS1=$ANCHOR"$PS1"'

# Make alias output a little more readable
alias aka='alias | less -M'
alias graka='grep -n "^#*alias" ~/dotfiles/* | vim -'

# List the files in the current directory with filetype and source of symlinks
alias ft='ftx .* * | more' #ftx is a script in ~/bin

# Make env output a little more readable
alias env='env | sort | less -M'

# Make path easier to visualize
alias path='echo PATH=$PATH | more'

# Stupid command line tricks
alias :q='exit'
alias x='exit'
alias Q='exit'
alias ra='ranger'

# Prepend sudo to last command
alias please='sudo $(fc -ln -1)'
alias fuck='sudo $(fc -ln -1)'

## Solve conflict between zsh changing to ~/gtd and running ~/bin/gtd
#alias gtd='~/bin/gtd'

# byobu (tmux) window splits
alias vsplit='tmux split -h'
alias vsp='tmux split -h'
alias hsplit='tmux split -v'
alias hsp='tmux split -v'

## dropbox
#alias dbgo='dropbox start'
#alias dbfs='dropbox filestatus'
#alias dbst='dropbox status'
#alias dbls='dropbox ls'
#alias db='dropbox'

# git
alias gtree='git log --graph --abbrev-commit --decorate --date=relative --format=format:'\''%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)'\'' --all'

alias gst='git status'
alias ga='ws || (echo "--None--" && git add)' # Check files for trailing whitespace first
alias gaa='ws || (echo "--None--" && git add --all)' # Check files for trailing whitespace first
alias gc='git commit -v'
alias gp='git push'

# Edit and source ~/.bashrc
alias bb='vim ~/.bashrc'
alias so='source ~/.bashrc'

# Get last exit code
alias err="echo $?"

# Check files for trailing whitespace
alias ga='wsg || (echo "--None--" && git add)'
alias gaa='wsg || (echo "--None--" && git add --all)'
alias wsg='echo "The following files contain trailing whitespace: " && grep -n '\''\s$'\'' * '
alias ws='echo "The following files contain trailing whitespace: " && grep -n '\''\s$'\'' * || echo "--None--" '
