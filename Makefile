dotdir = $(shell pwd)

.DEFAULT_GOAL := all

all: install

install:
	ln -sf ${dotdir}/bashrc ~/.bashrc
	ln -sf ${dotdir}/reminders ~/.reminders
	ln -sf ~/storage/shared/Sync/todo ~/.todo

uninstall:
	rm -f ~/.bashrc
	rm -f ~/.reminders

.PHONY: all install uninstall
