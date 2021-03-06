SHELL      = /bin/bash
F_CAND     := .??*/ .local/*/ .??*/* .local/*/* .dircolors
F_DIRS     := %/ .local/%/
F_EXCL     := .DS_Store .git% .gitmodules .travis.yml .dircolors/% .local/ .local/bin .local/share .local/appimages%
DOTPATH    = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES = $(filter-out $(F_EXCL), $(wildcard $(F_CAND)))
CAND_DIRS  = $(filter $(F_DIRS), $(CANDIDATES))
CAND_LINKS = $(filter-out $(F_DIRS), $(CANDIDATES))
GITHUB     := https://github.com
APPIMAGES := neovim/neovim.nvim
ALT_APPIMAGES := $(shell curl -sL https://api.github.com/repos/z80oolong/tmux-eaw-appimage/releases/latest | jq -r '.assets[].browser_download_url|select(test("3.1b"))'|tail -n 1)^tmux
TERMINFO_DIRS := /lib/terminfo /etc/terminfo /usr/share/terminfo
dot-split = $(word $2,$(subst ., ,$1))
hat-split = $(word $2,$(subst ^, ,$1))
appimage-subpath = $(shell curl -sL $(GITHUB)/$(call dot-split,$1,1)/releases/latest|grep -i "href.*$(call dot-split,$1,2).*\.appimage\""|grep -v -i -e "-rc-" -v -e "HEAD"|sort|tail -n 1|sed 's:.*/\(.*/.*\.appimage\).*:\1:I') 

.DEFAULT_GOAL := help

.PHONY: all
all:

test:
	@$(eval ppath := $(abspath $(shell find .local/share -type f -wholename '*pypy2*bin/pypy'|sort|tail -n 1)))
	@echo 'export PATH=$(dir $(ppath)):$$PATH' >> ~/test

show: ## show deploy candidates
	@echo "directories ==> $(CAND_DIRS)"
	@echo "symlinks ==> $(CAND_LINKS)"

.PHONY: init
init: ## intialize environment
	@echo '==> install appimages from github'
	@echo ''
	@$(foreach val, $(APPIMAGES),\
		echo '==> install $(call dot-split,$(val),1)'; \
		echo '==> appimage is $(call appimage-subpath,$(val))'; \
		curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/download/$(call appimage-subpath,$(val)) -o .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		chmod +x .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		ln -fn $(abspath .local/appimages/$(notdir $(call appimage-subpath,$(val)))) .local/bin/$(call dot-split,$(val),2) ||\
		: ;)
	@echo '==> install appimages from alternative sources'
	@echo ''
	@$(foreach val, $(ALT_APPIMAGES),\
		echo '==> install $(call hat-split,$(val),1)'; \
		curl -sL $(call hat-split,$(val),1) -o .local/appimages/$(notdir $(call hat-split,$(val),1)) &&\
		chmod +x .local/appimages/$(notdir $(call hat-split,$(val),1)) &&\
		ln -fn $(abspath .local/appimages/$(notdir $(call hat-split,$(val),1))) .local/bin/$(call hat-split,$(val),2) ||\
		: ;)
	@echo '==> install pypy'
	@echo ''
	@curl -sL $$(curl -s https://www.pypy.org/download.html|grep "href=.*pypy3\..*linux64"|sed 's/.*href=\"\(.*\)\">.*/\1/')|tar -xjf - -C .local/share
	@curl -sL $$(curl -s https://www.pypy.org/download.html|grep "href=.*pypy2\..*linux64"|sed 's/.*href=\"\(.*\)\">.*/\1/')|tar -xjf - -C .local/share
	@$(eval ppath := $(abspath $(shell find .local/share -type f -wholename '*pypy2*bin/pypy'|sort|tail -n 1)))
	@ln -sf $(ppath) .local/bin/python2
	@fish -c "contains /home/hsaeki/.local/hoge $$fish_user_paths || set --universal --prepend fish_user_paths $(dir $(ppath)); :"
	@[ -e .profile ] && grep 'export PATH=$(dir $(ppath))' .profile || (echo 'export PATH=$(dir $(ppath)):$$PATH' >> .profile)
	@$(eval ppath := $(abspath $(shell find .local/share -type f -wholename '*pypy3*bin/pypy3'|sort|tail -n 1)))
	@ln -sf $(ppath) .local/bin/python3
	@ln -sf $(ppath) .local/bin/python
	@fish -c "contains /home/hsaeki/.local/hoge $$fish_user_paths || set --universal --prepend fish_user_paths $(dir $(ppath)); :"
	@[ -e .profile ] && grep 'export PATH=$(dir $(ppath))' .profile || (echo 'export PATH=$(dir $(ppath)):$$PATH' >> .profile)
	@[ -e .profile ] && source .profile
	@echo '==> clone dircolors'
	@echo ''
	@test ! -d .dircolors && mkdir -p .dircolors && curl -sL https://github.com/seebi/dircolors-solarized/archive/master.tar.gz| tar -xzf - -C .dircolors --strip-component=1 --exclude='img' || : ;

.PHONY: deploy
deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> create directories.'
	@echo ''
	@$(foreach val, $(CAND_DIRS), [ -L $${HOME}/$(val:/=) ] && unlink $${HOME}/$(val:/=) || : ;)
	@mkdir -p $(patsubst %,$${HOME}/%,$(CAND_DIRS))
	@echo '==> deploy dotfiles to home.'
	@echo ''
	@$(foreach val, $(CAND_LINKS), [ -d $${HOME}/$(val) ] && rm -rf $${HOME}/$(val) || [ ! -L $${HOME}/$(val) ] || unlink $${HOME}/$(val); ln -sfT $(abspath $(val)) $${HOME}/$(val);)
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
