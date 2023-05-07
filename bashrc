#!/bin/bash

_good="\033[32m"
_fail="\033[31m"
_rset="\033[0m"

# PROMPT

_XTERM_TITLE='\[\033]0;\u@\h:\w\007\]'
_PS1_CLEAR='\[\033[0m\]'   # reset
_PS1_BLUE='\[\033[34m\]'   # blue
_PS1_RED='\[\033[1;31m\]'  # red
_PS1_GREEN='\[\033[32m\]'  # green
_SH_COLOUR='\[\033[33m\]'  # yellow
_GIT_COLOUR='\[\033[95m\]' # magenta
case "$(id -u)" in
	0) _PS1_COLOUR=$_PS1_RED ;;
	*) _PS1_COLOUR=$_PS1_GREEN ;;
esac

_shell=$(echo "$0" | awk '{ gsub("/data/data/com.termux/files", "", $0); print $0 }')
_exit_code="\[\033[0;\$((\$?==0?0:31))m\]\[[\${?}]"
if [[ "$TERM" =~ tmux ]] ; then
	_basics="$_XTERM_TITLE$_SH_COLOUR$_shell $_exit_code $_PS1_COLOUR\u $_PS1_BLUE\w$_PS1_CLEAR"
else
	_basics="$_XTERM_TITLE$_SH_COLOUR$_shell $_exit_code $_PS1_COLOUR\u@$_PS1_CLEAR\h $_PS1_BLUE\w$_PS1_CLEAR"
fi
_time="$_PS1_CLEAR\A"
_prompt="$_PS1_COLOUR\$$_PS1_CLEAR"
PS1="${_basics} \n${_time} ${_prompt} "
PS2='> '

export PS1 PS2

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ss='cd ~/storage/shared/Sync/ && la'
alias sd=ss

alias ls='ls -FHh'
alias ll='ls -l'
alias la='ls -lA'

alias df='df -h'
alias du='du -ch'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -v'
alias cal='cal -mwy'

alias remind='remind -m -b1'
alias w2rem='remind -cu+2 ~/.reminders'
alias m2rem='remind -cu2 ~/.reminders'
alias remt='rem -n -b1 | grep "$(date +%Y/%m/%d)"'
alias backrem='remind -z -k"termux-notification -title Remind" ~/.reminders &'

alias vise=vis
export VIS_PATH=$HOME/.config/vis

alias wdetmold='curl https://wttr.in/detmold'
alias wberlin='curl https://wttr.in/berlin'

upgrade_termux() {
	pkg upgrade && apt autoremove && printf "%s" "${_good}Upgrade successful.${_rset}\n"
	printf "\nClose this session? [y/n] "
	IFS= read -r _close_session
	if [ "${_close_session}" = "y" ] ; then
		exit
	fi
}

alias upgrade=upgrade_termux

# AUTOSTART

pidof -q remind || backrem

# TERMINAL GREETING

_uptime=$(uptime)

drawsep() {
	if [ -z "$1" ] ; then
		_minus=''
		printf "======"
	else
		_minus="$1"
		printf "==== %s " "${_minus}"
	fi
	if command -v jot > /dev/null ; then
		printf "=%.0s" $(jot $((${#_uptime}-${#_minus}-6))) ; printf '\n'
	else
		perl -e 'print("=" x $ARGV[0], "\n" )' "$((${#_uptime}-${#_minus}-6))"
	fi
}

drawsep && uptime

[ "$(remt | wc -l)" -gt 0 ] \
	&& drawsep 'REMIND' \
	&& remt
