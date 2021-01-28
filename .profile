# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export GSETTINGS_SCHEMA_DIR=/usr/share/mate:/usr/share/mate:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
export XDG_DATA_DIRS=/usr/share/mate:/usr/share/mate:/usr/local/share/:/usr/share/:/var/lib/snapd/desktop
export PATH=/home/hsaeki/dotfiles/.local/share/pypy2.7-v7.3.3-linux64/bin/:$PATH
export PATH=/home/hsaeki/dotfiles/.local/share/pypy3.7-v7.3.3-linux64/bin/:$PATH
