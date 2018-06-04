[ -e ~/.zplug/init.zsh  ] ||
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
source ~/.zplug/init.zsh

# ここに必要なプラグインやテーマを書く
# Load theme file
zplug "plugins/git",   from:oh-my-zsh

zplug "mafredri/zsh-async", from:github
zplug "nojhan/liquidprompt", from:github
#zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions", defer:2

zplug "~/.zsh", from:local

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

#PROMPT='%S%n%s%m%S%1~%s%(!.#.%%) '
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=0'

HISTFILE=~/.zsh_history   # ヒストリを保存するファイル
HISTSIZE=10000            # メモリに保存されるヒストリの件数
SAVEHIST=10000            # 保存されるヒストリの件数

[ -e $ZDOTDIR/.zshrc_local ] && . $ZDOTDIR/.zshrc_local 
[ -e ${HOME}/.dircolors.ansi-dark ] && eval $(dircolors ${HOME}/.dircolors.ansi-dark)

alias ls="ls --color"
alias ll="ls -lh"
alias vi="nvim"
