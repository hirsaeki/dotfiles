set -U FZF_LEGACY_KEYBINDINGS 0
fish_vi_key_bindings
eval (direnv hook fish)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/vagrant/miniconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

