.DEFAULT: welcome
.PHONY: init commit reset

GCA="\033[1mGit Commit Audio\033[0m"
GIT_CORE_TEMPLATE=$(shell git --exec-path)/../../share/git-core/templates
CONFIG_DIR=$(HOME)/.git-commit-audio
CONFIG_FILE=$(CONFIG_DIR)/config.sh
TEMPLATE_DIR=$(CONFIG_DIR)/templates

welcome:
	@echo $(GCA)
	@echo "\nCOMMANDS"
	@echo "  init    \tGlobal configuration"
	@echo "  commit  \tRegister the global hook"
	@echo "  reset   \tDe-register the global hook"

init:
	@mkdir -p $(CONFIG_DIR)
	@if [ ! -f $(CONFIG_FILE) ]; then \
		touch $(CONFIG_FILE); \
		echo 'export GIT_COMMIT_AUDIO="$(CONFIG_DIR)/audio.wav"' > $(CONFIG_FILE); \
	fi
	@cp audio.wav $(CONFIG_DIR)
	@cp -R $(GIT_CORE_TEMPLATE) $(CONFIG_DIR)
	@echo $(GCA) 'initialised in' $(CONFIG_DIR)

commit: init
	@cp post-commit $(TEMPLATE_DIR)'/hooks'
	@chmod +x $(TEMPLATE_DIR)'/hooks/post-commit'
	@git config --global init.templateDir $(TEMPLATE_DIR)
	@echo $(GCA) 'installed.'

reset:
	@git config --global --unset init.templateDir
	@echo $(GCA) 'uninstalled. Your configuration remains in' $(CONFIG_DIR)
