dotdir = $(shell pwd)
syncdir = ~/storage/shared/Sync

.DEFAULT_GOAL := all

all: install

install:
	ln -sf ${dotdir}/home/.bashrc ~/.bashrc
	ln -sf ${dotdir}/home/.gitconfig ~/.gitconfig
	ln -sf ${syncdir}/remind ~/.config/remind
	ln -sf ~/.config/remind/reminders.rem ~/.reminders
	ln -sf ${syncdir}/todo ~/.todo
	ln -sf ${syncdir}/todo_fist ~/.todo_fist
	ln -sf ${syncdir}/todo_uni ~/.todo_uni

uninstall:
	rm -f ~/.bashrc
	rm -f ~/.gitconfig
	rm -f ~/.reminders
	rm -f ~/.config/remind
	rm -f ~/.todo
	rm -f ~/.todo_fist
	rm -f ~/.todo_uni

.PHONY: all install uninstall
