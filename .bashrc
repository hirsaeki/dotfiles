# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
# ignore dup and whitespace
export HISTCONTROL=ignoreboth
# ignore commands
export HISTIGNORE="fg*:bg*:history*"
export HISTSIZE=10000

# Make bash append rather than overwrite the history on disk
shopt -s histappend
# Whenever displaying the prompt, write the previous line to disk
export PROMPT_COMMAND="history -a"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
export SYSTEMD_PAGER=less

export PS1="\[\e]0;\u@\h: \w\a\]\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "
# User specific aliases and functions
[ -e ${HOME}/.dircolors.ansi-dark ] && eval $(dircolors ${HOME}/.dircolors.ansi-dark)
alias vi='nvim'
alias ansible-playbook='env LANG=en_US.UTF-8 ansible-playbook'
alias ls="ls --color"
stty stop undef
