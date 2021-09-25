if [-f ~/.bashrc ]; then
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

# for x2go
if type x2goagent 2> /dev/null ; then
  XDG_DATA_DIRS=/usr/share/mate:/usr/share/mate:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
  GSETTINGS_SCHEMA_DIR=$XDG_DATA_DIRS
  export XDG_DATA_DIRS GSETTINGS_SCHEMA_DIR
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

