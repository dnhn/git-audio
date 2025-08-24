.DEFAULT: welcome
.PHONY: install uninstall

GCA="\033[1mGit Commit Audio\033[0m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-commit-audio
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
	@cp gca.sh $(CONFIG_DIR)
	@chmod +x $(CONFIG_DIR)/gca.sh
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@echo $(GCA) 'initialised in' $(CONFIG_DIR)

install: init
	@echo 'Installing' $(GCA)
	@sudo ln -fis $(CONFIG_DIR)/gca.sh /usr/local/bin/git-audio
	@echo $(GCA) 'installed at /usr/local/bin/git-audio'
	@echo "You can now use 'git-audio' command in your terminal."

uninstall:
	@echo 'Uninstalling' $(GCA)
	@sudo rm -rf /usr/local/bin/git-audio
	@echo $(GCA) 'uninstalled. Your configuration remains in' $(CONFIG_DIR)
