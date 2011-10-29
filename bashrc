# If not running interactively, don't do anything
[ -z "$PS1" ] && return

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
[[ -s '/usr/bin/git' ]] && PS1+='\a$(__git_ps1 " [%s]")'
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

# put ~/bin on PATH if you have it
test -d "$HOME/bin" && PATH="$HOME/bin:$PATH"

# disk usage with human sizes and minimal depth
alias du1='du -h --max-depth=1'
alias fn='find . -name'
alias hi='history | tail -20'

# notify of bg job completion immediately
set -o notify

# .. => cd ..
# .. 2 => cd .. && cd ..
function ..() {
    if [ "$1" == "" ]; then
        cd ..
    else
        for ((i=1; i <= $1; i++)); do
            cd ..
        done
    fi
}

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
