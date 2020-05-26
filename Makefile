F_CAND     := .??*/ .local/*/ .??*/* .local/*/*
F_DIRS     := %/ .local/%/
F_EXCL     := .DS_Store .git% .gitmodules .travis.yml .local/
DOTPATH    = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES = $(filter-out $(F_EXCL), $(wildcard $(F_CAND)))
CAND_DIRS  = $(filter $(F_DIRS), $(CANDIDATES))
CAND_LINKS = $(filter-out $(F_DIRS), $(CANDIDATES))
GITHUB     := https://github.com
APPIMAGES := z80oolong/tmux-eaw-appimage.tmux neovim/neovim.nvim
TERMINFO_DIRS := /lib/terminfo /etc/terminfo /usr/share/terminfo
dot-split = $(word $2,$(subst ., ,$1))

.PHONY: all
all:

show: ## show deploy candidates
	@echo "directories ==> $(CAND_DIRS)"
	@echo "symlinks ==> $(CAND_LINKS)"

.PHONY: init
init: ## intialize environment
	@echo '==> install appimages from github'
	@echo ''
	@$(foreach val, $(APPIMAGES),\
		echo '==> install $(call dot-split,$(val),1)'; \
		target=$$(curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/latest|grep -i "href.*\.appimage\""|sort|tail -n 1|sed 's:.*/\(.*/.*\.appimage\).*:\1:I') &&\
		echo $$target; \
		curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/download/$$target -o .local/appimages/$$(basename $$target) &&\
		chmod +x .local/appimages/$$(basename $$target) &&\
		ln -sfn ../appimages/$$(basename $$target) .local/bin/$(call dot-split,$(val),2) ||\
		: ;)
	@echo '==> clone dircolors'
	@echo ''
	@test ! -d .dircolors && mkdir -p .dircolors && curl -sL https://github.com/seebi/dircolors-solarized/archive/master.tar.gz| tar -xzf - -C .dircolors --strip-component=1 --exclude='img' || : ;

.PHONY: deploy
deploy: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> create directories if not present.'
	@echo ''
	@mkdir -p $(CAND_DIRS)
	@echo '==> deploy dotfiles to home.'
	@echo ''
	$(foreach val, $(CAND_LINKS), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo '==> link terminfo dir to ~/.terminfo which has xterm-256color'
	@echo ''
	@$(foreach val, $(TERMINFO_DIRS), \
		[ $$(find $(val) -name "xterm-256color"|wc -l) -gt 0 ] && ln -sfn $(val) $(HOME)/.terminfo || : \
		;)

.PHONY: clean
clean: ## Remove the dot files and this repo
	@echo 'Remove dot files in your home directory...'
	@$(foreach val, $(CAND_LINKS), rm -vrf $(HOME)/$(val);)
	@rm -rf $(DOTPATH)
