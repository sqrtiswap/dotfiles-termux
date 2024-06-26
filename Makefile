dotdir = $(shell pwd)
syncdir = ~/storage/shared/Sync

.DEFAULT_GOAL := install

install:
	@echo "==== Linking HOME ======================"
	@echo "---> bash(1) config"
	@ln -sf ${dotdir}/home/.bashrc ~/.bashrc
	@echo "---> git(1) config"
	@ln -sf ${dotdir}/home/.gitconfig ~/.gitconfig
	@echo "---> remind(1) data"
	@ln -sf ${syncdir}/remind ~/.config/remind
	@ln -sf ~/.config/remind/reminders.rem ~/.reminders
	@echo "---> todo(1) data"
	@ln -sf ${syncdir}/todo ~/.todo
	@ln -sf ${syncdir}/todo_uni ~/.todo_uni
	@ln -sf ${syncdir}/todo_work ~/.todo_work
	@ln -sf ${syncdir}/todo_fist ~/.todo_fist
	@echo "==== Linking tools in ~/bin ============"
	@mkdir -p ~/bin
	ln -sf ${dotdir}/bin/agenda ~/bin/agenda
	ln -sf ${dotdir}/bin/cleandirs ~/bin/cleandirs
	ln -sf ${dotdir}/bin/drawsep ~/bin/drawsep
	ln -sf ${dotdir}/bin/termuxupgrade ~/bin/termuxupgrade
	ln -sf ${dotdir}/bin/weather ~/bin/weather

uninstall:
	@echo "==== Removing links from HOME =========="
	@echo "---> bash(1) config"
	@rm -f ~/.bashrc
	@echo "---> git(1) config"
	@rm -f ~/.gitconfig
	@echo "---> remind(1) data"
	@rm -f ~/.reminders
	@rm -f ~/.config/remind
	@echo "---> todo(1) data"
	@rm -f ~/.todo
	@rm -f ~/.todo_uni
	@rm -f ~/.todo_work
	@rm -f ~/.todo_fist
	@echo "==== Removing tools from ~/bin ========="
	rm -f ~/bin/agenda
	rm -f ~/bin/cleandirs
	rm -f ~/bin/drawsep
	rm -f ~/bin/termuxupgrade
	rm -f ~/bin/weather

.PHONY: install uninstall
