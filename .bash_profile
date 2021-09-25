if [ -r ~/.bashrc ]; then
  source ~/.bashrc
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/vagrant/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/vagrant/miniconda/etc/profile.d/conda.sh" ]; then
        . "/home/vagrant/miniconda/etc/profile.d/conda.sh}"
    else
        export PATH="/home/vagrant/miniconda/bin/:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

if [ -r ~/.profile ]; then
  source ~/.profile
fi
