SHELL      = /bin/bash
F_CAND     := .??*/ ??*/* .local/*/ .local/*/* .config/*/ .config/*/* .config/dein.vim
F_DIRS     := .vim/ .dircolors/ .local/ .local/%/ .config/ .config/fish/ .config/nvim/ 
F_EXCL     := .DS_Store .git% .gitmodules .travis.yml .local/appimages% .config/dein.vim/%
DOTPATH    = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES = $(filter-out $(F_EXCL), $(wildcard $(F_CAND)))
CAND_DIRS  = $(filter $(F_DIRS), $(CANDIDATES))
CAND_LINKS = $(filter-out $(F_DIRS), $(CANDIDATES))
GITHUB     := https://github.com
APPIMAGES := neovim/neovim.nvim
TERMINFO_DIRS := /lib/terminfo /etc/terminfo /usr/share/terminfo
dot-split = $(word $2,$(subst ., ,$1))
hat-split = $(word $2,$(subst ^, ,$1))
appimage-subpath = $(shell curl -sL $(GITHUB)/$(call dot-split,$1,1)/releases/latest|grep -i "href.*$(call dot-split,$1,2).*\.appimage\""|grep -v -i -e "-rc-" -v -e "HEAD"|sort|tail -n 1|sed 's:.*/\(.*/.*\.appimage\).*:\1:I') 

.DEFAULT_GOAL := help

.PHONY: all
all:

test:
	@echo "cand ==> $(wildcard $(F_CAND))"
	@echo "excled cand ==> $(CANDIDATES)"

show: ## show deploy candidates
	@echo "directories ==> $(CAND_DIRS)"
	@echo "symlinks ==> $(CAND_LINKS)"

.PHONY: init
init: ## intialize environment
	@echo '==> install miniconda'
	@echo ''
	@curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ./miniconda.sh
	@bash ./miniconda.sh -b -f -p $(HOME)/miniconda
	@_CONDA_PATH=$(HOME)/miniconda/etc/profile.d/conda.sh ./conda_bashrc.sh
	@echo '==> install appimages from github'
	@echo ''
	@$(foreach val, $(APPIMAGES),\
		echo '==> install $(call dot-split,$(val),1)'; \
		echo '==> appimage is $(call appimage-subpath,$(val))'; \
		curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/download/$(call appimage-subpath,$(val)) -o .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		chmod +x .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		ln -fn $(abspath .local/appimages/$(notdir $(call appimage-subpath,$(val)))) .local/bin/$(call dot-split,$(val),2) ||\
		: ;)

.PHONY: deploy
deploy: ## ensure directories and create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> create directories.'
	@echo ''
	@$(foreach val, $(CAND_DIRS), [ -L $(HOME)/$(val:/=) ] && unlink $(HOME)/$(val:/=) || : ;)
	@mkdir -p $(patsubst %,$${HOME}/%,$(CAND_DIRS))
	@echo '==> deploy dotfiles to home.'
	@echo ''
	@$(foreach val, $(CAND_LINKS), [ -d $(HOME)/$(val) ] && rm -rf $(HOME)/$(val) || [ ! -L $(HOME)/$(val) ] || unlink $(HOME)/$(val); ln -sfT $(abspath $(val)) $(HOME)/$(val);)
	@echo '==> execute post deployment script'
	@echo ''
	@./post_deploy.sh

.PHONY: clean
clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@$(foreach val, $(CAND_LINKS), rm -vrf $(HOME)/$(val);)
	@rm -rf $(DOTPATH)

.PHONY: help
help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

