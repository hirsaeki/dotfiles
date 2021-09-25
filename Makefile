SHELL      = /bin/bash
F_CAND     := .??*
DIRS       := .local/bin .local/share/appimages
F_EXCL     := .DS_Store .git .gitignore .gitmodules .travis.yml
DOTPATH    = $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES = $(filter-out $(F_EXCL), $(wildcard $(F_CAND)))
GITHUB     := https://github.com
APPIMAGES  := neovim/neovim.nvim

dot-split = $(word $2,$(subst ., ,$1))
hat-split = $(word $2,$(subst ^, ,$1))
appimage-subpath = $(shell curl -sL $(GITHUB)/$(call dot-split,$1,1)/releases/latest|grep -i "href.*$(call dot-split,$1,2).*\.appimage\""|grep -v -i -e "-rc-" -v -e "HEAD"|sort|tail -n 1|sed 's:.*/\(.*/.*\.appimage\).*:\1:I')
CONDA_ENVS := py2nvim^2 py3nvim^3
CONDA_PKGS := git fish tmux powerline-status jq yq

.DEFAULT_GOAL := help

.PHONY: all
all:

test:
	echo $(foreach val, $(CANDIDATES), $(HOME)/$(val))

.PHONY: show
show: ## show deploy candidates
	@echo "directories ==> $(DIRS)"
	@echo "links ==> $(CANDIDATES)"

.PHONY: init
init: ## intialize dotfiles realpath
	@echo '==> clone dircolors'
	@echo ''
	@test ! -d dircolor-solarized && mkdir -p dircolor-solarized && curl -sL $(GITHUB)/seebi/dircolors-solarized/archive/master.tar.gz| tar -xzf - -C dircolor-solarized --strip-component=1 --exclude='img' || :
	@echo '==> set .dir_colors'
	@echo ''
	@cp dircolor-solarized/dircolors.256dark .dir_colors

.PHONY: deploy
deploy: ## ensure directories and create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@echo '==> create directories.'
	@echo ''
	@cd $(HOME) && mkdir -p $(DIRS)
	@echo '==> deploy dotfiles to home.'
	@echo ''
	@echo '==> preserve original dotfiles'
	@echo ''
	@mkdir -p $(HOME)/.default_dotfiles.d
	@if [ -z "$$(ls -A $(HOME)/.default_dotfiles.d)" ]; then \
		$(foreach val, $(CANDIDATES), if [ -L $(HOME)/$(val) ]; then unlink $(HOME)/$(val); elif [ -e $(HOME)/$(val) ]; then mv $(HOME)/$(val) $(HOME)/.default_dotfiles.d; fi;) \
		else \
		$(foreach val, $(CANDIDATES), [ -L $(HOME)/$(val) ] && unlink $(HOME)/$(val) || rm -rf $(HOME)/$(val);) \
		fi
	@$(foreach val, $(CANDIDATES), ln -sfn $(realpath $(val)) $(HOME);)
	@echo '==> install appimages from github'
	@echo ''
	@mkdir -p $(HOME)/.local/appimages
	@$(foreach val, $(APPIMAGES),\
		if ! type $(call dot-split,$(val),2); then \
		echo '==> install $(call dot-split,$(val),1)'; \
		echo '==> appimage is $(call appimage-subpath,$(val))'; \
		curl -sL $(GITHUB)/$(call dot-split,$(val),1)/releases/download/$(call appimage-subpath,$(val)) -o $(HOME)/.local/share/appimages/$(notdir $(call appimage-subpath,$(val))) && \
		chmod +x $(HOME)/.local/share/appimages/$(notdir $(call appimage-subpath,$(val))) && \
		ln -sfn $(HOME)/.local/share/appimages/$(notdir $(call appimage-subpath,$(val))) $(HOME)/.local/bin/$(call dot-split,$(val),2); \
		fi;)
	@echo '==> install direnv.'
	@echo ''
	@source $(HOME)/.bash_profile && \
		curl -sfL https://direnv.net/install.sh | bash

.PHONY: conda-base
conda-base: ## initialize base env via miniconda+conda-forge with essential package. e.g. fish, tmux
	@echo '==> install miniconda'
	@echo ''
	@if ! type conda > /dev/null 2>&1; then \
		curl -L https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o ./miniconda.sh && \
		bash ./miniconda.sh -b -p $(HOME)/miniconda && \
		eval "$$($(HOME)/miniconda/bin/conda shell.bash hook)" && \
		echo '==> setup conda and install packages' && \
		conda config --add channels conda-forge && \
		conda config --set channel_priority strict && \
		conda update --all -y && \
		conda install -y $(CONDA_PKGS) && \
		conda clean --all -y && \
		rm ./miniconda.sh
	@echo '==> install tmux plugin manager'
	@echo ''
	@eval "$$($(HOME)/miniconda/bin/conda shell.bash hook)" && git clone $(GITHUB)/tmux-plugins/tpm $${HOME}/.config/tmux/plugins/tpm || :
	@echo '==> setup powerline-status'
	@echo ''
	@for i in $$(find $(HOME)/miniconda/lib -path "*/powerline/bindings/tmux/__init__.py"); do \
		patch --forward -fs $${i} < ./etc/powerline-status.patch; \
		done;
	@for i in $$(find $(HOME)/miniconda/lib -path "*/powerline/bindings/tmux/powerline.conf"); do \
		sed -i '/tmux\/powerline.conf/s#.*#source '$${i}'#' $(HOME)/.config/tmux/tmux.conf; \
		done
	@echo '==> setup fish'
	@echo ''
	@eval "$$($(HOME)/miniconda/bin/conda shell.bash hook)" && \
		conda init fish && \
		/usr/bin/env fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher" && \
		/usr/bin/env fish -c "fisher update" && \
		patch --forward -fs ~/.config/fish/functions/fish_prompt.fish < ./etc/fish_prompt.patch && \
		/usr/bin/env fish -c "abbr -a vi nvim"; \
	@echo '===> create additional conda envs'
	@echo ''
	@$(foreach val, $(CONDA_ENVS), conda create -y -n $(call hat-split,$(val),1) python=$(call hat-split,$(val),2);)
	@eval "$$(conda shell.bash hook)" && $(foreach val, $(CONDA_ENVS), conda activate $(call hat-split,$(val),1) && conda install -y pynvim && conda deactivate;)

.PHONY: aws-tools
aws-tools: ## initialize aws-tools
	@echo '==> install awscli v1 via conda'
	@echo ''
	@eval "$$($(HOME)/miniconda/bin/conda shell.bash hook)" && \
		conda install awscli
	@echo '==> create symlink as awsv1'
	@echo ''
	@ln -sfn $(HOME)/miniconda/bin/aws $(HOME)/.local/bin/awsv1
	@echo '==> set v1 completion on fish'
	@echo ''
	@grep -q "miniconda/bin/aws_completer" $(HOME)/.config/fish/fish.config || \
		echo "complete --command awsv1 --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); \$${HOME}/miniconda/bin/aws_completer | sed \'s/ $$//\'; end)'" >> $(HOME)/.config/fish/fish.config
	@echo '==> install aws cli v2 <amazon recommends not to use package manager like pip for v2>)'
	@echo ''
	@rm -rf .local/bin/aws .local/share/aws-cli
	@$(eval TMP := $(shell mktemp -d))
	@curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "$(TMP)/awscliv2.zip" && cd $(TMP) && unzip awscliv2.zip && ./aws/install -i ~/.local/share/aws-cli -b ~/.local/bin || :
	@rm -rf $(TMP)
	@echo '==> set v2 completion on fish'
	@echo ''
	@grep -q "\.local/bin/aws_completer" .config/fish/fish.config || \
		echo "complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); \$${HOME}/.local/bin/aws_completer | sed \'s/ $$//\'; end)'" >> $(HOME)/.config/fish/fish.config
	@echo '==> install aws session-manager-plugin'
	@echo ''
	@$(eval TMP := $(shell mktemp -d))
	@curl -o $(TMP)/session-manager-plugin.deb -L https://s3.amazonaws.com/session-manager-downloads/plugin/latest/ubuntu_64bit/session-manager-plugin.deb
	@cd $(TMP) && ar p session-manager-plugin.deb data.tar.gz | tar -zx && cp session-manager-plugin/usr/local/sessionmanagerplugin/bin/session-manager-plugin ~/.local/bin/session-manager-plugin || :;
	@rm -rf $(TMP)
	@echo '==> install aws-mfa via pip on conda'
	@echo ''
	@eval "$$($(HOME)/miniconda/bin/conda shell.bash hook)" && \
		pip install aws-mfa

.PHONY: infra-tools
infra-tools: ## install infra-tools
	@echo '==> install tfenv'
	@echo ''
	@git clone $(GITHUB)/tfutils/tfenv.git $(HOME)/.local/share/tfenv 2> /dev/null || :
	@ln -sfn $(HOME)/.local/share/tfenv/bin/* $(HOME)/.local/bin
	@echo '==> install tgenv'
	@echo ''
	@git clone $(GITHUB)/cunymatthieu/tgenv.git $(HOME)/.local/share/tgenv 2> /dev/null || :
	@ln -sfn $(HOME)/.local/share/tgenv/bin/* $(HOME)/.local/bin
	@echo '==> install terraform-ls.'
	@echo ''
	@$(eval LS_VER := $(shell curl -sL https://releases.hashicorp.com/terraform-ls|grep href=\"/terraform |head -n 1 | awk -F/ '{print $$3}'))
	@curl -sL https://releases.hashicorp.com/terraform-ls/$(LS_VER)/terraform-ls_$(LS_VER)_linux_amd64.zip -o terraform-ls.zip 2> /dev/null || :
	@unzip -u terraform-ls.zip && mv terraform-ls $(HOME)/.local/bin && rm terraform-ls.zip
	@echo '==> install govc.'
	@curl -L -o - "https://github.com/vmware/govmomi/releases/latest/download/govc_$(shell uname -s)_$(shell uname -m).tar.gz" | tar -C $(HOME)/.local/bin -xvzf - govc || :

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
