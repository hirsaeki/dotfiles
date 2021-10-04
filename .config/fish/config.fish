set -U FZF_LEGACY_KEYBINDINGS 0
fish_vi_key_bindings
eval (direnv hook fish)

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/vagrant/miniconda/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

complete --command awsv1 --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); /home/vagrant/.local/share/aws-cli/v1/bin/aws_completer | sed \'s/ $//\'; end)'
