.DEFAULT: welcome
.PHONY: install uninstall

GCA="\e[1mGit Audio\e[22m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-audio
CONFIG_FILE=$(CONFIG_DIR)/config.sh
TEMPLATE_DIR=$(CONFIG_DIR)/templates
CLI=$(CONFIG_DIR)/cli.sh
BIN_PATH=/usr/local/bin/git-audio

welcome:
	@printf $(GCA)
	@printf "\n\n\e[1mCOMMANDS\e[22m\n"
	@printf "  install    Install Git Audio\n"
	@printf "  uninstall  Uninstall Git Audio\n"

init:
	@mkdir -p $(CONFIG_DIR)
	@if [ ! -f $(CONFIG_FILE) ]; then \
		touch $(CONFIG_FILE); \
		printf "export GIT_AUDIO=\"$(CONFIG_DIR)/audio.wav\"\n" > $(CONFIG_FILE); \
	fi
	@cp audio.wav $(CONFIG_DIR)
	@cp cli.sh $(CONFIG_DIR)
	@chmod +x $(CLI)
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@printf $(GCA)" configuration created at $(CONFIG_DIR)\n"

install: init
	@printf "Installing "$(GCA)" CLI at "$(BIN_PATH)" using sudo privileges...\n"
	@sudo ln -fs $(CLI) $(BIN_PATH)
	@printf "You can now use the 'git-audio' command in your terminal.\n"

uninstall:
	@sudo rm -rf $(BIN_PATH)
	@printf $(GCA)" CLI uninstalled. Your configuration remains in $(CONFIG_DIR)\n"
