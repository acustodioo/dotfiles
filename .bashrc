# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# put ~/bin on PATH if you have it
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

# rvm use
RVM_PATH="$HOME/.rvm/scripts/rvm"
function rvm_ps1() {
    RVMP=`rvm-prompt i v`
    [[ $RVMP != '' ]] && echo ' ('$RVMP')'
}

# Bash customisations to be syncronised between machines.
PS1='\[\e[1;1m\]\u@\h\[\e[1;31m\]'
PS1+=' \a$PWD\[\e[0m\]'
[[ -s $RVM_PATH ]] && source $RVM_PATH && PS1+='`rvm_ps1`'
[[ __git_ps1 ]] && PS1+='\a$(__git_ps1 " [%s]")'
PS1+='\n\$\[\e[0m\] '

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append history to ~\.bash_history when exiting shell
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

export EDITOR="vim"

# for tmux: export 256color
export TERM=xterm-256color

# Alias definitions.
[[ -f ~/.bash/aliases ]] && source ~/.bash/aliases

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
[[ -f /etc/bash_completion ]] && ! shopt -oq posix && source /etc/bash_completion

# Autocomplete
[[ -r $rvm_path/scripts/completion ]] && source $rvm_path/scripts/completion
[[ -r ~/.bash/completion/rails/rails.bash ]] && source ~/.bash/completion/rails/rails.bash

# Fuzzy cd
# Usage:
# cdf public
function cdf() {
    p=$(echo $* | tr "/" "\n")

    if [ $(echo $1 | cut -b 1) == "/" ]; then
        cd /*$(echo $p | cut -d " " -f 1)*/
        p=$(echo $p | cut -d " " -f 2-)
    fi

    for f in $p; do
        cd *$f*/
    done
}

# vim:et:sw=4:ts=4
