# Prompt I want:
# [greenINS|redCMD][magentaSHLLVL]greenUSER@HOSTnone:bluePATH/TO/CWD blueGIT_STATUSnone\n\$
# PS1='${debian_chroot:+($debian_chroot)}'$EMM'[$TMUX_PANE/$TOPLVL/$SHLVL:$?]'$EMG'\u@\h'$NONE':'$EMB'\w$(__git_ps1 " (%s)")'$NONE'\n'$NONE' \$ '

PROMPT='%B%F{201}[${TMUX_PANE/#\%/%%}/$TOPLVL/$SHLVL:$?]%F{41}%n@%M%F{white}:%F{39}%~%F{87}$(__git_ps1 " (%s)")
${vim_mode}%f%b%# '

# I couldn't figure out how to add a newline with $'\n' so the prompt has an actual newline in it.
