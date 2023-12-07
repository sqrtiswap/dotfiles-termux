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

git_branch() {
	if git rev-parse --git-dir > /dev/null 2>&1 && git rev-parse --abbrev-ref HEAD > /dev/null 2>&1 ; then
		printf " %s" "$(git rev-parse --abbrev-ref HEAD)"
	else
		printf ""
	fi
}

ahead_behind() {
	if git rev-parse --git-dir > /dev/null 2>&1 && git rev-parse --abbrev-ref HEAD > /dev/null 2>&1 ; then
		# get branch
		curr_branch=$(git rev-parse --abbrev-ref HEAD)
		# get corresponding remote branch
		curr_remote=$(git config branch.$curr_branch.remote)
		if [ -n "${curr_remote}" ] ; then
			# get branch the remote should be merged into
			curr_merge_branch=$(git config branch.$curr_branch.merge | cut -d / -f 3)
			# count and compare commits
			git rev-list --left-right --count $curr_branch...$curr_remote/$curr_merge_branch | tr -s '\t' '|'
		else
			printf ""
		fi
	fi
}

_shell=$(echo "$0" | awk '{ gsub("/data/data/com.termux/files", "", $0); print $0 }')
_exit_code="\[\033[0;\$((\$?==0?0:31))m\]\[[\${?}]"
if [[ "$TERM" =~ tmux ]] ; then
	_basics="$_XTERM_TITLE$_SH_COLOUR$_shell $_exit_code $_PS1_COLOUR\u $_PS1_BLUE\w$_PS1_CLEAR"
else
	_basics="$_XTERM_TITLE$_SH_COLOUR$_shell $_exit_code $_PS1_COLOUR\u@$_PS1_CLEAR\h $_PS1_BLUE\w$_PS1_CLEAR"
fi
_git_prompt="$_GIT_COLOUR\$(git_branch) \$(ahead_behind)"
_time="$_PS1_CLEAR\A"
_prompt="$_PS1_COLOUR\$$_PS1_CLEAR"
PS1="${_basics} ${_git_prompt}\n${_time} ${_prompt} "
PS2='> '

export PS1 PS2

export PATH=$PATH:~/bin
export MANPATH=$MANPATH:~/man

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
alias remt='rem -n -b1 | grep "$(date +%Y/%m/%d)" | sort'
alias backrem='remind -z -k"termux-notification -c '%s' -t Remind" ~/.reminders &'
# needs to be installed: 1. pkg install termux-api
#                        2. F-Droid Termux:API plugin

# EDITOR, PAGER
if command -v vis > /dev/null ; then
	VI=vis
	export VIS_PATH=$HOME/.config/vis
elif command -v nvim > /dev/null ; then
	VI='nvim'
else
	VI='vi'
fi
alias vise="$VI"
export EDITOR=$VI
export VISUAL=$VI
export FCEDIT=$EDITOR
export PAGER=less
export LESS='-iMRS -x2'

# WEATHER
alias wdetmold='curl https://wttr.in/detmold'
alias wberlin='curl https://wttr.in/berlin'

upgrade_termux() {
	pkg upgrade && apt autoremove && printf "${_good}Upgrade successful.${_rset}\n"
	printf "\nClose this session? [y/n] "
	IFS= read -r _close_session
	if [ "${_close_session}" = "y" ] ; then
		exit
	fi
}

alias upgrade=upgrade_termux

# PROJECTS
alias t=todo
export TODODIR="$HOME"/.todo
export TODO_COLOUR_A="\033[31m" # red
export TODO_COLOUR_B="\033[33m" # yellow
export TODO_COLOUR_C="\033[32m" # green
export TODO_COLOUR_D="\033[34m" # blue

export UNITODODIR="$HOME"/.todo_uni
alias ut='TODODIR=$UNITODODIR todo'
alias uticket='TODODIR=$UNITODODIR ticket'

export FISTTODODIR="$HOME"/.todo_fist
alias ft='TODODIR=$FISTTODODIR todo'
alias fticket='TODODIR=$FISTTODODIR ticket'

alias agenda=print_greeting

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
	perl -e 'print("=" x $ARGV[0], "\n" )' "$((${#_uptime}-${#_minus}-6))"
}

print_greeting() {
	[ $(remt | wc -l) -gt 0 ] \
		&& drawsep 'REMIND' \
		&& remt
	drawsep 'PRIVATE todo (t)'
	todo today
	drawsep 'UNIVERSITY todo (ut)'
	ut today
	drawsep 'F.I.S.T. todo (ft)'
	ft today
}

drawsep && uptime && print_greeting
