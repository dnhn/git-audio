.DEFAULT: welcome
.PHONY: install uninstall

GCA="\e[1mGit Audio\e[22m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-audio
CONFIG_FILE=$(CONFIG_DIR)/config.sh
TEMPLATE_DIR=$(CONFIG_DIR)/templates

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
	@chmod +x $(CONFIG_DIR)/cli.sh
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@printf $(GCA)" configuration created at $(CONFIG_DIR)\n"

install: init
	@sudo ln -fs $(CONFIG_DIR)/cli.sh /usr/local/bin/git-audio
	@printf $(GCA)" CLI installed at /usr/local/bin/git-audio\n"
	@printf "You can now use the 'git-audio' command in your terminal.\n"

uninstall:
	@sudo rm -rf /usr/local/bin/git-audio
	@printf $(GCA)" CLI uninstalled. Your configuration remains in $(CONFIG_DIR)\n"
