.DEFAULT: welcome
.PHONY: install uninstall

GCA="\033[1mGit Audio\033[0m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-audio
CONFIG_FILE=$(CONFIG_DIR)/config.sh
TEMPLATE_DIR=$(CONFIG_DIR)/templates

welcome:
	@echo $(GCA)
	@echo "\nCOMMANDS"
	@echo "  install    \tInstall Git Audio"
	@echo "  uninstall  \tUninstall Git Audio"

init:
	@mkdir -p $(CONFIG_DIR)
	@if [ ! -f $(CONFIG_FILE) ]; then \
		touch $(CONFIG_FILE); \
		echo 'export GIT_COMMIT_AUDIO="$(CONFIG_DIR)/audio.wav"' > $(CONFIG_FILE); \
	fi
	@cp audio.wav $(CONFIG_DIR)
	@cp cli.sh $(CONFIG_DIR)
	@chmod +x $(CONFIG_DIR)/cli.sh
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@echo $(GCA) 'configuration' $(CONFIG_DIR)

install: init
	@sudo ln -fs $(CONFIG_DIR)/cli.sh /usr/local/bin/git-audio
	@echo $(GCA) 'CLI installed at /usr/local/bin/git-audio'
	@echo "You can now use 'git-audio' command in your terminal."

uninstall:
	@sudo rm -rf /usr/local/bin/git-audio
	@echo $(GCA) 'uninstalled. Your configuration remains in' $(CONFIG_DIR)
