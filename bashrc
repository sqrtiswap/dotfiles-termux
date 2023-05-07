#!/bin/bash

_good="\033[32m"
_fail="\033[31m"
_rset="\033[0m"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ss='cd ~/storage/shared/Sync/ && la'

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
