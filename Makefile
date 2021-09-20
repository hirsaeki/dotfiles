SHELL      = /bin/bash
F_CAND     := .??* ??*/* .local/*/ .local/*/* .config/*/ .config/*/* .config/dein.vim
F_DIRS     := .vim/ .dircolors/ .local/ .local/%/ .config/ .config/fish/ .config/nvim/ .config/tmux/
F_EXCL     := .DS_Store .git% .gitmodules .travis.yml .local/appimages% .config/dein.vim/% .config .local .vim 
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
CONDA_ENVS := nvim nvim3

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
init: ## intialize dotfiles path
	@echo '==> install appimages from github'
	@echo ''
	@$(foreach val, $(APPIMAGES),\
		echo '==> install $(call dot-split,$(val),1)'; \
		echo '==> appimage is $(call appimage-subpath,$(val))'; \
		curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/download/$(call appimage-subpath,$(val)) -o .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		chmod +x .local/appimages/$(notdir $(call appimage-subpath,$(val))) &&\
		ln -fn $(abspath .local/appimages/$(notdir $(call appimage-subpath,$(val)))) .local/bin/$(call dot-split,$(val),2) ||\
		: ;)
	@echo '==> install tfenv.'
	@echo ''
	@git clone https://github.com/tfutils/tfenv.git .local/share/tfenv 2> /dev/null || :
	@echo '==> install direnv.'
	@echo ''
	@curl -sL https://github.com/direnv/direnv/releases/latest/download/direnv.linux-amd64 -o .local/bin/direnv 2> /dev/null || :
	@chmod +x .local/bin/direnv
	@echo '==> install terraform-ls.'
	@echo ''
	@$(eval LS_VER := $(shell curl -sL https://releases.hashicorp.com/terraform-ls|grep href=\"/terraform |head -n 1 | awk -F/ '{print $$3}'))
	@curl -sL https://releases.hashicorp.com/terraform-ls/$(LS_VER)/terraform-ls_$(LS_VER)_linux_amd64.zip -o terraform-ls.zip 2> /dev/null || :
	@unzip -u terraform-ls.zip && mv terraform-ls .local/bin && rm terraform-ls.zip
	@echo '==> install govc.'
	@curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(shell uname -s)_$(shell uname -m).tar.gz" | tar -C .local/bin -xvzf - govc || :
	@echo '==> modify .bashrc for conda.'
	@echo ''
	@grep -q "conda initialize" .bashrc || _CONDA_ROOT=$(HOME)/miniconda ./conda_bashrc.sh
	@echo '==> install tmux plugin manager'
	@echo ''
	@git clone https://github.com/tmux-plugins/tpm .tmux/plugins/tpm || :
	@echo '==> clone dircolors'
	@echo ''
	@test ! -d .dircolors && mkdir -p .dircolors && curl -sL https://github.com/seebi/dircolors-solarized/archive/master.tar.gz| tar -xzf - -C .dircolors --strip-component=1 --exclude='img' || :

.PHONY: deploy
deploy: ## ensure directories and create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> install deno'
	@$(eval GLIBVER := $(shell printf $$(ldd --version|awk 'NR==1 {print $$NF}')'\n2.18' | sort -V |head -n 1))
	if [[ "$(GLIBVER)" == "2.18" ]]; then \
	echo '==> install binary'; \
	curl -fsSL https://deno.land/x/install/install.sh | sh; \
	else \
	echo '==> install by rust'; \
	conda install -y rust; \
	conda clean --all; \
	cargo install deno --locked; \
	fi
	@echo '==> create directories.'
	@echo ''
	$(foreach val, $(CAND_DIRS), [ -L $(HOME)/$(val:/=) ] && unlink $(HOME)/$(val:/=) || : ;)
	@mkdir -p $(patsubst %,$(HOME)/%,$(CAND_DIRS))
	@echo '==> deploy dotfiles to home.'
	@echo ''
	@mkdir -p ~/.orig
	$(foreach val, $(CAND_LINKS), [ -L $(HOME)/$(val) ] && unlink $(HOME)/$(val) || mv $(HOME)/$(val) $(HOME)/.orig/$(basename $(val)); ln -sfT $(abspath $(val)) $(HOME)/$(val);)
	@mv ~/.bash_profile ~/.orig 2> /dev/null || :
	@echo '===> Restore additional conda envs'
	@echo ''
	@$(foreach val, $(CONDA_ENVS), conda env create -f=$(val).yml 2>/dev/null || :;)
	@echo '==> install aws cli'
	@echo ''
	@$(foreach val, ~/.local/bin/aws ~/.local/share/aws-cli, rm -rf $(val))
	@$(eval TMP := $(shell mktemp -d))
	@curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$(TMP)/awscliv2.zip" && cd $(TMP) && unzip awscliv2.zip && ./aws/install -i ~/.local/share/aws-cli -b ~/.local/bin || :
	@rm -rf $(TMP)
	@echo '==> install aws cli v1'
	@echo ''
	@$(foreach val, ~/.local/bin/aws-v1 ~/.local/share/aws-cli-v1, rm -rf $(val))
	@$(eval TMP := $(shell mktemp -d))
	@curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "$(TMP)/awscli-bundle.zip" && cd $(TMP) && unzip awscli-bundle.zip && ./awscli-bundle/install -i ~/.local/share/aws-cli-v1 -b ~/.local/bin/aws-v1 || :
	@rm -rf $(TMP)
	@echo '==> aws session manager'
	@echo ''
	@$(eval TMP := $(shell mktemp -d))
	@curl -o $(TMP)/session-manager-plugin.deb -L https://s3.amazonaws.com/session-manager-downloads/plugin/1.2.30.0/ubuntu_64bit/session-manager-plugin.deb
	@cd $(TMP) && dpkg-deb -x session-manager-plugin.deb session-manager-plugin && cp session-manager-plugin/usr/local/sessionmanagerplugin/bin/session-manager-plugin ~/.local/bin/session-manager-plugin || :
	@rm -rf $(TMP)
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

