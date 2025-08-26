.DEFAULT: welcome
.PHONY: install uninstall

GCA="\033[1mGit Audio\033[0m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-audio
CONFIG_FILE=$(CONFIG_DIR)/config.sh
TEMPLATE_DIR=$(CONFIG_DIR)/templates

welcome:
	@printf $(GCA)
	@printf "\n\nCOMMANDS\n"
	@printf "  install    \tInstall Git Audio\n"
	@printf "  uninstall  \tUninstall Git Audio\n"

init:
	@mkdir -p $(CONFIG_DIR)
	@if [ ! -f $(CONFIG_FILE) ]; then \
		touch $(CONFIG_FILE); \
		printf "export GIT_AUDIO=\"$(CONFIG_DIR)/audio.wav\"\n" > $(CONFIG_FILE); \
	fi
	@cp audio.wav $(CONFIG_DIR)
	@cp cli.sh $(CONFIG_DIR)
	@chmod +x $(CONFIG_DIR)/cli.sh
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@printf $(GCA)" configuration $(CONFIG_DIR)\n"

install: init
	@sudo ln -fs $(CONFIG_DIR)/cli.sh /usr/local/bin/git-audio
	@printf $(GCA)" CLI installed at /usr/local/bin/git-audio\n"
	@printf "You can now use 'git-audio' command in your terminal.\n"

uninstall:
	@sudo rm -rf /usr/local/bin/git-audio
	@printf $(GCA)" uninstalled. Your configuration remains in $(CONFIG_DIR)\n"
