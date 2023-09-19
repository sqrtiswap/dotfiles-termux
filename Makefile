dotdir = $(shell pwd)

.DEFAULT_GOAL := all

all: install

install:
	ln -sf ${dotdir}/bashrc ~/.bashrc
	ln -sf ${dotdir}/reminders ~/.reminders
	ln -sf ~/storage/shared/Sync/todo ~/.todo
	ln -sf ~/storage/shared/Sync/todo_uni ~/.todo_uni

uninstall:
	rm -f ~/.bashrc
	rm -f ~/.reminders
	rm -f ~/.todo
	rm -f ~/.todo_uni

.PHONY: all install uninstall
