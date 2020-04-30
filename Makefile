DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
#CANDIDATES := $(wildcard .??*) bin
DIRS       := $(shell find $(DOTPATH) -type d -name '???*' -printf "%P\n")
CANDIDATES := $(shell find $(DOTPATH) -type f \( -path '*/.??*' -o -path '*/bin/*' \) -printf "%P\n") 
EXCLUSIONS := .DS_Store .git% .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))
DOTDIRS    := $(filter-out $(EXCLUSIONS), $(DIRS))
GITHUB     := https://gitnub.com
APPIMAGES := nelsonenzo/tmux-appimage.tmux neovim/neovim.nvim

.DEFAULT_GOAL := help

.PHONY: all
all:

.PHONY: list
list: ## Show dot files in this repo
	@echo '==> dirs'
	@$(foreach val, $(DOTDIRS), /bin/ls -dF $(val);)
	@echo '==> files'
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

.PHONY: deploy
deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> create directories if not present.'
	@echo ''
	@$(foreach val, $(DOTDIRS), mkdir -p $(HOME)/$(val);)
	@echo '==> deploy dotfiles to home.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

.PHONY: init
init: ## intialize environment
	@echo '==> install appimages'
	@$(foreach val, $(APPIMAGES), \
	@curl -sL $(GITHUB)/$(patsubst .%,,$(val))/release/latest/$$(curl -sL $(GITHUB)/$(patsubst .%,,$(val))/releases/latest|grep -i "href.*\.appimage"|sed 's:.*/\(.*\.appimage\).*:\1:I') -o $(HOME)/bin/$(patsubst %.,,$(val)) \
	;)

.PHONY: clean
clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@-$(foreach val, $(DOTFILES), rm -vrf $(HOME)/$(val);)
	-rm -rf $(DOTPATH)

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
