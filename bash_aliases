## alias stuff

# List the files in the current directory with filetype and source of symlinks
 alias ft='ftx .* * | more' #ftx is a script in ~/bin

# Make env output a little more readable
alias env='env | sort | less -M'

# Make path easier to visualize
alias path='echo PATH=$PATH | more'

# Make alias output a little more readable
alias aka='alias | less -M'

# Stupid command line tricks
alias :q='exit'
alias x='exit'
alias ra='ranger'

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
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit'
alias gp='git push'

# Edit and source ~/.bashrc
alias bb='vim ~/.bashrc'
alias so='source ~/.bashrc'
